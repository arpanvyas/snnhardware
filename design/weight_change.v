module weight_change(
	input				clk,
	input				rst,
	input				start_wch,
	input				spike_hold,//tells to increase(1) or decrease(0)
	input[9:0]		ip_select,
	input[23:0]		del_w_plus,
	input[23:0]		del_w_minus,
	input[W-1:0]	data_r,
	
	output[W-1:0]	data_w,
	output[9:0]		addr_r,
	output[9:0]		addr_w,
	output			we,
	output			valid_wch
    );
reg	valid_wch;	 
parameter M = 784, N = 8, W=24,
			 IM_WID = 28, IM_HEI = 28,
			 D = (0.15)*4096, TH = (3.666666666)*4096, REF = 30,
			 PRES = 0, PMIN = -500*4096, WMAX = 1.5*4096,
			 WMIN = -1.2*4096;		
			 
wire signed [W-1:0] data_r;
reg signed[23:0]	wold[2:0];
reg[23:0] ip_select_h[4:0];
reg		start_wch_h[4:0];
wire signed[23:0] wmax;
wire signed[23:0] wmin;
reg signed[23:0] wdiff_plus;
reg signed[23:0] wdiff_minus;
reg signed[23:0] multi_plus;
reg signed[23:0] multi_minus;
reg signed[23:0] multi_plus_shifted;
reg signed[23:0] multi_minus_shifted;
reg[23:0] add;
assign wmax = WMAX;
assign wmin = WMIN;

assign addr_w = ip_select_h[0];
assign addr_r = ip_select;
reg signed[W-1:0]	data_w;
reg	we;
//FSM for Work Flow
//States
localparam			idle   				 	 = 1'b0, //idle
						working				 	 = 1'b1; //working
reg			state_reg;
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	state_reg		<= idle;
	valid_wch		<= 0;
	we					<= 0;
	data_w			<= 0;
	end else begin 
		valid_wch	<= 0;
		case(state_reg)
		idle: begin
					if(start_wch) begin
					state_reg	<= working;
					end else begin
					state_reg	<= idle;
					end
					we		<= 0;
				end
		working: begin 
					if(start_wch_h[0]==1 || ip_select_h[0]>0) begin
						we	<= 1;
						case(spike_hold_h) //Writing to RAM here
							1'b1:data_w <= multi_minus_shifted + wold[0]; //increasing weights here
							//weight[ip_select_h[0]] <= multi_minus + wold[0];
							//assign addr_w = ip_select_h[0];
							1'b0:data_w	<= multi_plus_shifted + wold[0]; //decreasing weights here
							//weight[ip_select_h[0]] <= multi_plus + wold[0];
							//assign addr_w = ip_select_h[0];
						endcase
					end
					
					if(ip_select_h[0]==M-1) begin
					we	<= 0;
					valid_wch	<= 1;
					state_reg	<= idle;
					end
				end
		default: 
				state_reg <= idle;
		endcase
	end
end


reg	spike_hold_h;
always@(posedge clk,posedge rst)
begin
	if(rst) begin
	spike_hold_h	<= 0;
	end else begin
		if(start_wch) begin
		spike_hold_h	<= spike_hold;
		end
	end
end




//ip_select to Wold: Mux
always@(posedge clk,posedge rst)
begin
	if(rst) begin
	wold[0]		  <= 0;
	wold[1]		  <= 0;
	ip_select_h[0] <= 0;
	ip_select_h[1] <= 0;
	ip_select_h[2] <= 0;
	ip_select_h[3] <= 0;
	wdiff_plus		<= 0;
	wdiff_minus		<= 0;
	multi_plus		<= 0;
	multi_minus		<= 0;
	multi_plus_shifted	<= 0;
	multi_minus_shifted	<= 0;
	end else begin
	
	start_wch_h[4] <= start_wch;
	start_wch_h[3]	<= start_wch_h[4];
	start_wch_h[2] <= start_wch_h[3];
	start_wch_h[1] <= start_wch_h[2];
	start_wch_h[0] <= start_wch_h[1];
	
	
	ip_select_h[4] <= ip_select;
	ip_select_h[3] <= ip_select_h[4];
	ip_select_h[2] <= ip_select_h[3];
	ip_select_h[1] <= ip_select_h[2];
	ip_select_h[0] <= ip_select_h[1];
	
	//Reading from RAM here
	//wold[2]	<= weight[ip_select];
	//wold[1]	<= wold[2];
	//wold[2] replaced by data_r by assign statement below;
	wold[2]	<= data_r;
	wold[1]	<= wold[2];
	wold[0]	<= wold[1];
	wdiff_minus		<= wmax - data_r;	// this minus is A- --> actually increasing weights
	wdiff_plus		<= data_r - wmin; // this plus is A+  --> actually decreasing weights
	
	multi_minus		<= (wdiff_minus*del_w_minus);//look at this
	multi_plus		<= (wdiff_plus*del_w_plus);//look at this
	
	multi_plus_shifted <= multi_plus>>>8;
	multi_minus_shifted <= multi_minus>>>8;
	end
end


endmodule
