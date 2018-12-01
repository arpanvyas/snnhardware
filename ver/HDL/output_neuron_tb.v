`timescale 1ns / 1ps
module output_neuron_tb;

	// Inputs
	reg clk;
	reg rst;
	reg TU_incre;
	reg isor_0_start;
	reg isor_1_start;
	reg li;
	reg [0:0] spike_ip_nub;
	reg valid_li;
	reg won_lost;

	// Outputs
	wire spike_op_nu;
	wire start_li;
	wire valid_nu;

	// Instantiate the Unit Under Test (UUT)
	out_nu uut (
		.clk(clk), 
		.rst(rst), 
		.TU_incre(TU_incre), 
		.isor_0_start(isor_0_start), 
		.isor_1_start(isor_1_start), 
		.li(li), 
		.spike_ip_nub(spike_ip_nub), 
		.valid_li(valid_li), 
		.won_lost(won_lost), 
		.spike_op_nu(spike_op_nu), 
		.start_li(start_li), 
		.valid_nu(valid_nu)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		TU_incre = 0;
		isor_0_start = 0;
		isor_1_start = 0;
		li = 0;
		spike_ip_nub = 0;
		valid_li = 0;
		won_lost = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

