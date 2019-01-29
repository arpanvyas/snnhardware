`include "header.vh"

module train_test_classify(
    input clk,
    input rst,
    input start_main, // equal to new image
    input [1:0] train_test_classify,
    input [7:0] test_label,
    input [31:0] image_in,
	 input  valid_image,
    input [31:0] weight_in,
	 output ready,
    output [7:0] image_label,
    output start_core_img,
    output valid_all
    );
parameter M = 784, N = 8, W=24,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (3.666666666)*4096, REF = 30,
			 PRES = 0, PMIN = -500*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096;	 

//New inputs to control
wire	valid_buffering;
wire	valid_rfing;
wire	valid_maxing;
wire	done_core_img;
wire	valid_deciding;

wire	buffering;
wire	rfing;
wire	maxing;
wire	coring;
wire	start_core_img;
wire	deciding;
wire	valid_all;
	
control #(.M(`M),.N(`N),.W(`W),.D(D),
					 .TH(TH),.PRES(PRES),.PMIN(PMIN)) control (	.clk(clk),
				.rst(rst),
				.start_main(start_main),
				.train_test_classify(train_test_classify),
				.valid_buffering(valid_buffering),
				.valid_rfing(valid_rfing),
				.valid_maxing(valid_maxing),
				.done_core_img(done_core_img),
				.valid_deciding(valid_deciding),
				
				.buffering(buffering),
				.rfing(rfing),
				.maxing(maxing),
				.coring(coring),
				.start_core_img(start_core_img),
				.deciding(deciding),
				.valid_all(valid_all)
);	


//New Inputs to pre_core

wire	TU_incre;
wire	[`W-1:0] threshold;
wire	[`M-1:0] ips;
wire	valid_ips;

pre_core #(.M(`M),.D(D),.W(`W),.N(`N),.TH(TH),.REF(REF),
		.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN),.IM_WID(IM_WID),
		.IM_HEI(IM_HEI)) pre_core(
		.clk(clk), 
		.rst(rst), 
		.image_in(image_in),
		.valid_image(valid_image),
		.TU_incre(TU_incre),
		.buffering(buffering),
		.rfing(rfing),
		.maxing(maxing),
		.coring(coring),
		
		.valid_buffering(valid_buffering),
		.valid_rfing(valid_rfing),
		.valid_maxing(valid_maxing),
		.threshold(threshold),
		.ips(ips),  
		.valid_ips(valid_ips)
	);
	
//New Inputs to core	
wire	[`N-1:0]	ops;
	
core #(.M(`M),.D(D),.W(`W),.N(`N),.TH(TH),.REF(REF),
		.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN)) core (
		.clk(clk), 
		.rst(rst), 
		.start_core_img(start_core_img),
		.valid_maxing(valid_maxing),
		.threshold_maxer(threshold),
		.ips(ips),
		.valid_ips(valid_ips),
		
		.ops(ops), 
		.TU_incre(TU_incre),
		.done_core_img(done_core_img)
	); 



post_core #(.M(`M),.D(D),.W(`W),.N(`N),.TH(TH),.REF(REF),
		.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN)) post_core (
		.clk(clk), 
		.rst(rst),
		.train_test_classify(train_test_classify),		
		.test_label(test_label),		
		.coring(coring),
		.ops(ops),	
		.TU_incre(TU_incre),	
		.done_core_img(done_core_img),		
		.deciding(deciding),
		
		.valid_deciding(valid_deciding),
		.image_label(image_label) 
	); 




endmodule
