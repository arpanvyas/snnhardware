`timescale 1ns / 1ps

module out_nu_blk_tb;

	parameter M 	= 10, N = 3, D = 1, TH = 90, REF = 30,
				 PRES = 10, PMIN = -10, W = 8;
	
	// Inputs
	reg clk;
	reg rst;
	reg start_op_nub;
	reg TU_incre;
	reg [M-1:0] spike_ip_nub;
	reg[15:0] TU;
	// Outputs
	wire 			valid_op_nub;
	wire[N-1:0] spike_op_nub;

	// Instantiate the Unit Under Test (UUT)
	out_nu_blk  #(.M(M),.N(N),.W(W),.D(D),
		      .TH(TH),.REF(REF),.PRES(PRES),.PMIN(PMIN)) uut (
		.clk(clk), 
		.rst(rst), 
		.start_op_nub(start_op_nub), 
		.TU_incre(TU_incre), 
		.spike_ip_nub(spike_ip_nub),
		
		.valid_op_nub(valid_op_nub), 
		.spike_op_nub(spike_op_nub)
	);

	//file reading
	integer 		f1,file;
	reg[M-1:0]	str;
		
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		TU_incre = 0;
		TU			=0;
		start_op_nub = 0;
		TU_incre = 0;
		spike_ip_nub = 0;
		
		str = 0;
		f1 = 0; file = 0;
		file = $fopen("C:/Users/Arpan Vyas/Desktop/My/FPGA/Spiking_Neural_Network/testbench_files/input_spikes.dat","r");
		
		// Wait for global reset to finish
		@(posedge clk);@(posedge clk);
		rst	= 0;
        
		// Add stimulus here 
		@(posedge clk);
		
		//New One
		repeat(5000) begin	
			f1 	=	$fscanf(file,"%b\n", str[M-1:0]);
			spike_ip_nub	=	str;
			
			start_op_nub	<= 1;
			@(posedge clk);
			start_op_nub	<= 0;
			
			while(~valid_op_nub) begin
							@(posedge clk);
						end
			
			TU_incre		<= 1;
			TU				<= TU + 1;
			@(posedge clk);
			TU_incre		<= 0;
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		end
			
	end
	
	
	always begin
		#10 clk=~clk;
	end	
	
	

      
endmodule

