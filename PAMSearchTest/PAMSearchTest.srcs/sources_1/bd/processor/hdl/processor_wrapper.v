//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Mon Mar 19 14:25:41 2018
//Host        : DESKTOP-T6I7S0P running 64-bit major release  (build 9200)
//Command     : generate_target processor_wrapper.bd
//Design      : processor_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module processor_wrapper
   (ddr2_sdram_addr,
    ddr2_sdram_ba,
    ddr2_sdram_cas_n,
    ddr2_sdram_ck_n,
    ddr2_sdram_ck_p,
    ddr2_sdram_cke,
    ddr2_sdram_cs_n,
    ddr2_sdram_dm,
    ddr2_sdram_dq,
    ddr2_sdram_dqs_n,
    ddr2_sdram_dqs_p,
    ddr2_sdram_odt,
    ddr2_sdram_ras_n,
    ddr2_sdram_we_n,
    dip_switches_16bits_tri_i,
    push_buttons_5bits_tri_i,
    reset,
    sd_pin10_io,
    sd_pin1_io,
    sd_pin2_io,
    sd_pin3_io,
    sd_pin4_io,
    sd_pin7_io,
    sd_pin8_io,
    sd_pin9_io,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  output [12:0]ddr2_sdram_addr;
  output [2:0]ddr2_sdram_ba;
  output ddr2_sdram_cas_n;
  output [0:0]ddr2_sdram_ck_n;
  output [0:0]ddr2_sdram_ck_p;
  output [0:0]ddr2_sdram_cke;
  output [0:0]ddr2_sdram_cs_n;
  output [1:0]ddr2_sdram_dm;
  inout [15:0]ddr2_sdram_dq;
  inout [1:0]ddr2_sdram_dqs_n;
  inout [1:0]ddr2_sdram_dqs_p;
  output [0:0]ddr2_sdram_odt;
  output ddr2_sdram_ras_n;
  output ddr2_sdram_we_n;
  input [15:0]dip_switches_16bits_tri_i;
  input [4:0]push_buttons_5bits_tri_i;
  input reset;
  inout sd_pin10_io;
  inout sd_pin1_io;
  inout sd_pin2_io;
  inout sd_pin3_io;
  inout sd_pin4_io;
  inout sd_pin7_io;
  inout sd_pin8_io;
  inout sd_pin9_io;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire [12:0]ddr2_sdram_addr;
  wire [2:0]ddr2_sdram_ba;
  wire ddr2_sdram_cas_n;
  wire [0:0]ddr2_sdram_ck_n;
  wire [0:0]ddr2_sdram_ck_p;
  wire [0:0]ddr2_sdram_cke;
  wire [0:0]ddr2_sdram_cs_n;
  wire [1:0]ddr2_sdram_dm;
  wire [15:0]ddr2_sdram_dq;
  wire [1:0]ddr2_sdram_dqs_n;
  wire [1:0]ddr2_sdram_dqs_p;
  wire [0:0]ddr2_sdram_odt;
  wire ddr2_sdram_ras_n;
  wire ddr2_sdram_we_n;
  wire [15:0]dip_switches_16bits_tri_i;
  wire [4:0]push_buttons_5bits_tri_i;
  wire reset;
  wire sd_pin10_i;
  wire sd_pin10_io;
  wire sd_pin10_o;
  wire sd_pin10_t;
  wire sd_pin1_i;
  wire sd_pin1_io;
  wire sd_pin1_o;
  wire sd_pin1_t;
  wire sd_pin2_i;
  wire sd_pin2_io;
  wire sd_pin2_o;
  wire sd_pin2_t;
  wire sd_pin3_i;
  wire sd_pin3_io;
  wire sd_pin3_o;
  wire sd_pin3_t;
  wire sd_pin4_i;
  wire sd_pin4_io;
  wire sd_pin4_o;
  wire sd_pin4_t;
  wire sd_pin7_i;
  wire sd_pin7_io;
  wire sd_pin7_o;
  wire sd_pin7_t;
  wire sd_pin8_i;
  wire sd_pin8_io;
  wire sd_pin8_o;
  wire sd_pin8_t;
  wire sd_pin9_i;
  wire sd_pin9_io;
  wire sd_pin9_o;
  wire sd_pin9_t;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  processor processor_i
       (.ddr2_sdram_addr(ddr2_sdram_addr),
        .ddr2_sdram_ba(ddr2_sdram_ba),
        .ddr2_sdram_cas_n(ddr2_sdram_cas_n),
        .ddr2_sdram_ck_n(ddr2_sdram_ck_n),
        .ddr2_sdram_ck_p(ddr2_sdram_ck_p),
        .ddr2_sdram_cke(ddr2_sdram_cke),
        .ddr2_sdram_cs_n(ddr2_sdram_cs_n),
        .ddr2_sdram_dm(ddr2_sdram_dm),
        .ddr2_sdram_dq(ddr2_sdram_dq),
        .ddr2_sdram_dqs_n(ddr2_sdram_dqs_n),
        .ddr2_sdram_dqs_p(ddr2_sdram_dqs_p),
        .ddr2_sdram_odt(ddr2_sdram_odt),
        .ddr2_sdram_ras_n(ddr2_sdram_ras_n),
        .ddr2_sdram_we_n(ddr2_sdram_we_n),
        .dip_switches_16bits_tri_i(dip_switches_16bits_tri_i),
        .push_buttons_5bits_tri_i(push_buttons_5bits_tri_i),
        .reset(reset),
        .sd_pin10_i(sd_pin10_i),
        .sd_pin10_o(sd_pin10_o),
        .sd_pin10_t(sd_pin10_t),
        .sd_pin1_i(sd_pin1_i),
        .sd_pin1_o(sd_pin1_o),
        .sd_pin1_t(sd_pin1_t),
        .sd_pin2_i(sd_pin2_i),
        .sd_pin2_o(sd_pin2_o),
        .sd_pin2_t(sd_pin2_t),
        .sd_pin3_i(sd_pin3_i),
        .sd_pin3_o(sd_pin3_o),
        .sd_pin3_t(sd_pin3_t),
        .sd_pin4_i(sd_pin4_i),
        .sd_pin4_o(sd_pin4_o),
        .sd_pin4_t(sd_pin4_t),
        .sd_pin7_i(sd_pin7_i),
        .sd_pin7_o(sd_pin7_o),
        .sd_pin7_t(sd_pin7_t),
        .sd_pin8_i(sd_pin8_i),
        .sd_pin8_o(sd_pin8_o),
        .sd_pin8_t(sd_pin8_t),
        .sd_pin9_i(sd_pin9_i),
        .sd_pin9_o(sd_pin9_o),
        .sd_pin9_t(sd_pin9_t),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
  IOBUF sd_pin10_iobuf
       (.I(sd_pin10_o),
        .IO(sd_pin10_io),
        .O(sd_pin10_i),
        .T(sd_pin10_t));
  IOBUF sd_pin1_iobuf
       (.I(sd_pin1_o),
        .IO(sd_pin1_io),
        .O(sd_pin1_i),
        .T(sd_pin1_t));
  IOBUF sd_pin2_iobuf
       (.I(sd_pin2_o),
        .IO(sd_pin2_io),
        .O(sd_pin2_i),
        .T(sd_pin2_t));
  IOBUF sd_pin3_iobuf
       (.I(sd_pin3_o),
        .IO(sd_pin3_io),
        .O(sd_pin3_i),
        .T(sd_pin3_t));
  IOBUF sd_pin4_iobuf
       (.I(sd_pin4_o),
        .IO(sd_pin4_io),
        .O(sd_pin4_i),
        .T(sd_pin4_t));
  IOBUF sd_pin7_iobuf
       (.I(sd_pin7_o),
        .IO(sd_pin7_io),
        .O(sd_pin7_i),
        .T(sd_pin7_t));
  IOBUF sd_pin8_iobuf
       (.I(sd_pin8_o),
        .IO(sd_pin8_io),
        .O(sd_pin8_i),
        .T(sd_pin8_t));
  IOBUF sd_pin9_iobuf
       (.I(sd_pin9_o),
        .IO(sd_pin9_io),
        .O(sd_pin9_i),
        .T(sd_pin9_t));
endmodule
