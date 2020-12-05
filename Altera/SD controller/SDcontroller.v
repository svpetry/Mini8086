module SDcontroller(
	_reset,
	_cs_drive,
	_rd,
	_wr,
	_wr_buffer,
	addr,
	clk
	card_det,
	sd_busy,
	_ram_oe,
	_ram_we,
	
	ram_addr,
	data,
	ram_data,
	
	);

input _reset;
input _cs_drive;
input _rd;
input _wr;
input _wr_buffer;
input [1:0]addr;
input clk;
input card_det;

inout [7:0]data;
inout [7:0]ram_data;

output sd_busy;
output _ram_oe;
output _ram_we;
output [8:0]ram_addr;


endmodule