module Main(
	input clk,

	input BHE_S7,
	input DT_R,
	input DEN,
	input ALE,
	input M_IO,
	input WR,
	input RD,
	input INTA,
	input RDY1,
	input RDY2,
	
	output reg MEMRD = 1,
	output reg MEMWR = 1,
	output reg ROMRD = 1,
	output reg IO_TIMER = 1,
	output reg IO_PIC = 1,
	output reg IO_DBG = 1,
	output reg VGA_MEM = 1,
	output reg VGA_IO = 1,
	output reg BHE,
	output reg [1:0] RAM_CE = 2'b11,
	output reg DATA_DIR,
	output DATA_DIR_NEG,
	output reg LMEMWR = 1,
	output reg LMEMRD = 1,
	output reg OE_DATA = 1,
	output reg CPU_CLK,
	output reg READY,
	output RESET,
	output reg PCLK,
	output reg PIT_CLK,
	output reg INFO_LED,
	
	output reg [19:0] ADDR,
	inout [15:0] DATA,
	inout [19:0] LAD
);

reg clk2;
reg [1:0] cpuclk_state;
reg [3:0] reset_cnt = 4'b1111;
reg [3:0] tmrclk_cnt;
reg io_chipset;

reg [15:0] data_out = 16'bz;
reg [15:0] lad_out = 16'bz;

reg [7:0] command_reg = 8'd0;
wire [1:0] ram_bank;

reg addr_overload_en;
reg [1:0] addr_overload;

reg led_blink;
reg [24:0] blink_counter;

// 30 MHz internal clock generation
always @(posedge clk)
begin
	clk2 = ~clk2;
end

// CPU clock generation
always @(posedge clk2)
begin
	case (cpuclk_state)
		2'd0: begin
			CPU_CLK <= 1;
			cpuclk_state <= 2'd1;
		end
		2'd1: begin
			CPU_CLK <= 0;
			cpuclk_state <= 2'd2;
		end
		2'd2: begin
			cpuclk_state <= 2'd0;
		end
	endcase
end

// peripheral clock generation
always @(negedge CPU_CLK)
begin
	PCLK <= ~PCLK;
end

// timer clock generation (1 MHz)
always @(posedge clk2)
begin
	if (tmrclk_cnt == 4'd14)
	begin
		PIT_CLK = ~PIT_CLK;
		tmrclk_cnt <= 4'd0;
	end
	else
		tmrclk_cnt <= tmrclk_cnt + 4'd1;
end

// led
always @(*)
begin
	if (RESET)
		led_blink <= 1;
	else
	begin
		// disable blinking LED if start 
		// instruction is addressed by CPU
		if (ADDR == 20'hFFFF0)
			led_blink <= 0;
	end
end

// reset circuit & self test
always @(posedge PCLK)
begin
	if (reset_cnt > 4'd0)
		reset_cnt <= reset_cnt - 4'd1;
end
assign RESET = reset_cnt != 4'd0;


// address decoder
wire [3:0] addr_hi = ADDR[19:16]; // high address
wire [9:0] addr_io = ADDR[9:0]; // I/O address
always @(*)
begin
	LMEMRD <= 1;
	LMEMWR <= 1;
	MEMRD <= 1;
	MEMWR <= 1;
	ROMRD <= 1;
	IO_TIMER <= 1;
	IO_PIC <= 1;
	IO_DBG <= 1;
	VGA_MEM <= 1;
	VGA_IO <= 1;
	io_chipset <= 0;
	
	RAM_CE <= 2'b11;
	OE_DATA <= 1;
	addr_overload_en <= 0;

	if (~RD || ~WR || ~INTA)
	begin
		if (M_IO)
		begin
			// memory access
			if (addr_hi < 4'h8)
			begin
				// 00000-7FFFF: 512 KB RAM
				LMEMRD <= RD;
				LMEMWR <= WR;
				RAM_CE[0] <= 0;
			end
			else if (addr_hi < 4'hC)
			begin
				// 80000-BFFFF: 256 KB banked RAM
				LMEMRD <= RD;
				LMEMWR <= WR;
				
				case (ram_bank)
					2'd0: begin
						RAM_CE[1] <= 0;
					end
					2'd1: begin
						RAM_CE[1] <= 0;
						addr_overload_en <= 1;
						addr_overload <= 2'b01;
					end
					2'd2: begin
						MEMRD <= RD;
						MEMWR <= WR;					
						OE_DATA <= DEN;
					end
					2'd3: begin
						MEMRD <= RD;
						MEMWR <= WR;					
						addr_overload_en <= 1;
						addr_overload <= 2'b01;
						OE_DATA <= DEN;
					end
				endcase
			end
			else if (addr_hi < 4'hE)
			begin
				// C0000-DFFFF: Video RAM
				VGA_MEM <= 0;
				OE_DATA <= DEN;
			end
			else begin
				// E0000-FFFFF: ROM
				ROMRD <= RD;
				OE_DATA <= DEN;
			end
			
		end
		else begin
			// I/O access
			IO_TIMER <= ~(addr_io >= 10'h040 && addr_io <= 10'h047);
			IO_PIC <= ~(addr_io >= 10'h020 && addr_io <= 10'h027);
			IO_DBG <= ~(addr_io >= 10'h010 && addr_io <= 10'h017);
			VGA_IO <= ~(addr_io >= 10'h050 && addr_io <= 10'h057);
			io_chipset <= addr_io >= 10'h030 && addr_io <= 10'h037;
			OE_DATA <= DEN;
		end
	end
end

// CPU interface
assign DATA_DIR_NEG = ~DATA_DIR;

// CPU address
always @(*)
begin
	if (ALE)
	begin
		ADDR[17:0] <= LAD[17:0];
		if (~addr_overload_en)
			ADDR[19:18] <= LAD[19:18];
		BHE <= BHE_S7;
	end
	if (addr_overload_en)
		ADDR[19:18] <= addr_overload[1:0];
end

// CPU data
wire data_lo = ~DEN && (~INTA || ~ADDR[0]);
wire data_hi = ~DEN && ~BHE;
always @(*)
begin
	lad_out <= 16'bz;
	data_out <= 16'bz;
	DATA_DIR <= 0;
	
	if (~M_IO)
	begin
		// I/O access
		if (DT_R)
		begin
			// CPU -> ext
			if (data_lo)
				data_out[7:0] = LAD[7:0];
			else if (data_hi)
				data_out[7:0] = LAD[15:8];
		end
		else begin
			// ext -> CPU
			DATA_DIR <= data_lo || data_hi;
			if (data_lo)
				lad_out[7:0] <= DATA[7:0];
			else if (data_hi)
				lad_out[15:8] <= DATA[7:0];
		end
	end
	else begin
		// memory access
		if (DT_R)
		begin
			// CPU -> ext
			if (data_lo)
				data_out[7:0] <= LAD[7:0];
			if (data_hi)
				data_out[15:8] <= LAD[15:8];
		end
		else begin
			// ext -> CPU
			DATA_DIR <= data_lo || data_hi;
			if (data_lo)
				lad_out[7:0] <= DATA[7:0];
			if (data_hi)
				lad_out[15:8] <= DATA[15:8];
		end
	end
end

assign DATA = data_out;
assign LAD[15:0] = lad_out;

// READY control
always @(negedge CPU_CLK)
begin
	if (RDY1 || RDY2)
		READY <= 1;
	else
		READY <= 0;
end

// chipset control
assign ram_bank = command_reg[1:0];
always @(posedge clk)
begin
	if (io_chipset)
	begin
		case (ADDR[1:0])
			2'd0: begin
				if (~WR)
					command_reg <= DATA[7:0];
			end
			2'd1: begin
			end		
		endcase
	end
end

// LED blinking
always @(posedge clk2)
begin
	if (led_blink)
	begin
		blink_counter <= blink_counter + 25'd1;
		INFO_LED <= blink_counter[24];
	end
	else
		INFO_LED <= 1;
end


endmodule

