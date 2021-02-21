`timescale 1 ns/1 ns
module Sdcontroller_tb;

// inputs
reg cs_drive = 1, rd = 1, wr = 1, cs_buffer = 1, card_det, clk;
reg [1:0] addr;
reg miso;

// outputs
wire den, sd_busy, ram_oe, ram_we, sd_irq, ld_n, ld_rd;
wire [8:0] ram_addr;
wire sd_cs, sclk, mosi;

// inout
wire [7:0] data;
wire [7:0] ram_data;

reg data_out_active;
reg [7:0] data_out;

// Instantiate UUT
SDcontroller UUT (
    .CS_DRIVE(cs_drive),
    .RD(rd),
    .WR(wr),
    .CS_BUFFER(cs_buffer),
    .ADDR(addr),
    .CARD_DET(card_det),
    .clk(clk),
    .DEN(den),
    .SD_BUSY(sd_busy),
    .RAM_OE(ram_oe),
    .RAM_WE(ram_we),
    .SD_IRQ(sd_irq),
    .LD_GN(ld_gn),
    .LD_RD(ld_rd),
    .RAM_ADDR(ram_addr),
    .DATA(data),
    .RAM_DATA(ram_data),
    .SD_CS(sd_cs),
    .MISO(miso),
    .SCLK(sclk),
    .MOSI(mosi)
);

assign data = data_out_active ? data_out : 8'dz; 

initial begin
    clk = 0;
    // generate clock (20 MHz)
    forever #25 clk = ~clk;
end
 
initial begin
    miso = 0;
    #90

    data_out = 8'hFF;
    data_out_active = 1;
    addr = 2'd2;
    cs_drive = 0;
    wr = 0;
    #100
    data_out_active = 0;
    cs_drive = 1;
    wr = 1;

    #2500

    data_out = 8'h40;
    data_out_active = 1;
    addr = 2'd2;
    cs_drive = 0;
    wr = 0;
    #100
    data_out_active = 0;
    cs_drive = 1;
    wr = 1;
    
    #2500

    $stop;
end


endmodule;