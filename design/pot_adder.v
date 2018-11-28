`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module pot_adder(
		input				clk,rst,
		input				TU_incre,
		input				start_core_img,
		input				start_pp1,
		input				start_pp2,
		input				start_pp3m,
		input				start_pp3,
		input				won_lost_hold,
		input[M-1:0]	spike_ip_nub,
		input[W-1:0]	data_r,
		
		output[9:0]		addr_r,
		output[W-1:0]	potential,
		output			spike_pp,
		output			valid_pp1,
		output			valid_pp2,
		output			valid_pp3m,
		output			valid_pp3,
		output			ref,
		output			dec

    );
parameter M = 784, N = 8, W=32,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (3.666666666)*4096, REF = 30,
			 PRES = 0, PMIN = -500*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096;	
			 
reg signed[W-1:0] threshold,pot_rest,decay,pot_min;			 
wire	signed[W-1:0] data_r;

//FSM and Working unit for PP
	
reg signed[W-1:0]potential;
reg				  spike_pp;//only significant in pp2 mode, for other mode the out_nu already knows
reg				  valid_pp1;
reg				  valid_pp2;
reg				  valid_pp3m;
reg				  valid_pp3;

//States
parameter [2:0]	idle 		= 3'b000,
						pp1  		= 3'b001, //i0_lix
						pp2  		= 3'b010, //i1_li1
						pp3_a 	= 3'b011, //i1_li0
						pp3_b		= 3'b100,
						pp3_c		= 3'b101;
						
reg[2:0]		state_reg;

//others
reg[9:0]		index;
reg[9:0]		addr_r;//one ahead of index
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	potential	<= PRES;
	valid_pp1	<= 0;		valid_pp2	<= 0;
	valid_pp3	<= 0;		valid_pp3m	<= 0;
	index			<= 0;		addr_r		<= 0;
	state_reg	<= idle;
	spike_pp		<= 0;
	
	end else if(start_core_img) begin
	potential	<= PRES;
	valid_pp1	<= 0;		valid_pp2	<= 0;
	valid_pp3	<= 0;		valid_pp3m	<= 0;
	index			<= 0;		addr_r		<= 0;
	state_reg	<= state_reg;
	spike_pp		<= 0;
	end else begin
		valid_pp1	<= 0;		valid_pp2	<= 0;
		valid_pp3	<= 0;		valid_pp3m	<= 0;
		
		case(state_reg)
		idle	: begin
					index 		<= 0;
					spike_pp		<= 0;
					addr_r		<= 0;
					if(start_pp1) begin
					state_reg	<= pp1;
					end else if(start_pp2) begin
					state_reg	<= pp2;
					addr_r		<= 1;
					end else if(start_pp3) begin
					state_reg	<= pp3_a;
					addr_r		<= 1;
					end else begin
					state_reg	<= idle;
					end
				end
				
		pp1	:	begin
						if(ref) begin
						potential <= potential;
						end else if(potential > PRES) begin
						potential <= potential - D;
						end else begin 
						potential <= potential;
						end
						valid_pp1 <= 1'b1;
						spike_pp	 <= 1'b0;
						state_reg <= idle;
					end
		pp2	: begin
					if(ref) begin
						valid_pp2 <= 1'b1;
						spike_pp	 <= 1'b0;
						state_reg <= idle;
					end else begin
						index 	 <= index + 1;
						addr_r	 <= addr_r + 1;
						if(index<M) begin
							if(spike_ip_nub[index]) begin
								potential <= potential + data_r;
							end
							state_reg <= state_reg;
							
						if(index==M-2 || index ==M-1) begin
							addr_r	<= 0;
						end
						
						end else if(index==M) begin
							if(potential<PMIN) begin
								potential <= PRES;
								valid_pp2 <= 1'b1;
								spike_pp	 <= 1'b0;
								state_reg <= idle;
							end else if(potential>threshold) begin
								potential <= PRES;
								valid_pp2 <= 1'b1;
								spike_pp	 <= 1'b1;
								state_reg <= idle;
							end else if(potential>PRES) begin
								potential <= potential - D;
								valid_pp2 <= 1'b1;
								spike_pp	 <= 1'b0;
								state_reg <= idle;
							end else begin // remaining between PMIN and PREST
								potential <= potential;
								valid_pp2 <= 1'b1;
								spike_pp	 <= 1'b0;
								state_reg <= idle;
							end
							index	<= 0;
							addr_r <= 0;
						 end
					  
					  end
				   end
		
		pp3_a	: begin

					index <= index + 1;
					addr_r <= addr_r + 1;
					if(index<M) begin
						if(spike_ip_nub[index]) begin
							potential <= potential + data_r;
						end
						state_reg <= state_reg;
					
						if(index==M-2 || index ==M-1) begin
							addr_r	<= 0;
						end

					end else if (index==M) begin
					valid_pp3m	<= 1'b1;
					state_reg	<= pp3_b;
					index			<= 0;
					addr_r		<= 0;
					end
				
				
				end
		
		pp3_b	: begin
					if(start_pp3m) begin
						if(won_lost_hold) begin
							if(potential<PMIN) begin
								potential <= PRES;
								valid_pp3 <= 1'b1;
								spike_pp	 <= 1'b0;
								state_reg <= idle;
							end else if(potential>threshold) begin
								potential <= PRES;
								valid_pp3 <= 1'b1;
								spike_pp	 <= 1'b1;
								state_reg <= idle;
							end else if(potential>PRES) begin
								potential <= potential - D;
								valid_pp3 <= 1'b1;
								spike_pp	 <= 1'b0;
								state_reg <= idle;
							end else begin //remaining between PMIN and PREST
								potential <= potential;
								valid_pp3 <= 1'b1;
								spike_pp	 <= 1'b0;
								state_reg <= idle;
							end
						end else begin
							if(potential>(threshold/2+PRES)) begin
							potential <= potential-threshold/2;
							end else begin
							potential <= PRES;
							end
							valid_pp3 <= 1'b1;
							spike_pp	 <= 1'b0;
							state_reg <= idle;
						end
					
					end else begin 
					state_reg	<= state_reg;
					end
				end
		default: begin //went to some unknown state, go to idle
					state_reg	<= idle;
				end
		endcase
	end	
end			


//ref module
//0 state is unstable, it goes from 0 to 1 in the same TU
//1,2,3,...,20 : 20 TUs; at 21 dec=1 thus it cares to dec weights
wire			ref;
reg[5:0]		ref_counter;
reg			dec;
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	ref_counter	<= REF+1;
	dec			<= 0;
	end else begin
		if	(TU_incre) begin
			if(ref_counter < REF+1) begin
			ref_counter <= ref_counter + 1;
			end else begin
			ref_counter <= ref_counter;
			end
		end else if(valid_pp2|valid_pp3) begin
			if(spike_pp) begin
			ref_counter	<= 0;
			end
		end else begin
			ref_counter <= ref_counter;
		end
		
		if(ref_counter==21) begin
			dec	<= 1'b1;
		end else begin
			dec 	<= 1'b0;
		end
		
	end
end		 

assign ref = ~(ref_counter==REF+1);

always@(posedge clk, posedge rst)
begin
	if(rst) begin
	threshold	<= 0;
	end else begin
		if(tb.uut.core.valid_maxing) begin
			threshold <= (tb.uut.core.threshold);
		end
	end
end


endmodule
