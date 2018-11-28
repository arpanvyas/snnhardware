`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module ips_generator(
    input clk,
    input rst,
    input [M*8-1:0] rf_freq_packed,
    input start_ips_gen,
    input next_ips_gen,
	 input rf_buffering_done,
    output [M-1:0] ips_gen_out
    );

parameter M=784, N=8, W=8, D = 1,IM_WID = 28, IM_HEI = 28,
			 REF = 30, TH = 5, PRES = 0, PMIN = -1;	 


`UNPACK_ARRAY(8,M,rf_freq_buffer,rf_freq_packed)

wire[7:0] rf_freq_buffer[M-1:0];
reg [7:0] ips_counters[M-1:0];
reg[7:0]	 TU_counter;
reg[M-1:0] ips_gen_out;

initial begin
		$readmemb("/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/ips_counters_init.bin",ips_counters);
end

integer i,j;
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	TU_counter	<= 0;
	ips_gen_out <= 0;
	end else begin
		if(rf_buffering_done|TU_counter == 200) begin
			for(i=0;i<M;i=i+1) begin
				ips_counters[i]	<= rf_freq_buffer[i]; 
			end
		end
		
		case({start_ips_gen,next_ips_gen})
			2'b00: begin
						TU_counter <= TU_counter;
					 end
			2'b01: begin
						TU_counter <= TU_counter + 1;
					 end
			2'b10: begin
						TU_counter <= 0;
					 end
			2'b11: begin
						TU_counter <= TU_counter + 1;
		  			 end
		default: begin
						TU_counter <= TU_counter;
					end
		endcase
		
		if(TU_counter==200) begin
				TU_counter <= 0;
		end



//this was the code for non random patterns		
		if(next_ips_gen) begin
			for(j=0;j<M;j=j+1) begin
				ips_counters[j] <= ips_counters[j] - 1;
				
				if(ips_counters[j] == 0) begin
					ips_counters[j] <= rf_freq_buffer[j];
					ips_gen_out[j] <= 1;
				end else begin
					ips_gen_out[j] <= 0;	
				end
			end
		end


	
	end
end


//genvar k;
//generate for(k=0;k<M;k=k+1)
//begin
//	random_number_generator rng(
//	.clk(clk),
//	.rst(rst),
//	.lfsr_shift(next_ips_gen),
//	.rf_freq_buffer(rf_freq_buffer[k]),
//	.seed(seeds[k]),
//	.out(ips_gen_out[k])
//	);
//end
//endgenerate
//
//reg [15:0] seeds [M-1:0];
//initial
//begin
//	$readmemb("/home/arpan/Desktop/BTP/AI Block/SNN/SNN Summer Work/Code till 4th May 2017/testbench_files/seeds.dat",seeds);
//end


endmodule
