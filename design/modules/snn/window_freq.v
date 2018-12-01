module window_freq(
    input clk,
    input rst,
    input [7:0] val1,
    input [7:0] val2,
    input [7:0] val3,
    input [7:0] val4,
    input [7:0] val5,
    input [7:0] val6,
    input [7:0] val7,
    input [7:0] val8,
    input [7:0] val9,
    input [7:0] val10,
    input [7:0] val11,
    input [7:0] val12,
    input [7:0] val13,
    input [7:0] val14,
    input [7:0] val15,
	 input [7:0] val16,
    input [7:0] val17,
    input [7:0] val18,
    input [7:0] val19,
    input [7:0] val20,
    input [7:0] val21,
    input [7:0] val22,
    input [7:0] val23,
    input [7:0] val24,
    input [7:0] val25,
    output [7:0] val_out
    );
	 
	reg[3:0] count;

reg signed[9:0] sca0;//1
reg signed[9:0] sca1;//.625
reg signed[9:0] sca2;//.125
reg signed[9:0] sca3;//-.125
reg signed[9:0] sca4;//-.5
reg signed[10:0] val_out1;
reg signed[10:0] val_out2;
reg signed[10:0] val_out3;
wire [7:0]	val_out;


always@(posedge clk, posedge rst)
begin
	 if(rst) begin
		sca0 <= 0;
		sca1 <= 0;
		sca2 <= 0;
		sca3 <= 0;
		sca4 <= 0;
	 end else begin
		sca0	<= val13;
		sca1	<= (val8>>1) + (val8>>3) + (val12>>1) + (val12>>3) + (val14>>1) + (val14>>3) + (val18>>1) + (val18>>3);
		sca2	<= (val3>>3) + (val7>>3) + (val9>>3) + (val11>>3) + (val15>>3) + (val17>>3) + (val19>>3) + (val23>>3);
		sca3	<= 0 - (val2>>3) - (val4>>3) - (val6>>3) - (val10>>3) - (val16>>3) - (val20>>3) - (val22>>3) - (val24>>3);
		sca4	<= 0 - (val1>>1) - (val5>>1) - (val21>>1) - (val25>>1);
		val_out1 <= (sca0+sca1+sca2+sca3+sca4)>>>2;
		val_out2 <= (val_out1<<<2) + val_out1;
		val_out3 <= val_out2 + 384;
		//val_out	<= (64*600)/val_out3; done by instantiated module		
	 
	 end
end


divide_replace divide_replace(.clk(clk),
										.rst(rst),
										.val_out3(val_out3),
										.val_out4(val_out));

endmodule
