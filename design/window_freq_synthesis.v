////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: window_freq_synthesis.v
// /___/   /\     Timestamp: Mon May 22 01:32:56 2017
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim window_freq.ngc window_freq_synthesis.v 
// Device	: xc6vlx240t-1-ff1156
// Input file	: window_freq.ngc
// Output file	: /home/arpan/Desktop/SNN Summer Work/SNN_Summer/netgen/synthesis/window_freq_synthesis.v
// # of Modules	: 1
// Design Name	: window_freq
// Xilinx        : /opt/Xilinx/14.7/ISE_DS/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module window_freq (
  clk, rst, val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16, val17, val18, val19, val20, val21, 
val22, val23, val24, val25, val_out
);
  input clk;
  input rst;
  input [7 : 0] val1;
  input [7 : 0] val2;
  input [7 : 0] val3;
  input [7 : 0] val4;
  input [7 : 0] val5;
  input [7 : 0] val6;
  input [7 : 0] val7;
  input [7 : 0] val8;
  input [7 : 0] val9;
  input [7 : 0] val10;
  input [7 : 0] val11;
  input [7 : 0] val12;
  input [7 : 0] val13;
  input [7 : 0] val14;
  input [7 : 0] val15;
  input [7 : 0] val16;
  input [7 : 0] val17;
  input [7 : 0] val18;
  input [7 : 0] val19;
  input [7 : 0] val20;
  input [7 : 0] val21;
  input [7 : 0] val22;
  input [7 : 0] val23;
  input [7 : 0] val24;
  input [7 : 0] val25;
  output [7 : 0] val_out;
  wire val_out_7_OBUF_0;
  VCC   XST_VCC (
    .P(val_out_7_OBUF_0)
  );
  OBUF   val_out_7_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[7])
  );
  OBUF   val_out_6_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[6])
  );
  OBUF   val_out_5_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[5])
  );
  OBUF   val_out_4_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[4])
  );
  OBUF   val_out_3_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[3])
  );
  OBUF   val_out_2_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[2])
  );
  OBUF   val_out_1_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[1])
  );
  OBUF   val_out_0_OBUF (
    .I(val_out_7_OBUF_0),
    .O(val_out[0])
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

