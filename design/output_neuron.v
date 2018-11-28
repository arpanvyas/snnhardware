`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate

module out_nu(
		input				clk,rst,
		input				TU_incre,
		input				start_core_img,
		input 			isor_0_start,
		input				isor_1_start,
		input				li,
		input[M-1:0]	spike_ip_nub,
		input				valid_li,
		input				won_lost,
		input[9:0]		ip_select,
		input[23:0]		del_w_plus,
		input[23:0]		del_w_minus,
		
		output			start_wch,
		output			spike_op_nu,
		output			potential,
		output			start_li,
		output 			valid_nu
    );
parameter M = 784, N = 8, W=24,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (3.666666666)*4096, REF = 30,
			 PRES = 0, PMIN = -500*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096, OP_NUM = 1;		
//The FSM for Output Neuron Block

////Inputs
wire	isor_0_start;	//from Block
wire	isor_1_start;	//from Block
wire	li;				//from Li  : based on 1st spike or not
wire	valid_pp1;
wire	valid_pp2;
wire	valid_pp3m;
wire	valid_pp3;
wire	spike_pp;
wire	valid_wch;
wire	valid_li;
wire	won_lost;
wire	dec;

////Outputs
reg	valid_nu;	
reg	spike_op_nu;
reg	start_wch;
reg	start_pp1;
reg	start_pp2;
reg	start_pp3m;
reg	start_pp3;
reg	start_li;

//States
localparam	[3:0]	idle   			= 4'b0000,//0
						i0_lix_pp		= 4'b0001,//1
						i0_lix_wch		= 4'b0010,//2
					
						i1_li1_pp	 	= 4'b0011,//3
						i1_li1_wch		= 4'b0100,//4

						i1_li0_pp_a		= 4'b0101,//5
						i1_li0_li		= 4'b0110,//6
						i1_li0_pp_b		= 4'b0111,//7
						i1_li0_wch		= 4'b1000;//8
						
reg[3:0]		state_reg;

//Others
reg	spike_hold;
reg	won_lost_hold;
						
always@(posedge clk, posedge rst)
begin
	if(rst) begin
		state_reg	<= idle;
		valid_nu <= 0;	won_lost_hold <= 0;
		spike_op_nu <= 0; spike_hold 	  <= 0;
		
		start_pp1	<= 0; start_pp2	  <= 0;
		start_pp3	<= 0; start_pp3m	  <= 0;
		start_wch	<= 0; start_li		  <= 0;

		
	end else begin 
		
		valid_nu <= 0;
		spike_op_nu <= 0;
		
		start_pp1	<= 0; start_pp2	<= 0;
		start_pp3	<= 0; start_pp3m	<= 0;
		start_wch	<= 0; start_li		<= 0;
		
		case(state_reg)
		idle: begin								//DONE
					if(isor_0_start) begin
					state_reg	<= i0_lix_pp;
					start_pp1	<= 1'b1;
					end else if((isor_1_start) & (li)) begin
					state_reg	<= i1_li1_pp;
					start_pp2	<= 1'b1;
					end else if((isor_1_start) & (~li)) begin
					state_reg	<= i1_li0_pp_a;
					start_pp3	<= 1'b1;
					end else begin
					state_reg	<= state_reg;
					end
					spike_hold		<= 0;
					won_lost_hold	<= 0;
				end
		
		//doing the i0_lix states		//DONE 
		i0_lix_pp: begin
					if(valid_pp1) begin
						case(dec)
						1'b0	: begin
								spike_op_nu		<= 1'b0;
								spike_hold		<= 1'b0;
								valid_nu		   <= 1'b1;
								state_reg		<= idle;
							end
						1'b1	: begin
								state_reg		<= i0_lix_wch;
								spike_hold		<= 1'b0;
								start_wch		<= 1'b1;
							end
						default: begin
								state_reg		<= idle;	//some trouble, go idle!
							end	
						endcase
					end else begin
					state_reg		<= state_reg;
					end
				end
		
		i0_lix_wch: begin
					if(valid_wch) begin
					valid_nu		<= 1'b1;
					spike_op_nu		<= 1'b0;
					state_reg		<= idle;
					end else begin
					state_reg		<= state_reg;
					end
				end

		//doing the i1_li1 states  //DONE
		i1_li1_pp: begin
					if(valid_pp2) begin
						case({spike_pp,dec})
		
						2'b00:	begin
								valid_nu	<= 1'b1;
								spike_op_nu	<= 1'b0;
								spike_hold	<= 1'b0;
								state_reg	<= idle;
							end
						2'b01:	begin
								start_wch		<= 1'b1;	//decreasing
								spike_hold		<= 1'b0;
								state_reg		<= i1_li1_wch; 
							end
						2'b10:	begin
								start_wch		<= 1'b1;	//increasing
								spike_hold		<= 1'b1;
								state_reg		<= i1_li1_wch;
							end
						default: begin
								state_reg		<= idle; //some trouble, go to idle!
							end
						endcase
						
					end else begin
					state_reg	  <= state_reg;
					end
				end
		i1_li1_wch: begin
					if(valid_wch) begin
					valid_nu		<= 1'b1;
					spike_op_nu		<= spike_hold;
					state_reg		<= idle;
					end else begin
					state_reg		<= state_reg;
					end
				end
		
		
		//doing the i1_li0 states  //DONE
		i1_li0_pp_a: begin  //send to LI
					if(valid_pp3m) begin
					start_li			<= 1'b1;
					state_reg		<= i1_li0_li;
					end else begin
					state_reg		<= state_reg;
					end
				end
		i1_li0_li: begin	 //send to pp again
					if(valid_li) begin
					won_lost_hold	<= won_lost;
					start_pp3m		<= 1'b1;			//it knows the win/loss by won_lost(1 clk) or won_lost_hold (ans. hold)
					state_reg		<= i1_li0_pp_b;
					end else begin
					state_reg		<= state_reg;
					end
				end
		i1_li0_pp_b: begin	//send to idle OR wch
					if(valid_pp3) begin
						case({won_lost_hold,spike_pp})
						2'b00	: begin	//lost it, go idle
									valid_nu		<= 1'b1;
									spike_op_nu		<= 1'b0;
									spike_hold		<= 1'b0;
									state_reg		<= idle;
								 end
						2'b10	: begin	//no one spiked
									valid_nu		<= 1'b1;
									spike_op_nu		<= 1'b0;
									spike_hold	<= 1'b0;
									state_reg	<= idle;
								end
						2'b11	: begin	//winner, increase the weights
									start_wch	<= 1'b1;
									spike_hold	<= 1'b1;
									state_reg	<= i1_li0_wch;
								end
						default: begin
								state_reg	<= idle; //some trouble, go to idle!	
								end
						endcase
					end else begin
					state_reg	<= state_reg;
					end
				end
		
		i1_li0_wch: begin	// go to idle
					if(valid_wch) begin
					spike_op_nu	<= 1'b1;
					spike_hold	<= 1'b1;
					valid_nu	<= 1'b1;
					state_reg	<= idle;
					end else begin
					state_reg	<= state_reg;
					end
				end
		default: begin						//some trouble, state_reg is not among the 9, go to idle!
				state_reg <= idle;
				end
		endcase
	end
end 

//Controlling Weight RAM
wire signed[W-1:0]			potential;
wire[W-1:0]		data_w;
wire[W-1:0]		data_r;
reg[9:0]			addr_r;
wire[9:0]		addr_w;
wire[9:0]		pot_addr_r;
wire[9:0]		wt_addr_r;
wire				we;

always@*
begin
	case (state_reg)
		idle:
			addr_r		<= 0;
		i0_lix_pp :
			addr_r		<= pot_addr_r;
		i1_li1_pp :
			addr_r		<= pot_addr_r;
		i1_li0_pp_a :
			addr_r		<= pot_addr_r;
		i1_li0_pp_b :
			addr_r		<= pot_addr_r;
		i0_lix_wch :
			addr_r		<= wt_addr_r;
		i1_li1_wch :
			addr_r		<= wt_addr_r;
		i1_li0_wch :
			addr_r		<= wt_addr_r;
	default:
			addr_r		<= 0;
	endcase
end



//make PP here: has ref and dec
pot_adder #(.M(M),.D(D),.TH(TH),.REF(REF),
				.PRES(PRES),.PMIN(PMIN),.W(W),.N(N),.WMAX(WMAX),.WMIN(WMIN)) potential_adder_unit(

		.clk(clk),
		.rst(rst),
		.TU_incre(TU_incre),
		.start_core_img(start_core_img),
		.start_pp1(start_pp1),
		.start_pp2(start_pp2),
		.start_pp3m(start_pp3m),
		.start_pp3(start_pp3),
		.won_lost_hold(won_lost_hold),
		.spike_ip_nub(spike_ip_nub),
		.data_r(data_r),
		
		.addr_r(pot_addr_r),
		.potential(potential),
		.spike_pp(spike_pp),
		.valid_pp1(valid_pp1),
		.valid_pp2(valid_pp2),
		.valid_pp3m(valid_pp3m),
		.valid_pp3(valid_pp3),
		.ref(ref),
		.dec(dec)
    );


//weight change here
weight_change #(.M(M),.D(D),.TH(TH),.REF(REF),
				.PRES(PRES),.PMIN(PMIN),.W(W),.N(N),.WMAX(WMAX),.WMIN(WMIN)) wch(
	.clk(clk),
	.rst(rst),
	.start_wch(start_wch),
	.spike_hold(spike_hold),
	.ip_select(ip_select),
	.del_w_plus(del_w_plus),
	.del_w_minus(del_w_minus),
	.data_r(data_r),
	
	.data_w(data_w),
	.addr_r(wt_addr_r),
	.addr_w(addr_w),
	.we(we),
	.valid_wch(valid_wch) 
);

ram_weight #(.M(M),.D(D),.TH(TH),.REF(REF),
				.PRES(PRES),.PMIN(PMIN),.W(W),.N(N),.OP_NUM(OP_NUM)) ram_wt(
	.clk(clk),
	.data_w(data_w),
	.addr_r(addr_r),
	.addr_w(addr_w),
	.data_r(data_r),
	.we(we),
	.start_core_img(start_core_img)
);

endmodule


