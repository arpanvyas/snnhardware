`include "header.vh"

module lfsr(
    input clk,
    input rst,
	 input lfsr_shift,
    input [15:0] seed,
    output [15:0] out
    );

reg [15:0] register;
wire in;

integer i;
always@(posedge clk, posedge rst)
begin
	if(rst) begin
	register <= seed;
	end else begin
		if(lfsr_shift) begin
			register <= register>>1;
			register[15] <= in;
		end else begin
			register <= register;
		end
	
	end
end


wire [15:0] poly;
assign poly = 16'b0000_1000_0000_1011;
assign out = register;
assign in = ^(register & poly);
endmodule
