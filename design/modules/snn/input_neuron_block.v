`include "header.vh"

module ip_nu_blk(
	 input 					clk,rst,
	 input[`M-1:0] 			spike_in,
    input 					start_ip_nub,
	 input					start_core_img,
    output[`M-1:0] 		spike_ip_nub,
    output[8*`M-1:0]  	count,
	 output 					valid_ip_nub
    );
parameter M = 784, W = 24;

wire[M-1:0]	done1;
wire[7:0]	count_unpacked[M-1:0];
`PACK_ARRAY(8,M,count_unpacked,count)

genvar i;
generate for(i=0 ; i<M ; i=i+1)
begin
    input_neuron #(.W(W)) ip_neu(
    .clk(clk),
	 .rst(rst),
	 .spike_in(spike_in[i]),
    .start(start_ip_nub),
    .spike_out(spike_ip_nub[i]),
	 .start_core_img(start_core_img),
    .count(count_unpacked[i]),
    .done(done1[i])
		);
end
endgenerate

assign valid_ip_nub = done1[0];



endmodule
