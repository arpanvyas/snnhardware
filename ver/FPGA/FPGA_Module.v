module FPGA_Module(
    input clk,
    input rst,
	 input switch_working,
	 output led_opnu1,
	 output led_opnu2,
	 output led_hold,
	 output led_done
    );
	 
parameter M=256, N=8, W=8, D = 1,
			 REF = 30, TH = 5, PRES = 0, PMIN = -1;	 


	 

// Inputs to Top_Module
	wire clk;
	wire rst;
	reg valid_board;
	reg [M-1:0]ips;
	reg nxt_img;


// Outputs from Top Module
	wire [N-1:0]ops;
	wire TU_incre;
	wire done;	 

//Outputs to the FPGA
reg	led_opnu1;
reg	led_opnu2;
reg	led_opnu3;
reg	led_opnu4;
reg	led_hold;
reg	led_done;	 

	 
// Instantiate the Working Module (UUT)
core #(.M(M),.N(N),.W(W),.D(D),
					 .TH(TH),.PRES(PRES),.PMIN(PMIN)) uut (
		.clk(clk), 
		.rst(rst), 
		.valid_board(valid_board),
		.nxt_img(nxt_img),
		.ips(ips),
		
		.ops(ops), 
		.TU_incre(TU_incre),
		.done(done)
	); 

reg[15:0]  count_ram;
reg[7:0]   count_op1;
reg[7:0]   count_op2;
reg[7:0]   count_op3;
reg[7:0]   count_op4;
reg[23:0]  count_hold;
wire[255:0] data_out_ram;
wire[255:0] qin;
wire		  we;
assign	  we	= 1'b0;

ip_ram ip_ram(
		.address(count_ram), // Address input
		.clk(clk),
		.data_out(data_out_ram),			// Data output
		.qin(qin),		// Data input
		.we(we)	);
	




always@(posedge clk,posedge rst)
begin
	if(rst) begin
	valid_board	<= 0;
	nxt_img		<= 0;
	ips			<= 0;
	count_ram	<= 0; count_hold <= 0;
	count_op1 	<= 0;	count_op2  <= 0;
	count_op3   <= 0; count_op4  <= 0;
	led_done		<= 0;	led_hold	  <= 0;
	
	end else begin
		valid_board	<= 0;
		nxt_img		<= 0;
		led_hold		<= 0;
		
		if(switch_working) begin
			if (count_ram == 0) begin
			count_ram   <= count_ram+1;
			ips			<= data_out_ram;
			valid_board <= 1;
			
			end else if(count_ram < 501 & TU_incre==1) begin
			count_ram   <= count_ram+1;
			ips			<= data_out_ram;
			valid_board <= 1;
			
			end else if(count_ram == 501 & count_hold<50000) begin
			count_hold	<= count_hold+1;
			count_ram 	<= 501;
			led_hold		<= 1;

			end else if(count_ram == 501 & count_hold==50000) begin
			nxt_img     <= 1;
			count_ram   <= count_ram+1;
			ips			<= data_out_ram;
			valid_board <= 1;
			
			end else if(count_ram>501 & count_ram<1002 & TU_incre==1) begin
			count_ram  <= count_ram+1;
			ips			<= data_out_ram;
			valid_board <= 1;
			
			end else if(count_ram==1002) begin
			led_done <= 1'b1;
			end
		
		end else begin
			valid_board	<= 0;
			nxt_img		<= 0;
			ips			<= 0;
		end
	end
end


//Led Manager
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	 led_opnu1	<= 0;
	 led_opnu2	<= 0;
	 led_opnu3 	<= 0;
	 led_opnu4	<= 0;
	end else begin
			led_opnu1 <= 0;
			led_opnu2 <= 0;
			led_opnu3 <= 0;
			led_opnu4 <= 0;
		
			if(TU_incre) begin
				if(ops[0]==1) begin
				count_op1	<= count_op1 + 1;
				end
				if(ops[1]==1) begin
				count_op2	<= count_op2 + 1;
				end
				if(ops[2]==1) begin
				count_op3	<= count_op3 + 1;
				end
				if(ops[3]==1) begin
				count_op4	<= count_op4 + 1;
				end
			end
		
			if(led_hold) begin
				if(count_op1>count_op2) begin
				led_opnu1	<= 1;
				end else begin
				led_opnu2	<= 1;
				end
			end
			
			if(count_hold==49999) begin
			count_op1	<= 0;
			count_op2	<= 0;
			end
	
			if(count_hold==50000) begin
				if(count_op1>count_op2) begin
				led_opnu1	<= 1;
				end else begin
				led_opnu2	<= 1;
				end
			end
	
		end
end



endmodule
