module Decoder(
	input [7:0] ADDR, // address bits 3..10
	input WR,
	input RD,
	input M_IO,
	
	output reg CS_UART,
	output reg CS_8042,
	output reg CS_I2C,
	output reg CS_DRIVE
);

always @(*)
begin
	CS_8042 <= 0;
	CS_I2C <= 0;
	CS_UART <= 0;
	CS_DRIVE <= 0;
	if (~M_IO && (~WR || ~RD))
	begin
		CS_8042 <= ADDR == 8'b00001100; // 0x60
		CS_I2C <= ADDR == 8'b00001110; // 0x70
		CS_UART <= ADDR == 8'b00010000; // 0x80
		CS_DRIVE <= ADDR == 8'b00010010; // 0x90
	end
end


endmodule