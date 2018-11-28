`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module li(
    input clk,rst,
    input start_li,
    input [N*W-1:0] potentials,
	 output[N-1:0] won_lost,	
    output valid_li,
	 output first_spike
    );

parameter W = 24, N = 8, TH = 90;

reg [W-1:0] unpacked_pot[15:0];

always@(posedge clk, posedge rst) begin
	if(rst) begin
		for(i3=0; i3<16 ; i3 = i3+1) begin
		unpacked_pot[i3] <= 0;
		end
	end else begin
	unpacked_pot[0] <= potentials[23:0];
	unpacked_pot[1] <= potentials[47:24];
	unpacked_pot[2] <= potentials[71:48];
	unpacked_pot[3] <= 0;
	unpacked_pot[4] <= 0;
	unpacked_pot[5] <= 0;
	unpacked_pot[6] <= 0;
	unpacked_pot[7] <= 0;
	unpacked_pot[8] <= 0;
	unpacked_pot[9] <= 0;
	unpacked_pot[10] <= 0;
	unpacked_pot[11] <= 0;
	unpacked_pot[12] <= 0;
	unpacked_pot[13] <= 0;
	unpacked_pot[14] <= 0;
	unpacked_pot[15] <= 0;
	end

end


reg [W-1:0]first_stage[7:0];
reg [W-1:0]second_stage[3:0];
reg [W-1:0]third_stage[1:0];
reg [W-1:0]final;
reg [N-1:0]won_lost;
reg valid_li;
reg first_spike;

localparam [2:0]	idle		= 3'b000,
					compare		= 3'b001,
					spike_yes	= 3'b010,
					spike_no		= 3'b011;
					
reg [3:0]state_reg;
integer i,i1,i2,i3;
reg[2:0] count;

always@(posedge clk, posedge rst) begin
	if(rst) begin
		state_reg <=idle;
		valid_li  <= 0;
		won_lost  <= 0;
		count		 <= 0; first_spike <= 0;

		for(i1=0;i1<8;i1=i1+1) 
			first_stage[i1] <= 0;
			
		for(i1=0;i1<4;i1=i1+1) 
			second_stage[i1] <= 0;
		
		for(i1=0;i1<2;i1=i1+1)
			third_stage[i1] <= 0;
		final		 <= 0;
		
	end else begin
		
		valid_li 	<= 0;
		won_lost  	<= 0;
		first_spike <= 0;
		
		case(state_reg)		
			idle:begin
				if(start_li)
					state_reg	<= compare;
				else
					state_reg	<= idle;
				count <= 0;
			end

			compare:begin
				count	<= count + 1;
				case(count)
				3'b000: begin
							for(i=0;i<16;i=i+2) begin
								if(unpacked_pot[i]>unpacked_pot[i+1])
									first_stage[i/2] <= i;
								else
									first_stage[i/2] <= i+1;
							end
						end
				
			   3'b001: begin
						for(i=0;i<8;i=i+2) begin
							if(unpacked_pot[first_stage[i]]>unpacked_pot[first_stage[i+1]])
								second_stage[i/2] <= first_stage[i];
							else
								second_stage[i/2] <= first_stage[i+1];
					   end
					end

				3'b010: begin
						for(i=0;i<4;i=i+2) begin
							if(unpacked_pot[second_stage[i]]>unpacked_pot[second_stage[i+1]])
								third_stage[i/2] <= second_stage[i];
							else
								third_stage[i/2] <= second_stage[i+1];
						end
					end
				
				3'b011: begin
							if(unpacked_pot[third_stage[0]]>unpacked_pot[third_stage[1]])
								final <= third_stage[0];
							else
								final <= third_stage[1];
						end
					
				3'b100: begin
						if(unpacked_pot[final]>TH)
							state_reg	<= spike_yes;
						else
							state_reg	<= spike_no;
						count <= 0;
					end
				
				default: begin	//oops, go back idle
						state_reg	<= idle;
						end
				endcase
				end
			
		
			spike_no: begin	//state 3
				won_lost		<= 3'b111;
				valid_li		<= 1;
				first_spike <= 0;
				state_reg	<= idle;
			end

			spike_yes: begin  //state 2
				won_lost[final]	<= 1;
				valid_li 			<= 1;
				first_spike			<= 1;
				state_reg			<= idle;
			end
			
			default: begin	//unknown state encountered, go to idle
				state_reg	<= idle;
			end
			
		endcase

	end
end



endmodule

