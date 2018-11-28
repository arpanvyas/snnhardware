module ram_weight(
    input clk,
    input [W-1:0] data_w,
    input [9:0] addr_r,
	 input [9:0] addr_w,
    output [W-1:0] data_r,
    input we,
	 input start_core_img
    );
parameter M = 784, N = 3, W=24, D = 1, TH = 128, REF = 30,
			 PRES = 10, PMIN = -10, OP_NUM = 1, WMAX = 16*4096,
			 WMIN = -16*4096;
			
		
reg[W-1:0] data_r;

//Put Weight Array Here
//make Weight Array here/ May change it to RAM just in case
reg signed[W-1:0]				weight[M-1:0];
reg[8*50:0]						stringvar;
integer i,file2;
initial
begin
	if(OP_NUM==0) begin 
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","0",".dat"},weight);
	end else if (OP_NUM==1) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","1",".dat"},weight);
	end else if (OP_NUM==2) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","2",".dat"},weight);
	end else if (OP_NUM==3) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","3",".dat"},weight);
	end else if (OP_NUM==4) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","4",".dat"},weight);
	end else if (OP_NUM==5) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","5",".dat"},weight);
	end else if (OP_NUM==6) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","6",".dat"},weight);
	end else if (OP_NUM==7) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","7",".dat"},weight);
	end else if (OP_NUM==8) begin
		$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","8",".dat"},weight);
	end else if (OP_NUM==9) begin
	$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","1",".dat"},weight);
	end else if (OP_NUM==10) begin
	$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","0",".dat"},weight);
	end else if (OP_NUM==11) begin
	$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","1",".dat"},weight);
	end else if (OP_NUM==12) begin
	$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","0",".dat"},weight);
	end else if (OP_NUM==13) begin
	$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","1",".dat"},weight);
	end else if (OP_NUM==14) begin
	$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","0",".dat"},weight);
	end else if (OP_NUM==15) begin
	$readmemb({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_weight","1",".dat"},weight);
	end
end


always@(posedge clk) 
begin
	//read through addr_r
	data_r <= weight[addr_r];
	if(we) begin
	weight[addr_w] <= data_w;
	end
end

always@(posedge clk)
begin
	if(tb.uut.done_core_img) begin
	if(OP_NUM==0) begin
		file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","0",".dat"},"w");
	end else if (OP_NUM==1) begin
		file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end else if (OP_NUM==2) begin
		file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","2",".dat"},"w");
	end else if (OP_NUM==3) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","3",".dat"},"w");
	end else if (OP_NUM==4) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","4",".dat"},"w");
	end else if (OP_NUM==5) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","5",".dat"},"w");
	end else if (OP_NUM==6) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","6",".dat"},"w");
	end else if (OP_NUM==7) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","7",".dat"},"w");
	end else if (OP_NUM==8) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","8",".dat"},"w");
	end else if (OP_NUM==9) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end else if (OP_NUM==10) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end else if (OP_NUM==11) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end else if (OP_NUM==12) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end else if (OP_NUM==13) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end else if (OP_NUM==14) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end else if (OP_NUM==15) begin
			file2 = $fopen({"/home/arpan/Desktop/BTP/SNN/SNN Summer 17 Work/Code till 4th May 2017/testbench_files/init_wt_wr","1",".dat"},"w");
	end
			
			for(i=0;i<M;i=i+1) begin
				$fwrite(file2,"%b\n",weight[i]);
			end
				$fwrite(file2,"%b\n",weight[i]);
				$fclose(file2);
	
	end
end







endmodule
