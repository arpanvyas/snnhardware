`include "header.vh"

module out_nu_blk_h1(
		input				clk,rst,
		input 			    start_op_nub,
		input				TU_incre,
		input				start_core_img,
		input   [`N2-1:0]	spike_ip_nub,
		input   [8*`N2-1:0]	count,
		
		output 			    valid_op_nub,
        output  [`N3*8-1:0] count_out,
		output  [`N3-1:0]   spike_op_nub
    );
parameter M = 784, N = 8, W=24,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (3.666666666)*4096, REF = 30,
			 PRES = 0, PMIN = -500*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096;		


//The FSM for Output Neuron Block

////Inputs
wire	start_op_nub;	//from Top Module
reg	isor;				//from self: comparision
reg	li;				//from self  : based on 1st spike or not
wire	valid_nu_all;	//from nu
////Outputs
reg			isor_0_start;	//to nu
reg			isor_1_start;	//to nu
reg			valid_op_nub;	//to Top Module
	

//States
localparam	[2:0]	idle   				 	 = 3'b000, //
						isor_calc			 	 = 3'b001, //work in block
						isor_0_li_x_hold	 	 = 3'b010, //work in nu
						isor_1_li_1_hold	 	 = 3'b011, //work in nu
						isor_1_li_0_hold	    = 3'b100; //work in nu->li->nu

reg[2:0]		state_reg;
//declarations
wire[`N3-1:0]	valid_nu;
wire[`N3-1:0]	spike_op_nu;
wire[`N3-1:0]	start_li;
wire[`N3*`W-1:0] potentials;



//Others

						
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	state_reg		<= idle;
	isor_0_start	<= 0;	isor_1_start	<= 0;
	
	valid_op_nub	<= 0;
	
	end else begin 
		
		isor_0_start	<= 0;	isor_1_start	<= 0;
		valid_op_nub	<= 0;
		
		case(state_reg)
		idle: begin
					if(start_op_nub) begin
					state_reg	<= isor_calc;
					end else begin
					state_reg	<= state_reg;
					end
				end
		
		isor_calc: begin
						case ({isor,li})
							2'b00	:begin
									isor_0_start <= 1'b1;
									state_reg	 <= isor_0_li_x_hold;
									end
							2'b01 :begin
									isor_0_start <= 1'b1;
									state_reg	 <= isor_0_li_x_hold;
									end
							2'b11 		  : begin
									isor_1_start <= 1'b1;
									state_reg 	 <= isor_1_li_1_hold;
									end
							2'b10			  : begin
									isor_1_start <= 1'b1;
									state_reg	 <= isor_1_li_0_hold;
									end
							default	: begin
									state_reg 	<= idle;
									end
							endcase
					end
		isor_0_li_x_hold: begin
					if(valid_nu_all) begin
					state_reg		<= idle;
					valid_op_nub	<= 1'b1; 
					end else begin
					state_reg		<= state_reg;
					end
				end
				
		isor_1_li_1_hold: begin
					if(valid_nu_all) begin
					state_reg 	  <= idle;
					valid_op_nub  <= 1'b1;
					end else begin
					state_reg	  <= state_reg;
					end
				end

		isor_1_li_0_hold: begin  //Using non centralised but simple Nu <--> LI approach
					if(valid_nu_all) begin
					state_reg	 <= idle;
					valid_op_nub <= 1'b1;
					end else begin
					state_reg	 <= state_reg;
					end
				end
				
		default: 
				state_reg <= idle;
		endcase
	end
end





//isor unit
always@*
begin
	isor <= |spike_ip_nub;
end


//instantiate LI Unit here
wire[`N3-1:0]	won_lost;
wire			valid_li;
wire			first_spike;

//valid out nueron unit: AND all valids, Spike grabber
reg[`N3-1:0]	valid_nu_hold;
reg[`N3-1:0]	spike_op_nub;
integer		i;
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	valid_nu_hold <= 0;
	spike_op_nub  <= 0;
	end else begin
		
		if ((state_reg==isor_0_li_x_hold)|(state_reg==isor_1_li_1_hold)|(state_reg==isor_1_li_0_hold)) begin
			for(i = 0 ; i<`N3 ; i = i+1) begin
				if(valid_nu[i]) begin
					valid_nu_hold[i] <= 1'b1;
					spike_op_nub[i]  <= spike_op_nu[i];
				end else begin
					valid_nu_hold[i] <= valid_nu_hold[i];
					spike_op_nub[i]  <= spike_op_nub[i];
				end
			end
		end else begin		//when state reaches idle
			valid_nu_hold <= 0;
			if(TU_incre) begin
				spike_op_nub  <= 0;
			end
		end
	end
end
assign valid_nu_all = &valid_nu_hold;




//manage "li" reg here
always@(posedge clk,posedge rst)
begin
	if(rst) begin
	li <= 0;
	end else if (start_core_img) begin
	li	<= 0;
	end else begin
		if(first_spike) begin
			li <= 1;
			end else begin
			li <= li;
			end
	end
end



li_h1 #(.N(`N3),.W(`W),.TH(TH)) li_module(
     .clk(clk),
	  .rst(rst),
     .start_li(start_li[0]), 
     .potentials(potentials),
	  .won_lost(won_lost),	
     .valid_li(valid_li),
	  .first_spike(first_spike)
    );


//count_muxer
wire	[9:0]		ip_select;
wire	[`W-1:0]	del_w_plus;
wire	[`W-1:0] 	del_w_minus;
wire	[`N3-1:0]	start_wch;

count_muxer_h1 #(.N(`N3),.W(`W),.M(`N2)) count_muxer(
     .clk(clk),
	  .rst(rst),
     .count(count),
	  .start_wch(start_wch),
     .ip_select(ip_select),
	  .del_w_plus(del_w_plus),	
     .del_w_minus(del_w_minus)
    );

wire [`N3*8-1:0] count_out;


//put individual output neuron here: kept 1 till now

genvar ig;
generate
	for (ig=0; ig<`N3; ig=ig+1) begin
	  out_nu_h1 #(.M(`N2),.D(D),.W(`W),.N(`N3),.TH(TH),.REF(REF),
				.PRES(PRES),.PMIN(PMIN),.WMAX(WMAX),.WMIN(WMIN),
				.OP_NUM(ig)) output_neuron(
		.clk(clk),
		.rst(rst),
		.isor_0_start(isor_0_start),
		.isor_1_start(isor_1_start),
		.li(li),
		.spike_ip_nub(spike_ip_nub),
		.valid_li(valid_li),
		.won_lost(won_lost[ig]),
		.ip_select(ip_select),
		.del_w_plus(del_w_plus),
		.del_w_minus(del_w_minus),
		.start_wch(start_wch[ig]),
		.spike_op_nu(spike_op_nu[ig]),
		.potential(potentials[(ig+1)*`W-1:ig*`W]),
        .counter_fast(count_out[(ig+1)*8-1:ig*8]),
		.start_li(start_li[ig]),
		.valid_nu(valid_nu[ig]),
		.TU_incre(TU_incre),
		.start_core_img(start_core_img)
	);
		end
endgenerate





endmodule
