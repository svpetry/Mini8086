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
	output LD_BL,
	output CS_UART,
	output CS_8042,
	output CS_I2C,
	
	inout [7:0] DATA,

	output SD_CS,
	input MISO,
	output reg SCLK,
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
reg [7:0] txdata;
reg [7:0] rxdata;
reg [7:0] data_out;
reg [7:0] data_out_en;
reg [7:0] shift_register;
reg [3:0] count;
reg [7:0] clk_divide = 0;
reg slave_cs = 1;
reg spi_word_send;
reg [1:0]write_active;

wire spi_clk_gen;
wire [2:0] divide_factor = control[2:0];

wire [1:0] irq_ctrl;
wire cs_drive;

assign SD_CS = control[3];
assign LD_GN = control[4];
assign LD_RD = control[5];
assign status[0] = ~slave_cs;
assign status[1] = CARD_DET;
assign irq_ctrl = control[7:6];

// SPI clock
assign spi_clk_gen = clk_divide[divide_factor];

// clock divider for SPI clock
always @ (negedge clk)
begin
    clk_divide = clk_divide + 8'd1;
end

Decoder decoder(AL[7:0], WR, RD, M_IO, CS_UART, CS_8042, CS_I2C, cs_drive);

// registers
// 0: control (read, write)
// 1: status (read)
// 2: DATA (read, write)
always @(posedge clk)
begin
	if (cs_drive)
	begin
		if (~WR)
		begin
			case (ADDR)
				2'b00: control <= DATA;
				2'b10: txdata <= DATA;
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

/* Reading the MISO line and shifting */
always @(posedge SCLK or posedge spi_word_send)
begin
	if (spi_word_send)
		shift_register[7:0] = txdata;
	else begin
		shift_register = shift_register << 1;
		shift_register[0] <= MISO;
   end
end

/* Writing the MOSI */
always @(negedge SCLK or posedge spi_word_send)
begin
	if (spi_word_send)
		MOSI = txdata[7];
	else
		MOSI = shift_register[7];
end

// interrupt control
always @(posedge clk)
begin
//	case (irq_ctrl)
//		2'd1: begin
//			
//		end
//	endcase
//
//	if (spi_word_send)
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

// read buffer
always @(posedge slave_cs)
begin
	rxdata = shift_register; // updating read buffer
end

/* New SPI word starts when the transmit buffer is updated */
always @(posedge clk)
begin
	if (spi_word_send)
		slave_cs = 0;
   else if (count == 8 & ~SCLK)
		slave_cs = 1;
end

/* New Spi word is intiated after transmit buffer has been updated */
always @(posedge clk)
begin
	write_active[1] = write_active[0];
	if (cs_drive & ~WR & ADDR == 2'b10)
		write_active[0] = 1;
	else
		write_active[0] = 0;
	spi_word_send <= ~write_active[0] && write_active[1];
end

/* Generating the SPI clock */
always @(posedge spi_clk_gen)
begin
	if (~slave_cs)
		SCLK = ~SCLK;
   else
		SCLK = 0;
end

/* Counting SPI word length */
always @(posedge SCLK or posedge slave_cs)
begin
	if (slave_cs)
		count = 0;
   else
		count = count + 4'd1;
end

/* Controlling the DATA out enable */
always @(RD or cs_drive or data_out)
begin
	if (~RD && cs_drive)
		data_out_en <= data_out;
	else
		data_out_en <= 8'bz;
end

assign DATA = data_out_en;

endmodule