module SDcontroller(
	input _cs_drive,
	input _rd,
	input _wr,
	input _cs_buffer,
	input [1:0] addr,
	input clk,
	input card_det,

	output _den,
	output sd_busy,
	output _ram_oe,
	output _ram_we,
	output sd_irq,
	output ld_gn,
	output ld_rd,
	
	output [8:0] ram_addr,
	inout [7:0] data,
	inout [7:0] ram_data,	

	output sd_cs,
	input miso,
	output reg sclk,
	output reg mosi
);

// internal
reg [7:0] control = 8'b00001000;		// control register (0..2: clock divider, 3: SD_CS, 4: LED gn, 5: LED rd)
reg [7:0] status;
reg [7:0] txdata;
reg [7:0] rxdata;
reg [7:0] data_out;
reg [7:0] data_out_en;
reg [7:0] shift_register;
reg [3:0] count;
reg [7:0] clk_divide;
reg slave_cs = 1;
reg spi_word_send;

wire spi_clk_gen;
wire [2:0] divide_factor = control[2:0];

assign sd_cs = control[3];
assign ld_gn = control[4];
assign ld_rd = control[5];
assign sd_busy = ~slave_cs;
assign sd_irq = 0;

// SPI clock
assign spi_clk_gen = clk_divide[divide_factor];

// clock divider for SPI clock
always @ (negedge clk) begin
    clk_divide = clk_divide + 8'd1;
end

// registers
// 0: control (read, write)
// 1: status (read)
// 2: data (read, write)
always @(posedge clk)
begin
	if (~_cs_drive)
	begin
		if (~_wr)
		begin
			case (addr)
				2'b00: control <= data;
				2'b10: txdata <= data;
			endcase
		end
		else if (~_rd)
		begin
			case (addr)
				2'b00: data_out <= control;
				2'b01: data_out <= status;
				2'b10: data_out <= rxdata;
			endcase
		end
	end
end

/* Reading the miso line and shifting */
always @ (posedge sclk or posedge spi_word_send)
begin
	if (spi_word_send)
		shift_register[7:0] = txdata;
	else begin
		shift_register = shift_register << 1;
		shift_register[0] <= miso;
   end
end

/* Writing the mosi */
always @ (negedge sclk or posedge spi_word_send)
begin
	if (spi_word_send)
		mosi = txdata[7];
	else
		mosi = shift_register[7];
end

/* Contolling the interrupt bit in the status bit */
always @ (posedge slave_cs or posedge spi_word_send)
begin
	if (spi_word_send)
		status[0] = 0;
	else begin
		status[0] = 1;
		rxdata = shift_register; // updating read buffer
	end
end

/* New SPI word starts when the transmit buffer is updated */
always @ (posedge clk)
begin
	if (spi_word_send)
		slave_cs = 0;
   else if (count == 8 & ~sclk)
		slave_cs = 1;
end

/* New Spi word is intiated when transmit buffer is updated */
always @ (posedge clk)
begin
	if (~_cs_drive & ~_wr & addr == 2'b10)
		spi_word_send <= 1;
	else
		spi_word_send <= 0;
end

/* Generating the SPI clock */
always @ (posedge spi_clk_gen)
begin
	if (~slave_cs)
		sclk = ~sclk;
   else
		sclk = 0;
end

/* Counting SPI word length */
always @ (posedge sclk or posedge slave_cs)
begin
	if (slave_cs)
		count = 0;
   else
		count = count + 4'd1;
end

/* Controlling the data out enable */
always @ (_rd or _cs_drive or data_out)
begin
	if (~_rd && ~_cs_drive)
		data_out_en <= data_out;
	else
		data_out_en <= 8'bz;
end

assign data = data_out_en;

endmodule