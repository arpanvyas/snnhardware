`include "header.vh"

module rng_test;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] seed;
	reg [3:0] prob;
	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	random_number_generator uut (
		.clk(clk), 
		.rst(rst), 
		.seed(seed),
		.prob(prob),
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		seed = 0;
		seed = 16'b0000_0000_0000_0001;
		prob = 2;
		i = 0;
		j = 0;
		#10;
		rst = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   
	always
		#5 clk <= ~clk;
	
	integer i,j,k;
	always@(posedge clk)
	begin
	 j <= j + 1;
	 if(out) 
		i <= i+ 1;
	 else 
		i <= i;
	end
	
	always@(*)
	begin
		if(j==0)
			k = 0;
		else 
			k = i/j;
	end	
	
endmodule

