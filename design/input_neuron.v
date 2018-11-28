module input_neuron(
    input spike_in,
    input clk,rst,
    input start,
	 input start_core_img,
    output spike_out,
    output [7:0] count,
    output done
    );
parameter	W=24;


reg spike_value;
reg [7:0] counter;
reg start1;
reg done1;

always @(posedge clk, posedge rst)
begin
	if(rst==1)
		begin
			spike_value <= 0;
			counter 		<= 21;
			start1 		<= 0;
			done1 		<= 0;
		end
	else begin
		done1 <= 0;
		if(start==1)
			begin
				spike_value <= spike_in;
				if(spike_value==1)
					counter <= 0;
				else
				begin
					if(counter<21)
						counter <= counter + 1;
				end
				done1 <= 1;	
			end
		
		if(start_core_img) begin
				counter	<= 21;
			end

	end
end

assign count = counter;
assign spike_out = spike_value;
assign done = done1;	

endmodule