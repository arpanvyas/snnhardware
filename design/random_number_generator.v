module random_number_generator(
    input clk,
    input rst,
	 input lfsr_shift,
	 input [7:0] rf_freq_buffer,
	 input [15:0] seed,
    output reg out
    );
	 

lfsr lfsr(
	.clk(clk),
	.rst(rst),
	.seed(seed),
	.lfsr_shift(lfsr_shift),
	.out(out_lfsr)
);

reg [3:0] prob;

function reg inbetween(input [10:0] low, value, high); 
	begin
		inbetween = value >= low && value <= high;
	end
endfunction

wire [15:0] out_lfsr;	


always@(*)
begin
	case(1)
		inbetween(24,rf_freq_buffer,48): prob = 5;
		inbetween(49,rf_freq_buffer,96): prob = 6;
		inbetween(97,rf_freq_buffer,192): prob = 7;
		inbetween(193,rf_freq_buffer,255): prob = 8;
		default: prob = 0;
	endcase
end

always@(*)
begin
	case(prob)
		1: out <= out_lfsr[0];
		2: out <= out_lfsr[0]&&out_lfsr[2];
		3: out <= out_lfsr[0]&&out_lfsr[2]&&out_lfsr[4];
		4: out <= out_lfsr[0]&&out_lfsr[2]&&out_lfsr[4]&&out_lfsr[6];
		5: out <= out_lfsr[0]&&out_lfsr[2]&&out_lfsr[4]&&out_lfsr[6]&&out_lfsr[8];
		6: out <= out_lfsr[0]&&out_lfsr[2]&&out_lfsr[4]&&out_lfsr[6]&&out_lfsr[8]&&out_lfsr[10];
		7: out <= out_lfsr[0]&&out_lfsr[2]&&out_lfsr[4]&&out_lfsr[6]&&out_lfsr[8]&&out_lfsr[10]&&out_lfsr[12];
		8: out <= out_lfsr[0]&&out_lfsr[2]&&out_lfsr[4]&&out_lfsr[6]&&out_lfsr[8]&&out_lfsr[10]&&out_lfsr[12]&&out_lfsr[14];
		default: out <= 0;	
	endcase

end

endmodule
