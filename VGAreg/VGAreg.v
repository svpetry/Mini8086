module VGAreg(
	// inputs
	addr,
	_vga_io,
	_wr,
	_char_bg,
	_reset,
	
	// outputs
	dcol,
	
	// mixed
	data,
);

input [1:0]addr;
input _vga_io;
input _wr;
input _char_bg;
input _reset;

output [7:0]dcol;

inout [7:0]data;

reg[7:0] bgcol_reg;
reg[7:0] ctrl_reg;
	
always @(_vga_io or _wr)
begin
	if (_vga_io == 0)
	begin	
		if (_wr == 0)
		begin
			if (addr == 2'd1)
				bgcol_reg <= data;
		end
	end
end



endmodule