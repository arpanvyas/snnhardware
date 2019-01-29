`include "header.vh"

module count_muxer_h1(
    input 				clk,
    input 				rst,
    input  [8*`N2-1:0] count,
	 input  [`N3-1:0]	start_wch,
    output [9:0] 		ip_select,
    output [23:0] 		del_w_plus,
    output [23:0] 		del_w_minus
    );
parameter	M=784, N=16, W=24;

wire		start_wch_or;
assign	start_wch_or	= |start_wch;
reg[9:0]		ip_select;
wire[23:0]	del_w_plus;
wire[23:0]	del_w_minus;


//change ip_select here by start_wch and a timer
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	ip_select		<= 0;
	end else begin
		if(start_wch_or) begin
		ip_select	<= 1;
		end else if(ip_select==`N2-1) begin
		ip_select	<= 0;
		end else if(ip_select!=0) begin
		ip_select	<= ip_select + 1;
		end
	end	
end

wire[7:0]	count_unpacked[`N2-1:0];
`UNPACK_ARRAY(8,`N2,count_unpacked,count)			
reg[7:0]	count_select;

  //muxing to get count_select <-- ip_select
always@(posedge clk,posedge rst)
begin
	if(rst) begin
	count_select <= 0;
	end else begin
	count_select <= count_unpacked[ip_select];
	end
end

	//lookup table: del_w_plus/minus <-- count_select
lookup_plus_h1 plus_table(.clk(clk),.rst(rst),.lut_in(count_select),.lut_out(del_w_plus));
lookup_minus_h1 minus_table(.clk(clk),.rst(rst),.lut_in(count_select),.lut_out(del_w_minus));


endmodule
