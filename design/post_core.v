module post_core(
    input clk,
    input rst,
	 input [1:0] train_test_classify,
    input [7:0] test_label,	 
	 input coring,
	 input [N-1:0] ops,
	 input TU_incre,
	 input done_core_img,
    input deciding,
 
    output valid_deciding, 
    output [7:0] image_label
    );

parameter M = 784, N = 8, W=24,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (3.666666666)*4096, REF = 30,
			 PRES = 0, PMIN = -500*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096;	


reg		testing,classifying,valid_deciding;
reg[7:0]	image_label;
reg[7:0]	ops_counter[N-1:0];
reg[7:0]	opnu_label[N-1:0];
integer	i,index,max_counter,zero_loop;
reg[7:0]	max_val,max_index;

always@(posedge clk, posedge rst)
begin
	if(rst) begin
		image_label <= 0;
		valid_deciding <= 0;
		testing		<= 0;
		classifying <= 0;
		max_counter <= 0;
		max_index	<= 0;
		max_val		<= 0;
			for(zero_loop=0;zero_loop<N;zero_loop=zero_loop+1) begin
				ops_counter[zero_loop] <= 0;
				opnu_label[zero_loop]	<= 0;
			end
	end else begin 
			valid_deciding <= 0;
			if(coring) begin //grab spikes here
				if(TU_incre) begin
					
					for(i=0;i<N;i=i+1) begin
						if(ops[i]) begin
							ops_counter[i]	<= ops_counter[i] + 1;
						end else begin
							ops_counter[i] <= ops_counter[i];
						end
					end
					
					if(done_core_img) begin
						max_index	<= 0;
						max_val		<= ops_counter[0];
						max_counter	<= 1;
					end
				
				end
			end
			
			if(max_counter>0) begin
					case(train_test_classify)
						2'b01:
							begin
								valid_deciding	<= 1;
								max_counter		<= 0;
							end
						2'b10||2'b11://find the out_neu with max spikes here
							begin
								max_counter		<= max_counter + 1;
								if(ops_counter[max_counter] > max_val) begin
										max_val 		<= ops_counter[max_counter];
										max_index	<= max_counter;
								end else begin
										max_val		<= max_val;
										max_index	<= max_index;
								end
								
								if(max_counter==N-1) begin
									max_counter		<= 0;		
									if(train_test_classify==2'b10) begin
										testing			<= 1;
									end else begin
										classifying		<= 1;
									end
								end
							
							end
						default:
							begin
								valid_deciding	<= 1;
								max_counter		<= 0;
							end
					endcase
			end
			
			if(testing) begin //find the maximum output spiked neuron and assign the test_label to it
				opnu_label[max_index] <= test_label;
				valid_deciding			 <= 1;
				testing					 <= 0;
				max_index				 <= 0;
				max_val					 <= 0;
					for(zero_loop=0;zero_loop<N;zero_loop=zero_loop+1) begin
						ops_counter[zero_loop] <= 0;
					end
			end
		
			if(classifying) begin //find the maximum output spiked neuron and display the label of it
				image_label				 <= opnu_label[max_index];
				valid_deciding			 <= 1;
				classifying				 <= 0;
				max_index				 <= 0;
				max_val					 <= 0;
					for(zero_loop=0;zero_loop<N;zero_loop=zero_loop+1) begin
						ops_counter[zero_loop] <= 0;
					end
			end
	
	end

end




endmodule
