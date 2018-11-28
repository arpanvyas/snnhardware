module ip_ram(
address, // Address input
clk,
data_out,		// Data output
qin,		// Data input
we			//write enable
);

input  [15:0] address;
output [255:0] data_out; 
input  [255:0] qin;
input  clk;
input  we;
           
reg [255:0] mem[0:1001];  
reg [255:0] data_out;

  
always @ (posedge clk)
begin
  if (we) begin 
   mem[address] = qin;
  end else begin
  data_out = mem[address];
  end
end

initial
begin
  $readmemb("./testbench_files/input_spike_ram.txt",mem);
end

endmodule
