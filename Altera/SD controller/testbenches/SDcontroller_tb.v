`timescale 1 ns/1 ns
module Sdcontroller_tb;

// inputs
reg m_io = 1, rd = 1, wr = 1, cs_buffer = 1, card_det, clk;
reg [1:0] addr;
reg [7:0] al = 8'b00010010; // SD controller I/O address
reg miso;

// outputs
wire den, sd_irq, ld_n, ld_rd, ld_bl;
wire cs,uart, cs_8042, cs_i2c;
wire sd_cs, sclk, mosi;

// inout
wire [7:0] data;
wire [7:0] ram_data;

reg data_out_active;
reg [7:0] data_out;

// Instantiate UUT
SDcontroller UUT (
    .M_IO(m_io),
    .RD(rd),
    .WR(wr),
    .ADDR(addr),
    .AL(al),
    .CARD_DET(card_det),
    .clk(clk),
    .DEN(den),
    .SD_IRQ(sd_irq),
    .LD_GN(ld_gn),
    .LD_RD(ld_rd),
    .LD_BL(ld_bl),
    .CS_UART(cs_uart),
    .CS_8042(cs_8042),
    .CS_I2C(cs_i2c),
    .DATA(data),
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
    m_io = 0;
    wr = 0;
    #100
    data_out_active = 0;
    m_io = 1;
    wr = 1;

    #2500

    data_out = 8'h40;
    data_out_active = 1;
    addr = 2'd2;
    m_io = 0;
    wr = 0;
    #100
    data_out_active = 0;
    m_io = 1;
    wr = 1;
    
    #2500

    $stop;
end


endmodule
