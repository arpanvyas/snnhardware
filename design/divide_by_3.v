module div_by_3(
    input clk,
	 input div_enable,
    input  [W-1:0]ip,
    output [W-1:0] op
    );

parameter W=24;

reg[W-1:0]	  op;
reg[W-1:0]    op1,op2,op3,op4,op5;
always@(posedge clk)
begin
	if(div_enable) begin
		op1 = ip/4;
		op2 = ip/16;
		op3 = ip/64;
		op4 = ip/256;
		op5 = ip/512;
		op  = op1+op2+op3+op4+op5;
	end else begin
		op = 0;
	end
end

endmodule
