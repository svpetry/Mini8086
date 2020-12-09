module VGAreg(
	// inputs
	addr,
	_vga_io,
	_wr,
	_char_bg,
	_reset,
	vsync,
	hsync,
	
	// outputs
	dcol,
	mode,
	plane,
	irq,
	
	// mixed
	data
);

input[1:0] addr;
input _vga_io;
input _wr;
input _char_bg;
input _reset;
input vsync;
input hsync;

output[7:0] dcol = 8'bzzzzzzzz;
output[1:0] mode;
output plane;
output irq;

inout[7:0] data;

reg[7:0] bgcol_reg;
reg[7:0] dcol;
wire[7:0] data;
reg[1:0] mode;
reg plane;
reg en_irq;
wire irq;

wire[7:0] data_in;
reg[7:0] data_out;
reg[7:0] data_out_en;

assign data_in = data;
assign data = data_out_en;

// generate vsync IRQ if enabled
assign irq = en_irq && vsync == 0 ? 1'b1 : 1'b0;

always @(*)
begin
	if (_reset == 0)
	begin
		// reset registers
		data_out <= 8'd0;
		bgcol_reg <= 8'd0;
		mode <= 2'b00;
		en_irq <= 0;
		plane <= 0;
	end
	else if (_vga_io == 0)
	begin	
		if (_wr == 0)
		begin
			// write control register
			if (addr == 2'd0)
			begin
				mode <= data_in[1:0];
				plane <= data_in[2];
				en_irq <= data_in[3];
			end
			// write background color register
			else if (addr == 2'd1)
				bgcol_reg <= data_in;
		end
		else
		begin
			// read control register
			if (addr == 2'd0)
			begin
				data_out[1:0] <= mode;
				data_out[2] <= plane;
				data_out[3] <= en_irq;
				data_out[4] <= vsync;
				data_out[5] <= hsync;
			end
			// read background color register
			else if (addr == 2'd1)
				data_out <= bgcol_reg;
		end
	end
end

always @(*)
begin
	if (_vga_io == 0 && _wr == 1)
		data_out_en <= data_out;
	else
		data_out_en <= 8'bzzzzzzzz;
end

// enable background color
always @(*)
begin
	if (_char_bg == 0)
		dcol <= bgcol_reg;
	else
		dcol <= 8'bzzzzzzzz;
end

endmodule