module time_unit(
	input				clk,rst,
	
	input				valid_ips,
	input				valid_ip_nub,
	input				valid_op_nub,
	input				start_core_img,
	
	output			start_ip_nub,
	output			start_op_nub,
	output[15:0]	TU,
	output			TU_incre,
	output			done_core_img
    );
	 
//input output declaration
wire		clk,rst;

wire		valid_ips;
wire		valid_ip_nub;
wire		valid_op_nub;

reg		start_ip_nub;
reg		start_op_nub;

reg[15:0]		TU;
reg				TU_incre;
reg				done_core_img;

localparam	[2:0]	idle   	 = 3'b000,
						ip_nub	 = 3'b001,
						op_nub 	 = 3'b010;
						
reg[2:0]		state_reg;


always @(posedge clk,posedge rst)
begin
	if (rst) begin
		state_reg 		<= idle;
		TU				 	<= 16'b0000000000000000;
		start_ip_nub	<=	0;
		start_op_nub	<=	0;
		done_core_img	<= 0;
		TU_incre			<= 0;
	end else begin
		done_core_img			<= 0;
		start_ip_nub			<= 1'b0;
		start_op_nub		   <= 1'b0;
		TU_incre					<= 1'b0;
		
		case (state_reg)
		idle: begin
					if (valid_ips) begin
						state_reg		 	<= ip_nub;
						start_ip_nub   	<= 1'b1;
					end else begin
						state_reg 	 		<= idle;
					end
				end
		ip_nub: begin
					if (valid_ip_nub) begin
						state_reg 			<= op_nub;
						start_op_nub	 	<= 1'b1;
					end else begin
						state_reg 			<= ip_nub;
					end
				end
		op_nub:  begin
					if (valid_op_nub) begin
						state_reg 	<= idle;
						TU_incre		<= 1'b1;
						TU <= TU + 1;
						if(TU==199) begin
							done_core_img <= 1;
							TU <= 0;
						end
					end else begin
						state_reg		<= op_nub;
					end
				end
		default: begin
							state_reg <= idle;
						end
		endcase
		
	end
end


endmodule
