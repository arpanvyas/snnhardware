`include "header.vh"
module core(
		input				clk,
		input				rst,
		input				start_core_img,
		input				valid_maxing,
		input[`W-1:0]	threshold_maxer,
		input[`M-1:0]	ips,
		input				valid_ips,		
		
		output[`N-1:0]	ops,
		output			TU_incre,
		output			done_core_img
     );
parameter M = 784, N = 8, W=24,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (3.666666666)*4096, REF = 30,
			 PRES = 0, PMIN = -500*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096;		

//Time Unit Declerations
wire		valid_ip_nub;
wire		valid_op_nub;
wire		start_core_img;

wire			start_ip_nub;
wire			start_op_nub;
wire[15:0]	TU;
wire			TU_incre;

time_unit  tu(
	.clk(clk), 
	.rst(rst),
	.valid_ips(valid_ips),
	.valid_ip_nub(valid_ip_nub),
	.valid_op_nub(valid_op_nub),
	.start_core_img(start_core_img),
	
	.start_ip_nub(start_ip_nub),
	.start_op_nub(start_op_nub),
	.TU(TU),
	.TU_incre(TU_incre),
	.done_core_img(done_core_img)
);

//Input Neuron Block Declarations


wire[`M-1:0]			spike_ip_nub;
wire[8*`M-1:0]		count;

ip_nu_blk #(.M(`M),.W(`W)) input_neuron_block(
	 .clk(clk),
	 .rst(rst),
	 .spike_in(ips),
    .start_ip_nub(start_ip_nub),
    .spike_ip_nub(spike_ip_nub),
	 .start_core_img(start_core_img),
    .count(count),
	 .valid_ip_nub(valid_ip_nub)
);

	 
//Taking the variable threshold
reg signed	[23:0] threshold;
always@(posedge clk, posedge rst) 
begin
	if(rst) begin
		threshold <= TH;
	end else begin
		if(valid_maxing) begin
			//threshold	<= threshold_maxer/3;
			threshold	<= TH;
		end
	end
end
	 


`ifdef TWO_LAYERS
//Output Neuron Block Declarations
wire[`N2-1:0]	ops_h1;
wire[`N2*8-1:0] count_out_h1;
wire            valid_op_nub_h1;



out_nu_blk #(.M(`M),.D(D),.W(`W),.N(`N),.TH(TH),.REF(REF),
				.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN)) output_neuron_block(
				.clk(clk),
				.rst(rst),
				.start_op_nub(start_op_nub),
				.spike_ip_nub(spike_ip_nub),
				.start_core_img(start_core_img),
				.TU_incre(TU_incre),
				.count(count),

                //outputs
                .count_out(count_out_h1),
				.valid_op_nub(valid_op_nub_h1),
				.spike_op_nub(ops_h1)
    );
	
//Output Neuron Block Declarations
wire[`N-1:0]    ops;
wire[`N*8-1:0]  count_out;
 
out_nu_blk_h1 #(.M(`M),.D(D),.W(`W),.N(`N),.TH(TH),.REF(REF),
				.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN)) output_neuron_block_h1(
				.clk(clk),
				.rst(rst),
				.start_op_nub(valid_op_nub_h1),
				.spike_ip_nub(ops_h1),
				.start_core_img(start_core_img),
				.TU_incre(TU_incre),
				.count(count_out_h1),

                .count_out(count_out),
				.valid_op_nub(valid_op_nub),
				.spike_op_nub(ops)
    );
	 

`endif

`ifdef ONE_LAYER
//Output Neuron Block Declarations
wire[`N-1:0]    ops;
wire[`N*8-1:0]  count_out;
 
out_nu_blk #(.M(`M),.D(D),.W(`W),.N(`N),.TH(TH),.REF(REF),
				.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN)) output_neuron_block(
				.clk(clk),
				.rst(rst),
				.start_op_nub(valid_op_nub),
				.spike_ip_nub(ops),
				.start_core_img(start_core_img),
				.TU_incre(TU_incre),
				.count(count_out),

                .count_out(count_out),
				.valid_op_nub(valid_op_nub),
				.spike_op_nub(ops)
    );
	 



`endif



endmodule

