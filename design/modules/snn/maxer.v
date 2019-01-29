`include "header.vh"

module maxer(
    input clk,
    input rst,
    input maxing,
    input [`M-1:0] ips_gen_out,
    output start_ips_gen,
    output next_ips_gen,
    output maxer_valid,
    output [`W-1:0]threshold
    );
parameter	M=784, N=8, W=24 , REF = 30,
				D = 9830/*.15*65536*/, TH = 15018/*(3.666666666)*4096 */, PRES = 0, PMIN = -500*4096;



reg[4:0] add_stage1[31:0];
reg[9:0]	add_final;
reg[7:0] ips_counter; 
reg		div_enable;

reg	start_ips_gen;
reg	next_ips_gen;
reg	maxer_valid;
wire[`W-1:0]	threshold;
reg[`W-1:0] threshold_sum;

always@(posedge clk, posedge rst)
begin
	if(rst) begin
	start_ips_gen	<= 0;
	next_ips_gen	<= 0;
	maxer_valid		<= 0;
	ips_counter 	<= 0;
	end else begin
		start_ips_gen	<= 0;
		maxer_valid		<= 0;
		div_enable		<= 0;
		
		if(maxing) begin
		
			if(ips_counter==0) begin
				start_ips_gen	<= 1;
				threshold_sum	<= 0;
			end

			if(ips_counter <= 200) begin
				next_ips_gen	<= 1;
			end else begin
				next_ips_gen	<= 0;
			end
			
			if(ips_counter>=4 && ips_counter<=204) begin
				if({14'b00000000000000,add_final}>threshold_sum) begin
				threshold_sum	<= {14'b00000000000000,add_final};
				end
			end
			
			if(ips_counter==205) begin
				div_enable 	<= 1;
			end
			
			if(ips_counter==206) begin
				maxer_valid		<= 1; 
			end
		
			if(ips_counter <= 206) begin
				ips_counter 	<= ips_counter + 1;
			end else begin
				ips_counter		<= 0;
			end
		end
	end

end



reg[1023:0]	adder_input;
always@(posedge clk,posedge rst)
begin
	if(rst) begin
	adder_input	<= 0;
	end else begin
	adder_input[M-1:0] <= ips_gen_out;
	end
end


integer i;
//ips adder function here
always@(posedge clk, posedge rst)
begin
	if(rst) begin	
		for(i=0;i<32;i=i+1) begin
		add_stage1[i] <= 0;
		end
	end else begin
		for(i=0;i<32;i=i+1) begin
		add_stage1[i] <= adder_input[i*32] + adder_input[i*32 + 1] + adder_input[i*32 + 2] + adder_input[i*32 + 3] + adder_input[i*32 + 4] + adder_input[i*32 + 5] + adder_input[i*32 + 6] + adder_input[i*32 + 7] + adder_input[i*32 + 8] + adder_input[i*32 + 9] + adder_input[i*32 + 10] + adder_input[i*32 + 11] + adder_input[i*32 + 12] + adder_input[i*32 + 13] + adder_input[i*32 + 14] + adder_input[i*32 + 15] + adder_input[i*32 + 16] + adder_input[i*32 + 17] + adder_input[i*32 + 18] + adder_input[i*32 + 19] + adder_input[i*32 + 20] + adder_input[i*32 + 21] + adder_input[i*32 + 22] + adder_input[i*32 + 23] + adder_input[i*32 + 24] + adder_input[i*32 + 25] + adder_input[i*32 + 26] + adder_input[i*32 + 27] + adder_input[i*32 + 28] + adder_input[i*32 + 29] + adder_input[i*32 + 30] + adder_input[i*32 + 31];
		end
		add_final <= add_stage1[0] + add_stage1[1] + add_stage1[2] + add_stage1[3] + add_stage1[4] + add_stage1[5] + add_stage1[6] + add_stage1[7] + add_stage1[8] + add_stage1[9] + add_stage1[10] + add_stage1[11] + add_stage1[12] + add_stage1[13] + add_stage1[14] + add_stage1[15] + add_stage1[16] + add_stage1[17] + add_stage1[18] + add_stage1[19] + add_stage1[20] + add_stage1[21] + add_stage1[22] + add_stage1[23] + add_stage1[24] + add_stage1[25] + add_stage1[26] + add_stage1[27] + add_stage1[28] + add_stage1[29] + add_stage1[30] + add_stage1[31];
	end
end

div_by_3 div1(
	.clk(clk),
	.div_enable(div_enable),
	.ip(threshold_sum),
	.op(threshold)
	);







endmodule
