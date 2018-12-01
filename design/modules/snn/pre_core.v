`include "header.vh"

module pre_core(
    input	clk,
    input	rst,	
	 input	[1:0]	train_test_classify,
    input	[31:0] image_in,
	 input	valid_image,
	 input	TU_incre,
	 input	buffering,
	 input	rfing,
	 input	maxing,
	 input 	coring,
	  
    output	valid_buffering, 
	 output	valid_rfing,
	 output	valid_maxing,
	 output[`W-1:0]threshold,
	 output	[`M-1:0] ips,
	 output	valid_ips
    );

parameter M=784, N=8, W=24, D = 1,IM_WID = 28, IM_HEI = 28,
			 REF = 30, TH = 5, PRES = 0, PMIN = -1;	 

reg[7:0]		 img_buff[M-1:0];
reg[7:0]		 rf_freq_buffer[M-1:0];


integer counter;
integer coring_counter;
reg[N-1:0]	 rfbuffering;
reg	rf_buffering_done;
reg	ips_gen_driver;
reg	valid_buffering;
reg	valid_rfing; 
wire	valid_maxing;
reg	rfing1;
integer row;
integer column;
integer i_13,i_23,i_33,i_43,i_53;
integer rf_freq_index;
integer i;

reg[7:0] val1,val2,val3,val4,val5;
reg[7:0] val6,val7,val8,val9,val10;
reg[7:0] val11,val12,val13,val14,val15;
reg[7:0] val16,val17,val18,val19,val20;
reg[7:0] val21,val22,val23,val24,val25;
wire[7:0] val_out;

wire			start_ips_gen;
wire			start_ips_gen_maxer;
reg			start_ips_gen_core;

wire			next_ips_gen;
wire			next_ips_gen_maxer;
reg			next_ips_gen_core;

wire[M-1:0]	ips_gen_out;
wire[M-1:0] ips;
assign		ips = ips_gen_out;

reg	valid_ips_h, valid_ips;
reg 	once_coring_counter;


wire[M*8-1:0] rf_freq_packed;

always @(*)
begin
	i_13 <= i_33 - IM_WID - IM_WID;
	i_23 <= i_33 - IM_WID;
	i_43 <= i_33 + IM_WID;
	i_53 <= i_33 + IM_WID + IM_WID;
end



always@(posedge clk, posedge rst) 
begin
	if(rst) begin
	counter 				<= 0;
	rfbuffering			<= 0;
	i_33					<= 0;
	rf_freq_index		<= 0;
	rf_buffering_done <= 0;
	valid_buffering	<= 0; 
	valid_rfing 		<= 0;
	valid_ips_h			<= 0;
	
	start_ips_gen_core	<= 0;
	next_ips_gen_core		<= 0;
	valid_ips_h    <= 0;
	coring_counter <= 0;
	once_coring_counter <= 0;
	
	{val1,val2,val3,val4,val5}			<= 0;
	{val6,val7,val8,val9,val10}		<= 0;
	{val11,val12,val13,val14,val15}	<= 0;
	{val16,val17,val18,val19,val20}	<= 0;
	{val21,val22,val23,val24,val25}	<= 0;	
	
	end else begin
		//in Train, Test and Classify : Putting input image in buffer
		valid_buffering	<= 0;
		valid_rfing			<= 0;
		start_ips_gen_core	<= 0;
		next_ips_gen_core		<= 0;
		valid_ips_h    <= 0;
		
		for(i=1;i<4;i=i+1) begin
			rfbuffering[i-1] <= rfbuffering[i];
		end		
		
		//buffering
		if(buffering) begin
			
			if(valid_image) begin
				img_buff[counter]	<= image_in[7:0] ;
				img_buff[counter+1]	<= image_in[15:8] ;
				img_buff[counter+2]	<= image_in[23:16] ;
				img_buff[counter+3]	<= image_in[31:24] ;
				counter							<= counter+4;
				
				if(counter==780) begin
					counter				<= 0;
					valid_buffering	<= 1;
					row					<= 1;
					column				<= 1;
					i_33					<= 0;

				end
			end
		end
		
		
		//rfing: 1. rfing1 2. rfbuffering
		if(rfing) begin
			
			if(rfing1|~rfbuffering) begin
				
				rfing1	<= 1;
					
					case(row)
					1:
						begin
							case(column)
							
							1:			begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= 0; val8<=0; val9 <= 0; val10 <= 0;
										val11<= 0; val12<= 0; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= 0; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= 0; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];

										end
							2:			begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= 0; val8<=0; val9 <= 0; val10 <= 0;
										val11<= 0; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
							
										end
							IM_WID-1:begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= 0; val8<=0; val9 <= 0; val10 <= 0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=0;
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=0;
							
										end
							IM_WID: 	begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= 0; val8<=0; val9 <= 0; val10 <= 0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=0; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=0;	val20 <=0;
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53];val24<=0; val25 <=0;
							
										end
							default: begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= 0; val8<=0; val9 <= 0; val10 <= 0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33];   val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43] ;  val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53];   val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
							
										end
							endcase
						end
					
					2:
						begin
							case(column)
							
							1:			begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= 0; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <= img_buff[i_23+2];
										val11<= 0; val12<= 0; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= 0; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= 0; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
										end
							2:			begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= img_buff[i_23-1]; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <= img_buff[i_23+2];
										val11<= 0; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
										end
							IM_WID-1:begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=0;
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=0;
										end
							IM_WID: 	begin
										val1 <= 0; val2 <= 0; val3<=0; 				  val4 <= 0; val5 <= 0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8<=img_buff[i_23]; val9 <= 0; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=0; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=0; val20 <=0;
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=0; val25 <=0;
										end
							default: begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <= img_buff[i_23+2];
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
										end
							endcase
						end
						
						
						
					IM_HEI-1:
						begin
							case(column)
							1:			begin
										val1 <= 0; val2 <= 0; val3<=img_buff[i_13]; val4 <= img_buff[i_13+1]; val5 <= img_buff[i_13+2];
										val6 <= 0; val7 <= 0; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <= img_buff[i_23+2];
										val11<= 0; val12<= 0; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= 0; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= 0; val23<=0; 					val24<=0; 					 val25 <=0;
										end
							2:			begin
										val1 <= 0; val2 <= img_buff[i_13-1]; val3<=img_buff[i_13]; val4 <= img_buff[i_13+1]; val5 <= img_buff[i_13+2];
										val6 <= 0; val7 <= img_buff[i_23-1]; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <= img_buff[i_23+2];
										val11<= 0; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= 0; val23<=0; 					val24<=0; 					 val25 <=0;
										end
							IM_WID-1:begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=img_buff[i_13+1]; val5  <=0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=img_buff[i_23+1]; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=0;
										val21<= 0; val22<= 0; val23<=0; 					val24<=0; 					 val25 <=0;
										end
							IM_WID: 	begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=0; val5  <=0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=0; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=0; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=0; val20 <=0;
										val21<= 0; val22<= 0; val23<=0; val24<=0; val25 <=0;
										end
							default: begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=img_buff[i_13+1]; val5  <=img_buff[i_13+2];
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=img_buff[i_23+1]; val10 <=img_buff[i_23+2];
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= 0; val23<=0; 					val24<=0; 					 val25 <=0;								end
							endcase
						end
					
					
					IM_HEI:
						begin
							case(column)
							
							1:			begin
										val1 <= 0; val2 <= 0; val3<=img_buff[i_13]; val4 <= img_buff[i_13+1]; val5 <= img_buff[i_13+2];
										val6 <= 0; val7 <= 0; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <= img_buff[i_23+2];
										val11<= 0; val12<= 0; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= 0; val18<=0; val19<=0; val20 <=0;
										val21<= 0; val22<= 0; val23<=0; val24<=0; val25 <=0;
										end
							2:			begin
										val1 <= 0; val2 <= img_buff[i_13-1]; val3<=img_buff[i_13]; val4 <= img_buff[i_13+1]; val5 <= img_buff[i_13+2];
										val6 <= 0; val7 <= img_buff[i_23-1]; val8<=img_buff[i_23]; val9 <= img_buff[i_23+1]; val10 <= img_buff[i_23+2];
										val11<= 0; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= 0; val18<=0; val19<=0; val20 <=0;
										val21<= 0; val22<= 0; val23<=0; val24<=0; val25 <=0;
										end
							IM_WID-1:begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=img_buff[i_13+1]; val5  <=0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=img_buff[i_23+1]; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=0;
										val16<= 0; val17<= 0; val18<=0; val19<=0; val20 <=0;
										val21<= 0; val22<= 0; val23<=0; val24<=0; val25 <=0;
										end
							IM_WID: 	begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=0; val5  <=0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=0; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=0; val15 <=0;
										val16<= 0; val17<= 0; val18<=0; val19<=0; val20 <=0;
										val21<= 0; val22<= 0; val23<=0; val24<=0; val25 <=0;
										end
							default: begin
										val1 <= 0; val2 <= 0; val3<=0; val4 <= 0; val5 <= 0;
										val6 <= 0; val7 <= 0; val8<=0; val9 <= 0; val10 <= 0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= 0; val18<=0; val19<=0; val20 <=0;
										val21<= 0; val22<= 0; val23<=0; val24<=0; val25 <=0;
										end
							endcase
						end
					
					
					default:
						begin
							case(column)
							
							1:			begin
										val1 <= 0; val2 <= 0; val3 <=img_buff[i_13]; val4 <=img_buff[i_13+1]; val5  <=img_buff[i_13+2];
										val6 <= 0; val7 <= 0; val8 <=img_buff[i_23]; val9 <=img_buff[i_23+1]; val10 <=img_buff[i_23+2];
										val11<= 0; val12<= 0; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= 0; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= 0; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
										end
							2:			begin
										val1 <= 0; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=img_buff[i_13+1]; val5  <=img_buff[i_13+2];
										val6 <= 0; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=img_buff[i_23+1]; val10 <=img_buff[i_23+2];
										val11<= 0; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= 0; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= 0; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
										end
							IM_WID-1:begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=img_buff[i_13+1]; val5  <=0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=img_buff[i_23+1]; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=0;
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=0;
										end
							IM_WID: 	begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=0; val5  <=0;
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=0; val10 <=0;
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=0; val15 <=0;
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=0; val20 <=0;
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=0; val25 <=0;
										end
							default: begin
										val1 <= img_buff[i_13-2]; val2 <= img_buff[i_13-1]; val3 <=img_buff[i_13]; val4 <=img_buff[i_13+1]; val5  <=img_buff[i_13+2];
										val6 <= img_buff[i_23-2]; val7 <= img_buff[i_23-1]; val8 <=img_buff[i_23]; val9 <=img_buff[i_23+1]; val10 <=img_buff[i_23+2];
										val11<= img_buff[i_33-2]; val12<= img_buff[i_33-1]; val13<=img_buff[i_33]; val14<=img_buff[i_33+1]; val15 <=img_buff[i_33+2];
										val16<= img_buff[i_43-2]; val17<= img_buff[i_43-1]; val18<=img_buff[i_43]; val19<=img_buff[i_43+1]; val20 <=img_buff[i_43+2];
										val21<= img_buff[i_53-2]; val22<= img_buff[i_53-1]; val23<=img_buff[i_53]; val24<=img_buff[i_53+1]; val25 <=img_buff[i_53+2];
										end
							endcase
						end
					endcase
					
					i_33		<= i_33 + 1;
					column	<= column + 1;
					
					if(column==IM_WID) begin
						column <= 1;
						row 	 <= row + 1;
						if(row==IM_HEI) begin
							row 	<= 1;
							i_33  <= 0;
							rfing1 <= 0;
						end
					end
					
					if(i_33==5) begin
						rfbuffering[3]	<= 1; 
					end
					
				end
		
				if(rfbuffering[0]) begin		
					rf_freq_buffer[rf_freq_index] <= val_out;
					rf_freq_index					<= rf_freq_index+1;	
					
					if(rf_freq_index==M-1) begin
						 rf_freq_index <= 0;
						 rfbuffering   <= 0;
						 valid_rfing   <= 1;	 
					end
				end
		end
		
		
		if(coring) begin //(training_part_2,classification,testing)-->starts_ips_generator && core
			start_ips_gen_core	<= 0;
			next_ips_gen_core		<= 0;
			valid_ips_h    <= 0;

			
			//assuming its giving ips in just next cycle of next_ips_gen
			if(coring_counter==0 && once_coring_counter==0) begin
			start_ips_gen_core <= 1;
			next_ips_gen_core  <= 1;
			valid_ips_h   <= 1;
			once_coring_counter <= 1;
			end else begin
			start_ips_gen_core <= 0;
			next_ips_gen_core  <= 0;
			valid_ips_h   <= 0;
			end
			
			//assuming its giving ips in just next cycle of next_ips_gen
			if(TU_incre) begin
				next_ips_gen_core <= 1;
				valid_ips_h  <= 1;
				
					if(coring_counter<=198) begin
						coring_counter <= coring_counter + 1;
						once_coring_counter	<= 0;
					end else begin
						coring_counter <= 0;
						next_ips_gen_core <= 0;
						valid_ips_h  <= 0;
					end
			end
		
		end
	end

end


//as the spikes comes in next cycle of next_ips_gen, need to delay valid_ips by one
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	valid_ips <= 0;
	end else begin
		valid_ips 	<= valid_ips_h;
	end
end



window_freq win_freq(
	.clk(clk),
	.rst(rst),
	.val1(val1),.val2(val2),.val3(val3),.val4(val4),.val5(val5),
	.val6(val6),.val7(val7),.val8(val8),.val9(val9),.val10(val10),
	.val11(val11),.val12(val12),.val13(val13),.val14(val14),.val15(val15),
	.val16(val16),.val17(val17),.val18(val18),.val19(val19),.val20(val20),
	.val21(val21),.val22(val22),.val23(val23),.val24(val24),.val25(val25),
	.val_out(val_out)
);


`PACK_ARRAY(8,M,rf_freq_buffer,rf_freq_packed)

ips_generator ips_gen(  
	  .clk(clk),
     .rst(rst),
     .rf_freq_packed(rf_freq_packed),
     .start_ips_gen(start_ips_gen),
     .next_ips_gen(next_ips_gen),
	  .rf_buffering_done(rf_buffering_done),
     .ips_gen_out(ips_gen_out));


//Only to be used for testbench purposes
reg	start_main_h;

integer i1,file2;
always@(posedge clk)
begin
	if(tb.start_main) begin
		start_main_h	<= 1;
	end
	if(start_main_h) begin
		if(start_ips_gen) begin
		start_main_h	<= 0;
		end
	end
	if(valid_rfing) begin
				file2 = $fopen({`FEED,"image_ret.bin"},"w");
			for(i1=0;i1<M;i1=i1+1) begin
				$fwrite(file2,"%b\n",rf_freq_buffer[i1]);
			end
			$fclose(file2);
	end
end

assign start_ips_gen	= (maxing) ? start_ips_gen_maxer : start_ips_gen_core;
assign next_ips_gen	= (maxing) ? next_ips_gen_maxer : next_ips_gen_core;

maxer maxer(    
		.clk(clk),
      .rst(rst),
      .maxing(maxing),
		.ips_gen_out(ips_gen_out),
		.start_ips_gen(start_ips_gen_maxer),
		.next_ips_gen(next_ips_gen_maxer),
		.maxer_valid(valid_maxing),
		.threshold(threshold));





endmodule
