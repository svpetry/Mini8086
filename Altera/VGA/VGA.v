module VGA(
		// inputs
		clock,
		_reset,
		_vga_mem,
		addr,
		_rd,
		_wr,
		_bhe,
		charpixel,
		plane,
		mode,
		
		// outputs
		rdy,
		_we_ram,
		_cs_ram,
		_cpu_ram_addr,
		px_clk,
		_oe_latch,
		chrow,
		_charmode,
		_char_bg,
		latch_chr,
		latch_col,
		_pe_chpx,
		_chr_to_col,
		_cpu_ram,
		cpu_ram_dir,
		ram_addr,
		hsync,
		vsync
);

// input signals
input clock; // 50 MHz clock
input _reset; // reset
input _vga_mem; // CPU accesses VGA memory
input [1:0]addr; // A0-A1 from system address bus
input _rd; // CPU read signal
input _wr; // CPU write signal
input _bhe; // BHE signal from CPU
input charpixel; // character pixel signal
input plane; // the graphics memory plane to be displayed
input [1:0]mode; // graphics mode (0 = text, 1 = 320x200x8, 2 = 400x300x8)

// output signals
output rdy; // CPU busy signal
output [3:0]_we_ram; // RAM WE
output [3:0]_cs_ram; // RAM CS
output _cpu_ram_addr; // connect CPU address bus to RAM
output px_clk; // pixel clock for shift register
output [3:0]_oe_latch; // latch OE
output [3:0]chrow; // character row
output _charmode; // enable text mode
output _char_bg; // output background color at character pixel
output latch_chr; // latch byte 0 and 2 from RAM
output latch_col; // latch byte 1 and 3 from RAM
output _pe_chpx; // shift register parallel load
output _chr_to_col; // connect DCHR to DCOL bus
output [3:0]_cpu_ram; // CPU transceiver enable signals
output cpu_ram_dir; // CPU RAM data direction (1 = CPU to RAM, 2 = RAM to CPU)
output [14:0]ram_addr; // current RAM address
output hsync; // VGA horizontal sync
output vsync; // VGA vertical sync

// external
wire hsync;
reg vsync;
wire [1:0]mode;
reg latch_chr = 0;
reg latch_col = 0;
reg [3:0]_cs_ram = 4'b1111;
reg [3:0]_we_ram = 4'b1111;
reg [3:0]_oe_latch = 4'b1111;
reg [3:0]_cpu_ram = 4'b1111;
reg _pe_chpx = 1;
wire charpixel;
reg _char_bg = 1;
wire [3:0]chrow;
wire plane;
reg _chr_to_col = 1'b1;
reg _cpu_ram_addr = 1'b1;
reg cpu_ram_dir;
reg rdy = 1'b1;
wire _reset;

// internal 
reg pixel_clk;
reg [9:0]hcount = 10'd0;
reg [9:0]vcount = 10'd0;
reg [1:0]int_mode;
reg int_plane;
reg [14:0]int_ram_addr = 15'd0;
reg [14:0]save_ram_addr;
reg load_chr_ram;
reg load_col_ram;

wire hcount_ov;
wire vcount_ov;
wire vert_visible_area;
wire hori_visible_area;

wire mode_text;
wire mode_gra;
wire mode_320x200;
wire mode_320x400;
wire mode_400x300;

wire [2:0]chcol;

// constants
parameter
	hpixel_end = 10'd799,
	vline_end = 10'd448,

	hsync_begin = 10'd704,
	hsync_end = 10'd799,
	vsync_begin = 10'd412,
   vsync_end = 10'd413,
	
	columns = 10'd640,
	lines = 10'd400,
	
	hvisible_begin = 10'd48,
	hvisible_end = 10'd688;

// pixel clock
always @(posedge clock)
begin
	pixel_clk = ~pixel_clk;
end
assign px_clk = pixel_clk;
	
// horizontal and vertical counter
always @(posedge pixel_clk)
begin
	if (hcount_ov)
		hcount <= 10'd0;
	else
		hcount <= hcount + 10'd1;
end
assign hcount_ov = (hcount == hpixel_end);
assign hori_visible_area = hcount >= hvisible_begin && hcount < hvisible_end;

always @(posedge pixel_clk)
begin
	if (hcount_ov)
	begin
		if (vcount_ov)
		begin
			vcount <= 10'd0;
			int_mode <= mode;
			int_plane <= plane;
		end
		else
			vcount <= vcount + 10'd1;
	end
end
assign vcount_ov = (vcount == vline_end);
assign vert_visible_area = vcount < lines;
	
// horizontal and vertical sync
assign hsync = ~((hcount >= hsync_begin) && (hcount <= hsync_end));
always @(hcount or vcount)
begin
	if (hcount == hvisible_begin)
	begin
		if (vcount == vsync_begin)
			vsync <= 1;
		if (vcount == vsync_end + 1)
			vsync <= 0;
	end
end

// graphics/text mode wires
assign mode_text = (int_mode == 2'd0);
assign mode_gra = (int_mode != 2'd0);
assign mode_320x200 = (int_mode == 2'd1);
assign mode_320x400 = (int_mode == 2'd2);
assign mode_400x300 = (int_mode == 2'd3);

assign _charmode = ~mode_text;

// character row and column
assign chcol[2:0] = hcount[2:0];
assign chrow[3:0] = vcount[3:0];

// latches
always @(*)
begin
	latch_chr <= 0;
	latch_col <= 0;
	_cs_ram <= 4'b1111;
	_we_ram <= 4'b1111;
	_cpu_ram_addr <= 1;
	_cpu_ram <= 4'b1111;
	_chr_to_col <= 1;
	_pe_chpx <= 1;
	
	load_chr_ram = 0;
	load_col_ram = 0;

	if (vert_visible_area && 
		(mode_text && hcount >= hvisible_begin - 1 && hcount < hvisible_end - 1
		|| mode_gra && hori_visible_area))
	begin
		if (mode_text)
		begin
			load_chr_ram = hcount[3:0] == 4'd13;
			load_col_ram = hcount[3:0] == 4'd0;
		/*
			latch_chr <= hcount[3:0] == 4'd13;
			latch_col <= hcount[3:0] == 4'd0;
			_cs_ram[0] <= ~(hcount[3:0] == 4'd13);
			_cs_ram[2] <= ~(hcount[3:0] == 4'd13);
			_cs_ram[1] <= ~(hcount[3:0] == 4'd0);
			_cs_ram[3] <= ~(hcount[3:0] == 4'd0);
		*/
			_pe_chpx <= ~(chcol == 3'd7);
		end
		else if (mode_320x200 || mode_320x400)
		begin
			load_chr_ram = hcount[2:0] == 3'b0;
			load_col_ram = hcount[2:0] == 3'b0;
		/*
			latch_chr <= hcount[2:0] == 3'b0;
			latch_col <= hcount[2:0] == 3'b0;
			_cs_ram <= hcount[2:0] == 3'b0 ? 4'b0000 : 4'b1111;
		*/
			_chr_to_col <= ~(hcount[1] == 1'b0);
		end
		else if (mode_400x300)
		begin
			load_chr_ram = hcount[1:0] == 2'b0;
			load_col_ram = hcount[1:0] == 2'b0;
		/*
			latch_chr <= hcount[1:0] == 2'd0;
			latch_col <= hcount[1:0] == 2'd0;
			_cs_ram <= hcount[1:0] == 2'd0 ? 4'b0000 : 4'b1111;
		*/
		end
		
		if (load_chr_ram)
		begin
			latch_chr <= 1;
			_cs_ram[0] <= 0;
			_cs_ram[2] <= 0;
		end
		if (load_col_ram)
		begin
			latch_col <= 1;
			_cs_ram[1] <= 0;
			_cs_ram[3] <= 0;
		end
	end
	
	if (!load_chr_ram && !load_col_ram && _vga_mem == 0)
	begin
		_cpu_ram_addr <= 0;
		cpu_ram_dir <= _rd;
		if (addr[1] == 0)
		begin
			_cpu_ram[0] <= 0;
			_cpu_ram[1] <= 0;
			_cs_ram[0] <= addr[0];
			_cs_ram[1] <= _bhe;
			_we_ram[0] <= addr[0] && _wr;
			_we_ram[1] <= _bhe && _wr;
		end
		else begin
			_cpu_ram[2] <= 0;
			_cpu_ram[3] <= 0;
			_cs_ram[2] <= addr[0];
			_cs_ram[3] <= _bhe;
			_we_ram[2] <= addr[0] && _wr;
			_we_ram[3] <= _bhe && _wr;
		end
	end
end

// RAM address
always @(negedge pixel_clk)
begin
	if (vcount_ov)
	begin
		// reset RAM address on new frame
		if (mode_text || mode_320x200)
		begin
			int_ram_addr[13:0] <= 14'd0;
			int_ram_addr[14] <= int_plane;
		end
		else
			int_ram_addr <= 15'd0;
	end
	else if (vert_visible_area)
	begin
		if (hcount == 0)
		begin
			save_ram_addr <= int_ram_addr;
		end
		else if (hcount == hvisible_end)
		begin
			if (mode_text)
			begin
				if (chrow != 4'b1111)
					int_ram_addr <= save_ram_addr;
			end
			else if (mode_320x200)
			begin
				if (vcount[0] == 1'b0)
					int_ram_addr <= save_ram_addr;
			end
		end
		else if (hori_visible_area)
		begin
			if (mode_text && hcount[3:0] == 4'd1
				|| (mode_320x200 || mode_320x400) && hcount[2:0] == 3'd1
				|| mode_400x300 && hcount[1:0] == 3'd1)
					int_ram_addr <= int_ram_addr + 15'd1;
		end
	end
end

// pixel color (foreground or background)
always @(*)
begin
	if (mode_text)
	begin
		// text mode
		_oe_latch[0] <= 0;
		_oe_latch[2] <= 0;
		if (hori_visible_area && vert_visible_area)
		begin
			_oe_latch[1] <= ~charpixel;
			_oe_latch[3] <= ~charpixel;
			_char_bg <= charpixel;
		end
		else begin
			_oe_latch[1] <= 1;
			_oe_latch[3] <= 1;
			_char_bg <= 1;
		end
	end
	else begin
		// graphics mode
		_char_bg <= 1;
		if (hori_visible_area && vert_visible_area)
		begin
			if (mode_320x200)
			begin
				_oe_latch[0] <= ~(hcount[2:1] == 2'd0);
				_oe_latch[1] <= ~(hcount[2:1] == 2'd1);
				_oe_latch[2] <= ~(hcount[2:1] == 2'd2);
				_oe_latch[3] <= ~(hcount[2:1] == 2'd3);
			end
			else begin
				_oe_latch[0] <= ~(hcount[1:0] == 2'd0);
				_oe_latch[1] <= ~(hcount[1:0] == 2'd1);
				_oe_latch[2] <= ~(hcount[1:0] == 2'd2);
				_oe_latch[3] <= ~(hcount[1:0] == 2'd3);
			end
		end
		else begin
			_oe_latch <= 4'b1111;
		end
	end
end

// RAM address
assign ram_addr = load_chr_ram || load_col_ram ? int_ram_addr : 15'bz; 

endmodule
