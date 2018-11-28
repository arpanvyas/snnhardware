`define PACK_ARRAY(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST)    genvar pk_idx; generate for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) begin; assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; end; endgenerate
`define UNPACK_ARRAY(PK_WIDTH,PK_LEN,PK_DEST,PK_SRC)  genvar unpk_idx; generate for (unpk_idx=0; unpk_idx<(PK_LEN); unpk_idx=unpk_idx+1) begin; assign PK_DEST[unpk_idx][((PK_WIDTH)-1):0] = PK_SRC[((PK_WIDTH)*unpk_idx+(PK_WIDTH-1)):((PK_WIDTH)*unpk_idx)]; end; endgenerate


module count_muxer(
    input 				clk,
    input 				rst,
    input  [8*M-1:0] count,
	 input  [N-1:0]	start_wch,
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
		end else if(ip_select==M-1) begin
		ip_select	<= 0;
		end else if(ip_select!=0) begin
		ip_select	<= ip_select + 1;
		end
	end	
end

wire[7:0]	count_unpacked[M-1:0];
`UNPACK_ARRAY(8,M,count_unpacked,count)			
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
lookup_plus plus_table(.clk(clk),.rst(rst),.lut_in(count_select),.lut_out(del_w_plus));
lookup_minus minus_table(.clk(clk),.rst(rst),.lut_in(count_select),.lut_out(del_w_minus));


endmodule
