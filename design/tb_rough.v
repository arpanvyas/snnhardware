`timescale 1ns / 1ps
module tb_rough;

	// Inputs
	reg clk;
	reg rst;
	reg [9:0] ip;

	// Outputs
	wire [9:0] op;

	// Instantiate the Unit Under Test (UUT)
	rough uut (
		.clk(clk), 
		.ip(ip), 
		.op(op)
	);
	reg signed [9:0] sca1;
	reg	[7:0]		  val8,val12,val14,val18;
	
	initial begin
		rst	<= 1;
		clk	<= 0;
		val	<= 2;
		sca1	<= 0;
		val8	<= 48;
		val12	<= 96;
		val14	<= 146;
		val18	<= 255;
		#1;
		rst 	<= 0;
		
		
		sca1	<= 0 -(val8>>1) - (val8>>3);// + val12>>1 + val12>>3 + val14>>1 + val14>>3 + val18>>1 + val18>>3;
		
		
	end
	
	reg[3:0] val;	
	
	always begin
		#1 clk <= ~clk;
	end
	
	
	always@(posedge clk, posedge rst)
	begin

	end


	
endmodule

