`timescale 1ns / 1ps
module pot_adder_tb;

	// Inputs
	reg clk;
	reg rst;
	reg TU_incre;
	reg start_pp1;
	reg start_pp2;
	reg start_pp3m;
	reg start_pp3;
	reg won_lost_hold;
	reg [M*W-1:0] weights;
	reg [M-1:0] spike_ip_nub;
	integer	i;

	// Outputs
	wire [W-1:0] potential;
	wire spike_pp;
	wire valid_pp1;
	wire valid_pp2;
	wire valid_pp3m;
	wire valid_pp3;
	wire ref;
	wire dec;

	parameter M 	= 10, N = 3, D = 1, TH = 90, REF = 30,
				 PRES = 10, PMIN = -10, W = 8;	

	// Instantiate the Unit Under Test (UUT)
	pot_adder #(.M(M),.N(N),.W(W),.D(D),
					 .TH(TH),.REF(REF),.PRES(PRES),.PMIN(PMIN)) uut (
		.clk(clk), 
		.rst(rst), 
		.TU_incre(TU_incre), 
		.start_pp1(start_pp1), 
		.start_pp2(start_pp2), 
		.start_pp3m(start_pp3m), 
		.start_pp3(start_pp3), 
		.won_lost_hold(won_lost_hold), 
		.weights(weights), 
		.spike_ip_nub(spike_ip_nub), 
		.potential(potential), 
		.spike_pp(spike_pp), 
		.valid_pp1(valid_pp1), 
		.valid_pp2(valid_pp2), 
		.valid_pp3m(valid_pp3m), 
		.valid_pp3(valid_pp3), 
		.ref(ref), 
		.dec(dec)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		TU_incre = 0;
		start_pp1 = 0;
		start_pp2 = 0;
		start_pp3m = 0;
		start_pp3 = 0;
		won_lost_hold = 0;
		spike_ip_nub = 0;
		
		weights = 80'b00001010000000110000100000001011000001000000001000001010000000110000010000000001;
	   ini_send = 1;
		str = 0;
		f1 = 0; file = 0;
		file = $fopen("C:/Users/Arpan Vyas/Desktop/My/FPGA/Spiking_Neural_Network/testbench_files/input_spikes.dat","r");
		
		// Wait 100 ns for global reset to finish
		#20;
		rst	= 0;
        
		// Add stimulus here 
		f1 	=	$fscanf(file,"%b\n", str[M-1:0]);
		spike_ip_nub	=	str;
		ini_send <= 0;
		@(posedge clk);
		
		//New One
		start_pp1	<= 1;
		@(posedge clk);
		start_pp1	<= 0;
		while(~valid_pp1) begin
						@(posedge clk);
					end
		@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		
		//New One
		repeat(2) begin
			start_pp3	<= 1;
			@(posedge clk);
			start_pp3	<= 0;
			while(~valid_pp3m) begin
							@(posedge clk);
						end
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
			won_lost_hold <= 1;
			start_pp3m	  <= 1;
			@(posedge clk);
			won_lost_hold <= 0;
			start_pp3m	  <= 0;
			while(~valid_pp3) begin
							@(posedge clk);
						end
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		end
		
		//New One
		start_pp3	<= 1;
		@(posedge clk);
		start_pp3	<= 0;
		while(~valid_pp3m) begin
						@(posedge clk);
					end
		@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		won_lost_hold <= 0;
		start_pp3m	  <= 1;
		@(posedge clk);
		won_lost_hold <= 0;
		start_pp3m	  <= 0;
		while(~valid_pp3) begin
						@(posedge clk);
					end
		@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		
		
		//New One
		repeat(5000) begin
			f1 	=	$fscanf(file,"%b\n", str[M-1:0]);
			spike_ip_nub	=	str;
			start_pp2	<= 1;
			@(posedge clk);
			start_pp2	<= 0;
			while(~valid_pp2) begin
					@(posedge clk);
					end
			TU_incre		<= 1;
			@(posedge clk);
			TU_incre		<= 0;
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		end
			
	end
      
	always begin
		#10 clk=~clk;
	end	
	
	
		//file reading
	integer 		f1,file;
	reg[M-1:0]	str;
	reg			ini_send;
		
	
endmodule

