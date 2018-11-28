`timescale 1ns / 1ps
module tb_FPGA;

	// Inputs
	reg clk;
	reg rst;
	reg switch_working;

	// Outputs
	wire led_opnu1;
	wire led_opnu2;
	wire led_hold;
	wire led_done;

	// Instantiate the Unit Under Test (UUT)
	FPGA_Module uut (
		.clk(clk), 
		.rst(rst), 
		.switch_working(switch_working), 
		.led_opnu1(led_opnu1), 
		.led_opnu2(led_opnu2),
		.led_hold(led_hold), 
		.led_done(led_done)
	);

	always begin
		#10 clk=~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		switch_working = 0;
		#100;
      rst  = 0;
		switch_working	= 1;
		
		

	end
      
endmodule

