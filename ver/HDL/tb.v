`timescale 1ns / 1ps
`include "header.vh"

module tb;

	// Inputs
	reg clk;
	reg rst;
	reg start_main;
	reg [1:0] train_test_classify;
	reg [7:0] test_label;
	reg [31:0] image_in;
	reg valid_image;
	reg [31:0] weight_in;

	// Outputs
	wire ready;
	wire [7:0] image_label;
	wire start_core_img;
	wire valid_all;

	integer 		f1,file1,f2,file2,i1,epoch;
	reg[15:0]	str1,str2;
	reg[31:0]	image_reg[`M/4-1:0];

parameter M = 784, N = 8, W=24,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (2)*4096, REF = 30,
			 PRES = 0, PMIN = -50*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096;			 




	// Instantiate the Unit Under Test (UUT)
	train_test_classify #(.M(M),.D(D),.W(W),.N(N),.TH(TH),.REF(REF),
		.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN),.IM_WID(IM_WID),
		.IM_HEI(IM_HEI)) uut  (
		.clk(clk), 
		.rst(rst), 
		.start_main(start_main), 
		.train_test_classify(train_test_classify), 
		.test_label(test_label), 
		.image_in(image_in), 
		.valid_image(valid_image), 
		.weight_in(weight_in), 
		.ready(ready), 
		.image_label(image_label), 
		.start_core_img(start_core_img), 
		.valid_all(valid_all)
	);

//	task send_train_image(input reg [200*8-1:0] string, input clk, output start_main, output);
//			start_main = 1;
//			@(posedge clk);
//			start_main = 0;
//			i1 = 0;
//			$readmemb("/home/vonfaust/data/snn/codebase/ver/FEED/img0.bin",image_reg);
//			//f1=$fread(image_reg,file1);
//			while(i1<M/4) begin
//				valid_image	= 1;
//				image_in	=	image_reg[i1];
//				@(posedge clk);
//				i1 = i1 + 1;
//			end
//			valid_image = 0;
//			i1 = 0;
//			
//			while(~valid_all) begin
//			@(posedge clk);
//			end
//			epoch = epoch + 1;
//			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
//	
//	
//	endtask
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		start_main = 0;
		train_test_classify = 0;
		test_label = 0;
		image_in = 0;
		valid_image = 0;
		weight_in = 0;
		epoch = 0;
		str2 = "9";
	    
        $display(`FEED);    
	    $display("new message");	
		$readmemb({`FEED,"img",str2,".bin"},image_reg);

		// Wait 100 ns for global reset to finish
		#10;
			rst <= 0;
			train_test_classify <= 1;
		// Add stimulus here
		
		
		
		//take a new picture
		//file1 = $fopen("/home/vonfaust/data/snn/codebase/ver/FEED/img1.png","rb");
	while(1) begin
        str2 = "0";
		repeat(1) begin
			start_main = 1;
			@(posedge clk);
            # 0;
			start_main = 0;
			i1 = 0;
			$readmemb({`FEED,"img",str2,".bin"},image_reg);
			//f1=$fread(image_reg,file1);
			while(i1<M/4) begin
				valid_image	= 1;
				image_in	=	image_reg[i1];
				@(posedge clk);
                # 0;
				i1 = i1 + 1;
			end
			valid_image = 0;
			i1 = 0;
			
			while(~valid_all) begin
			@(posedge clk);
            # 0;
			end
			epoch = epoch + 1;
            # 0;
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		end
//			
        str2 = "1";
		repeat(1) begin
			start_main = 1;
			@(posedge clk);
            # 0;
			start_main = 0;
			i1 = 0;
			$readmemb({`FEED,"img",str2,".bin"},image_reg);
			//f1=$fread(image_reg,file1);
			while(i1<M/4) begin
				valid_image	= 1;
				image_in	=	image_reg[i1];
				@(posedge clk);
                # 0;
				i1 = i1 + 1;
			end
			valid_image = 0;
			i1 = 0;
			
			while(~valid_all) begin
			@(posedge clk);
            # 0;
			end
			epoch = epoch + 1;
            # 0;
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		end
//				
        str2 = "2";
		repeat(1) begin
			start_main = 1;
			@(posedge clk);
            # 0;
			start_main = 0;
			i1 = 0;
			$readmemb({`FEED,"img",str2,".bin"},image_reg);
			//f1=$fread(image_reg,file1);
			while(i1<M/4) begin
				valid_image	= 1;
				image_in	=	image_reg[i1];
				@(posedge clk);
                # 0;
				i1 = i1 + 1;
			end
			valid_image = 0;
			i1 = 0;
			
			while(~valid_all) begin
			@(posedge clk);
            # 0;
			end
			epoch = epoch + 1;
            # 0;
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		end
//
	        str2 = "3";
		repeat(1) begin
			start_main = 1;
			@(posedge clk);
            # 0;
			start_main = 0;
			i1 = 0;
			$readmemb({`FEED,"img",str2,".bin"},image_reg);
			//f1=$fread(image_reg,file1);
			while(i1<M/4) begin
				valid_image	= 1;
				image_in	=	image_reg[i1];
				@(posedge clk);
                # 0;
				i1 = i1 + 1;
			end
			valid_image = 0;
			i1 = 0;
			
			while(~valid_all) begin
			@(posedge clk);
            # 0;
			end
			epoch = epoch + 1;
            # 0;
			@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
		end
//							
		
	
	end
end
	always
	 #5 clk <= ~ clk;
	 
	 
	 
	 
	 
	 
	 
	 
      
endmodule

