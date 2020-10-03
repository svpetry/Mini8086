module VGA(
		// inputs
		clock,
		_vga_mem,
		addr,
		_rd,
		_wr,
		_bhe,
		_charpixel,
		mode,
		
		// outputs
		_we_ram,
		_cs_ram,
		cpu_ram_dir,
		_cpu_ram,
		_cpu_ram_addr,
		_latch,
		_oe_latch,
		chrow,
		_charmode,
		chcol,
		_char_bg,
		_chr_to_col,
		ram_addr,
		_hsync,
		_vsync,
		busy,
		
		pixel_clk
);

// input signals
input clock; // 50 MHz clock
input _vga_mem; // CPU accesses VGA memory
input [2:0]addr; // A0-A2 from system address bus
input _rd; // CPU read signal
input _wr; // CPU write signal
input _bhe; // BHE signal from CPU
input _charpixel; // character pixel signal
input [1:0]mode; // graphics mode (0 = text, 1 = 320x200x8, 2 = 400x300x8)

// output signals
output [3:0]_we_ram; // RAM WE
output [3:0]_cs_ram; // RAM CS
output cpu_ram_dir; // CPU RAM data direction (1 = CPU to RAM, 2 = RAM to CPU)
output [3:0]_cpu_ram; // CPU transceiver enable signals
output _latch; // latch 4 bytes from RAM
output [3:0]_oe_latch; // latch OE
output [3:0]chrow; // character row
output _charmode; // enable text mode
output [2:0]chcol; // character column
output _char_bg; // output background color at character pixel
output _chr_to_col; // connect DCHR to DCOL bus
output [14:0]ram_addr; // current RAM address
output _cpu_ram_addr; // connect CPU address bus to RAM
output _hsync; // VGA horizontal sync
output _vsync; // VGA vertical sync
output busy; // CPU busy signal

output pixel_clk;

wire _hsync;
wire _vsync;
wire _charmode;
wire [3:0]_oe_latch;
wire cpu_ram_dir;
wire _cpu_ram_addr;
wire [3:0]_cpu_ram;
wire _latch;
wire [3:0]_cs_ram;
wire [3:0]chrow;
wire [2:0]chcol;
wire [14:0]ram_addr;
wire _chr_to_col;

// internal
reg [10:0]hcount = 10'd0;
reg [9:0]vcount = 10'd0;
reg pixel_clk = 0;
reg [14:0]int_ram_addr = 15'd0;
reg [1:0]int_mode = 2'b00;
reg load_phase0;
reg load_phase1;
reg busy;
reg load_latches;
reg allow_cpu_access;

wire hcount_ov;
wire vcount_ov;
wire vert_visible_area;
wire hor_visible_area;
wire char_no; 
wire [1:0]pix_no;
wire [6:0]char_no_line; // max. 100
wire [8:0]pix_no_line; // max. 400
wire mode_320x200;
wire mode_400x300;
wire mode_text;
wire mode_gra;
wire inc_ram_addr;
wire inc_row_addr;

wire cpu_busy;
wire block_ram;
wire ram_output;

parameter
   hpixel_end = 10'd799,
   vline_end = 10'd448,

	hsync_begin = 10'd656,
	hsync_end = 10'd751,
	vsync_begin = 10'd412,
   vsync_end = 10'd413,
	
	columns = 10'd640,
	lines = 10'd400;

assign mode_text = (int_mode == 2'd0);
assign mode_gra = (int_mode != 2'd0);
assign mode_320x200 = (int_mode == 2'd1);
assign mode_400x300 = (int_mode == 2'd2);

assign _charmode = ~mode_text;

assign _oe_latch[0] = ~(hor_visible_area && ((mode_text && char_no == 0) || (mode_gra && pix_no == 2'b00)));
assign _oe_latch[1] = ~(hor_visible_area && ((mode_text && _charpixel == 0 & char_no == 0) || (mode_gra && pix_no == 2'b01)));
assign _oe_latch[2] = ~(hor_visible_area && ((mode_text && char_no == 1) || (mode_gra && pix_no == 2'b10)));
assign _oe_latch[3] = ~(hor_visible_area && ((mode_text && _charpixel == 0 & char_no == 1) || (mode_gra && pix_no == 2'b11)));
assign _char_bg = ~(hor_visible_area && mode_text && _charpixel == 1);
assign _chr_to_col = ~(hor_visible_area && mode_gra && (_oe_latch[0] == 0 || _oe_latch[2] == 0));

assign _latch = ~load_latches;
assign _cs_ram[0] = ~(allow_cpu_access == 0 || _cpu_ram[0] == 0);
assign _cs_ram[1] = ~(allow_cpu_access == 0 || _cpu_ram[1] == 0);
assign _cs_ram[2] = ~(allow_cpu_access == 0 || _cpu_ram[2] == 0);
assign _cs_ram[3] = ~(allow_cpu_access == 0 || _cpu_ram[3] == 0);

assign ram_addr[14:0] = allow_cpu_access ? 14'bzzzzzzzzzzzzzz : int_ram_addr[14:0];

// pixel clock
always @(posedge clock)
begin
	pixel_clk = ~pixel_clk;
end

// horizontal and vertical counter
always @(posedge pixel_clk)
begin
	if (hcount_ov)
		hcount <= 10'd0;
	else
		hcount <= hcount + 10'd1;
end
assign hcount_ov = (hcount == hpixel_end);

always @(posedge pixel_clk)
begin
	if (hcount_ov)
	begin
		if (vcount_ov)
		begin
			vcount <= 10'd0;
			int_mode <= mode;
		end
		else
			vcount <= vcount + 10'd1;
	end
end
assign vcount_ov = (vcount == vline_end);

// horizontal and vertical sync
assign _hsync = ~((hcount >= hsync_begin) && (hcount <= hsync_end));
assign _vsync = ~((vcount >= vsync_begin) && (vcount <= vsync_end));

// horizontal and vertical visible area
assign vert_visible_area = vcount < lines;
assign hor_visible_area = hcount < columns;

// character row and column counters
assign chrow[3:0] = mode_text && vert_visible_area ? vcount[3:0] : 4'd0;
assign chcol[2:0] = mode_text && hor_visible_area ? hcount[2:0] : 3'd0;

// character no in latches (0 or 1)
assign char_no = mode_text ? hcount[3] : 1'b0;
// character no in line incl. invisible area (max. 100)
assign char_no_line = mode_text ? hcount[9:3] : 6'd0;

// pixel in latches (0-3)
assign pix_no[1:0] = mode_gra == 1 ? hcount[2:1] : 2'b00;
// pixel in line incl. invisible area (max. 400)
assign pix_no_line = mode_gra == 1 ? hcount[9:1] : 9'd0;

// increment RAM address
assign inc_ram_addr = hor_visible_area && ((mode_text == 1 && char_no == 1'b1) || (mode_gra == 1 && pix_no == 2'b11));
always @(posedge inc_ram_addr)
begin
	if (vert_visible_area)
	begin
		int_ram_addr = int_ram_addr + 15'd1;
		
		if (mode_text && char_no_line == 7'd79)
		begin
			if (hcount[3:0] != 4'd15)
				int_ram_addr = int_ram_addr - 14'd160;
		end
		else if (mode_320x200 && pix_no_line == 9'd319)
		begin
			if (hcount[0] != 1'd1)
				int_ram_addr = int_ram_addr - 14'd320;
		end
	end
	else
		int_ram_addr = 15'd0;
end

// load latches from RAM if needed
always @(*)
begin
	if (mode_text)
	begin
		load_phase0 = (char_no_line < 7'd79 || char_no_line == 7'd99) && char_no == 1'd1
			&& (vert_visible_area || vcount == vline_end);
		load_phase1 = hor_visible_area && vert_visible_area && char_no == 1'd0;
	end
	else if (mode_gra)
	begin
		load_phase0 = (pix_no_line < 9'd319 || pix_no_line == 9'd399) && pix_no == 2'd3
			&& (vert_visible_area || vcount == vline_end);
		load_phase1 = hor_visible_area && vert_visible_area && pix_no == 2'd0;
	end
	else
	begin
		load_phase0 = 0;
		load_phase1 = 0;
	end;
	
	busy <= load_phase0 && (hcount[2:0] == 3'b101 || hcount[2:0] == 3'b110);// || hcount[2:0] == 3'b111);
	load_latches <= load_phase1 && hcount[2:0] == 3'b000 && pixel_clk == 1 && clock == 1;
	allow_cpu_access <= ~(load_phase0 && hcount[2:0] == 3'b111 && pixel_clk == 0 || load_phase1 && hcount[2:0] == 3'b000 && pixel_clk == 1 && clock == 1);
end

// CPU RAM access
assign _cpu_ram[0] = ~(allow_cpu_access && _vga_mem == 0 && addr[0] == 0 && addr[1] == 0);
assign _cpu_ram[1] = ~(allow_cpu_access && _vga_mem == 0 && _bhe == 0 && addr[1] == 0);
assign _cpu_ram[2] = ~(allow_cpu_access && _vga_mem == 0 && addr[0] == 0 && addr[1] == 1);
assign _cpu_ram[3] = ~(allow_cpu_access && _vga_mem == 0 && _bhe == 0 && addr[1] == 1);
assign _cpu_ram_addr = ~(allow_cpu_access && _vga_mem == 0);
assign _we_ram[0] = ~(allow_cpu_access && _vga_mem == 0 && _wr == 0 && _cpu_ram[0]);
assign _we_ram[1] = ~(allow_cpu_access && _vga_mem == 0 && _wr == 0 && _cpu_ram[1]);
assign _we_ram[2] = ~(allow_cpu_access && _vga_mem == 0 && _wr == 0 && _cpu_ram[2]);
assign _we_ram[3] = ~(allow_cpu_access && _vga_mem == 0 && _wr == 0 && _cpu_ram[3]);
assign cpu_ram_dir = _wr == 0 ? 1'b1 : 1'b0;

endmodule
