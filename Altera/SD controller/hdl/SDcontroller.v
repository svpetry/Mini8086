module SDcontroller(
	input M_IO,
	input RD,
	input WR,
	input [1:0] ADDR,
	input [7:0] AL,
	input CARD_DET,
	input clk,

	output DEN,
	output reg SD_IRQ,
	output LD_GN,
	output LD_RD,
	output reg LD_BL,
	output CS_UART,
	output CS_8042,
	output CS_I2C,
	
	inout [7:0] DATA,

	output SD_CS,
	input MISO,
	output SCLK,
	output reg MOSI
);

/*
	control register
		bit	function
		0..2	clock divider
		3		SD_CS
		4		LED green
		5		LED red
		6..7	interrupt (0 = no IRQ, 1 = IRQ on card insert, 2 = IRQ on op finished)
		
	status register
		bit	function
		0		1 = busy, 0 = idle
		1		1 = card inserted, 0 = no card

*/

// internal
reg [7:0] control = 8'b00001000;		// control register (0..2: clock divider, 3: SD_CS, 4: LED gn, 5: LED rd)
wire [7:0] status; 						// status register (0: busy)
reg [7:0] txdata = 0;
reg [7:0] rxdata = 0;
reg [7:0] data_out = 0;
reg [7:0] data_out_en = 8'bz;
reg [7:0] shift_register = 0;
reg [3:0] count = 0;
reg [7:0] clk_divide = 0;
reg spi_active = 0;
reg spi_start = 0;
reg [1:0] write_active = 0;
reg [1:0] sclk_reg = 0;
reg [11:0] led_count = 0;

wire spi_clk_gen;
reg sclk_int = 0;
wire [2:0] divide_factor = control[2:0];

wire [1:0] irq_ctrl;
wire cs_drive;

assign SD_CS = control[3];
assign LD_GN = control[4];
assign LD_RD = control[5];
assign status[0] = spi_active;
assign status[1] = ~CARD_DET;
assign irq_ctrl = control[7:6];

// SPI clock
assign spi_clk_gen = clk_divide[divide_factor];

// clock divider for SPI clock
always @(posedge clk)
begin
    clk_divide = clk_divide + 8'd1;
end

// generate the SPI clock
always @(posedge spi_clk_gen)
begin
	sclk_int <= ~sclk_int;
end
assign SCLK = spi_active ? sclk_int : 0;

Decoder decoder(AL[7:0], WR, RD, M_IO, CS_UART, CS_8042, CS_I2C, cs_drive);

// blue I/O led
always @(posedge clk)
begin
	if (CS_UART || CS_8042 || CS_I2C || cs_drive)
		led_count = 12'hFFF;
	
	if (led_count > 0)
	begin
		led_count = led_count - 12'd1;
		LD_BL <= 1;
	end
	else
		LD_BL <= 0;
end

/*
always @(posedge clk)
begin
	if (init_done)
	begin
		LD_BL = ~CARD_DET;
	
	end
	else begin
		LD_BL = 0;
		if (clk_divide == 8'hFF)
			init_done = 1;
	end
end
*/

// registers
// 0: control (read, write)
// 1: status (read)
// 2: DATA (read, write)
always @(posedge clk)
begin
	write_active[1] = write_active[0];
	write_active[0] = 0;

	if (cs_drive)
	begin
		if (~WR)
		begin
			case (ADDR)
				2'b00: control <= DATA;
				2'b10: begin
					txdata = DATA;
					write_active[0] = 1;
				end
			endcase
		end
		else if (~RD)
		begin
			case (ADDR)
				2'b00: data_out <= control;
				2'b01: data_out <= status;
				2'b10: data_out <= rxdata;
			endcase
		end
	end
end

always @(negedge clk)
begin
	sclk_reg[1] = sclk_reg[0];
	sclk_reg[0] = sclk_int;
	
	if (~write_active[0] && write_active[1])
		spi_start = 1;

	// negedge sclk_int
	if (~sclk_reg[0] && sclk_reg[1])
	begin
		MOSI = 0;
		
		if (spi_start)
		begin
			shift_register = txdata;
			spi_active = 1;
			count = 0;
			MOSI = txdata[7];
		end
		else if (spi_active)
			MOSI = shift_register[7];

		if (spi_active)
		begin
			if (count == 8)
			begin
				spi_active = 0;
				rxdata = shift_register;
			end
			else
				shift_register = shift_register << 1;
		end
	end
	
	// posedge sclk_int
	if (sclk_reg[0] && ~sclk_reg[1])
	begin
		if (spi_active)
		begin
			spi_start = 0;
			shift_register[0] = MISO;
			count = count + 4'd1;
		end
	end
end
assign DEN = cs_drive;

// interrupt control
always @(posedge clk)
begin
//	case (irq_ctrl)
//		2'd1: begin
//			
//		end
//	endcase
//
//	if (spi_start)
//	begin
//		if (irq_ctrl == 2)
//			SD_IRQ = 0;
//	end
//	else begin
//		if (irq_ctrl == 2)
//			SD_IRQ = 1;
//	end
	
//	if (irq_ctrl == 3)
end

// data out
always @(*)
begin
	if (~RD && cs_drive)
		data_out_en <= data_out;
	else
		data_out_en <= 8'bz;
end
assign DATA = data_out_en;

endmodule
