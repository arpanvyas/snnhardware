`include "header.vh"

module ram_weight(
    input clk,
    input [`W-1:0] data_w,
    input [9:0] addr_r,
	 input [9:0] addr_w,
    output [`W-1:0] data_r,
    input we,
	 input start_core_img
    );
parameter M = 784, N = 3, W=24, D = 1, TH = 128, REF = 30,
			 PRES = 10, PMIN = -10, OP_NUM = 1, WMAX = 16*4096,
			 WMIN = -16*4096;
			
		
reg[`W-1:0] data_r;

//Put Weight Array Here
//make Weight Array here/ May change it to RAM just in case
reg signed[`W-1:0]				weight[`N1-1:0];
reg[8*50:0]						stringvar;
integer i,file2;
initial
begin
	if(OP_NUM==0) begin 
		$readmemb({`FEED,"init_weight","0",".dat"},weight);
	end else if (OP_NUM==1) begin
		$readmemb({`FEED,"init_weight","1",".dat"},weight);
	end else if (OP_NUM==2) begin
		$readmemb({`FEED,"init_weight","2",".dat"},weight);
	end else if (OP_NUM==3) begin
		$readmemb({`FEED,"init_weight","3",".dat"},weight);
	end else if (OP_NUM==4) begin
		$readmemb({`FEED,"init_weight","4",".dat"},weight);
	end else if (OP_NUM==5) begin
		$readmemb({`FEED,"init_weight","5",".dat"},weight);
	end else if (OP_NUM==6) begin
		$readmemb({`FEED,"init_weight","6",".dat"},weight);
	end else if (OP_NUM==7) begin
		$readmemb({`FEED,"init_weight","7",".dat"},weight);
	end else if (OP_NUM==8) begin
		$readmemb({`FEED,"init_weight","8",".dat"},weight);
    end else if (OP_NUM==9) begin
            $readmemb({`FEED,"init_weight","9",".dat"},weight);
    end else if (OP_NUM==10) begin
            $readmemb({`FEED,"init_weight","10",".dat"},weight);
    end else if (OP_NUM==11) begin
            $readmemb({`FEED,"init_weight","11",".dat"},weight);
    end else if (OP_NUM==12) begin
            $readmemb({`FEED,"init_weight","12",".dat"},weight);
    end else if (OP_NUM==13) begin
            $readmemb({`FEED,"init_weight","13",".dat"},weight);
    end else if (OP_NUM==14) begin
            $readmemb({`FEED,"init_weight","14",".dat"},weight);
    end else if (OP_NUM==15) begin
            $readmemb({`FEED,"init_weight","15",".dat"},weight);
    end else if (OP_NUM==16) begin
            $readmemb({`FEED,"init_weight","16",".dat"},weight);
    end else if (OP_NUM==17) begin
            $readmemb({`FEED,"init_weight","17",".dat"},weight);
    end else if (OP_NUM==18) begin
            $readmemb({`FEED,"init_weight","18",".dat"},weight);
    end else if (OP_NUM==19) begin
            $readmemb({`FEED,"init_weight","19",".dat"},weight);
    end else if (OP_NUM==20) begin
            $readmemb({`FEED,"init_weight","20",".dat"},weight);
    end else if (OP_NUM==21) begin
            $readmemb({`FEED,"init_weight","21",".dat"},weight);
    end else if (OP_NUM==22) begin
            $readmemb({`FEED,"init_weight","22",".dat"},weight);
    end else if (OP_NUM==23) begin
            $readmemb({`FEED,"init_weight","23",".dat"},weight);
    end else if (OP_NUM==24) begin
            $readmemb({`FEED,"init_weight","24",".dat"},weight);
    end else if (OP_NUM==25) begin
            $readmemb({`FEED,"init_weight","25",".dat"},weight);
    end else if (OP_NUM==26) begin
            $readmemb({`FEED,"init_weight","26",".dat"},weight);
    end else if (OP_NUM==27) begin
            $readmemb({`FEED,"init_weight","27",".dat"},weight);
    end else if (OP_NUM==28) begin
            $readmemb({`FEED,"init_weight","28",".dat"},weight);
    end else if (OP_NUM==29) begin
            $readmemb({`FEED,"init_weight","29",".dat"},weight);
    end else if (OP_NUM==30) begin
            $readmemb({`FEED,"init_weight","30",".dat"},weight);
    end else if (OP_NUM==31) begin
            $readmemb({`FEED,"init_weight","31",".dat"},weight);
    end else if (OP_NUM==32) begin
            $readmemb({`FEED,"init_weight","32",".dat"},weight);
    end else if (OP_NUM==33) begin
            $readmemb({`FEED,"init_weight","33",".dat"},weight);
    end else if (OP_NUM==34) begin
            $readmemb({`FEED,"init_weight","34",".dat"},weight);
    end else if (OP_NUM==35) begin
            $readmemb({`FEED,"init_weight","35",".dat"},weight);
    end else if (OP_NUM==36) begin
            $readmemb({`FEED,"init_weight","36",".dat"},weight);
    end else if (OP_NUM==37) begin
            $readmemb({`FEED,"init_weight","37",".dat"},weight);
    end else if (OP_NUM==38) begin
            $readmemb({`FEED,"init_weight","38",".dat"},weight);
    end else if (OP_NUM==39) begin
            $readmemb({`FEED,"init_weight","39",".dat"},weight);
    end else if (OP_NUM==40) begin
            $readmemb({`FEED,"init_weight","40",".dat"},weight);
    end else if (OP_NUM==41) begin
            $readmemb({`FEED,"init_weight","41",".dat"},weight);
    end else if (OP_NUM==42) begin
            $readmemb({`FEED,"init_weight","42",".dat"},weight);
    end else if (OP_NUM==43) begin
            $readmemb({`FEED,"init_weight","43",".dat"},weight);
    end else if (OP_NUM==44) begin
            $readmemb({`FEED,"init_weight","44",".dat"},weight);
    end else if (OP_NUM==45) begin
            $readmemb({`FEED,"init_weight","45",".dat"},weight);
    end else if (OP_NUM==46) begin
            $readmemb({`FEED,"init_weight","46",".dat"},weight);
    end else if (OP_NUM==47) begin
            $readmemb({`FEED,"init_weight","47",".dat"},weight);
    end else if (OP_NUM==48) begin
            $readmemb({`FEED,"init_weight","48",".dat"},weight);
    end else if (OP_NUM==49) begin
            $readmemb({`FEED,"init_weight","49",".dat"},weight);
    end else if (OP_NUM==50) begin
            $readmemb({`FEED,"init_weight","50",".dat"},weight);
    end else if (OP_NUM==51) begin
            $readmemb({`FEED,"init_weight","51",".dat"},weight);
    end else if (OP_NUM==52) begin
            $readmemb({`FEED,"init_weight","52",".dat"},weight);
    end else if (OP_NUM==53) begin
            $readmemb({`FEED,"init_weight","53",".dat"},weight);
    end else if (OP_NUM==54) begin
            $readmemb({`FEED,"init_weight","54",".dat"},weight);
    end else if (OP_NUM==55) begin
            $readmemb({`FEED,"init_weight","55",".dat"},weight);
    end else if (OP_NUM==56) begin
            $readmemb({`FEED,"init_weight","56",".dat"},weight);
    end else if (OP_NUM==57) begin
            $readmemb({`FEED,"init_weight","57",".dat"},weight);
    end else if (OP_NUM==58) begin
            $readmemb({`FEED,"init_weight","58",".dat"},weight);
    end else if (OP_NUM==59) begin
            $readmemb({`FEED,"init_weight","59",".dat"},weight);
    end else if (OP_NUM==60) begin
            $readmemb({`FEED,"init_weight","60",".dat"},weight);
    end else if (OP_NUM==61) begin
            $readmemb({`FEED,"init_weight","61",".dat"},weight);
    end else if (OP_NUM==62) begin
            $readmemb({`FEED,"init_weight","62",".dat"},weight);
    end else if (OP_NUM==63) begin
            $readmemb({`FEED,"init_weight","63",".dat"},weight);
    end else if (OP_NUM==64) begin
            $readmemb({`FEED,"init_weight","64",".dat"},weight);
    end else if (OP_NUM==65) begin
            $readmemb({`FEED,"init_weight","65",".dat"},weight);
    end else if (OP_NUM==66) begin
            $readmemb({`FEED,"init_weight","66",".dat"},weight);
    end else if (OP_NUM==67) begin
            $readmemb({`FEED,"init_weight","67",".dat"},weight);
    end else if (OP_NUM==68) begin
            $readmemb({`FEED,"init_weight","68",".dat"},weight);
    end else if (OP_NUM==69) begin
            $readmemb({`FEED,"init_weight","69",".dat"},weight);
    end else if (OP_NUM==70) begin
            $readmemb({`FEED,"init_weight","70",".dat"},weight);
    end else if (OP_NUM==71) begin
            $readmemb({`FEED,"init_weight","71",".dat"},weight);
    end else if (OP_NUM==72) begin
            $readmemb({`FEED,"init_weight","72",".dat"},weight);
    end else if (OP_NUM==73) begin
            $readmemb({`FEED,"init_weight","73",".dat"},weight);
    end else if (OP_NUM==74) begin
            $readmemb({`FEED,"init_weight","74",".dat"},weight);
    end else if (OP_NUM==75) begin
            $readmemb({`FEED,"init_weight","75",".dat"},weight);
    end else if (OP_NUM==76) begin
            $readmemb({`FEED,"init_weight","76",".dat"},weight);
    end else if (OP_NUM==77) begin
            $readmemb({`FEED,"init_weight","77",".dat"},weight);
    end else if (OP_NUM==78) begin
            $readmemb({`FEED,"init_weight","78",".dat"},weight);
    end else if (OP_NUM==79) begin
            $readmemb({`FEED,"init_weight","79",".dat"},weight);
    end else if (OP_NUM==80) begin
            $readmemb({`FEED,"init_weight","80",".dat"},weight);
    end else if (OP_NUM==81) begin
            $readmemb({`FEED,"init_weight","81",".dat"},weight);
    end else if (OP_NUM==82) begin
            $readmemb({`FEED,"init_weight","82",".dat"},weight);
    end else if (OP_NUM==83) begin
            $readmemb({`FEED,"init_weight","83",".dat"},weight);
    end else if (OP_NUM==84) begin
            $readmemb({`FEED,"init_weight","84",".dat"},weight);
    end else if (OP_NUM==85) begin
            $readmemb({`FEED,"init_weight","85",".dat"},weight);
    end else if (OP_NUM==86) begin
            $readmemb({`FEED,"init_weight","86",".dat"},weight);
    end else if (OP_NUM==87) begin
            $readmemb({`FEED,"init_weight","87",".dat"},weight);
    end else if (OP_NUM==88) begin
            $readmemb({`FEED,"init_weight","88",".dat"},weight);
    end else if (OP_NUM==89) begin
            $readmemb({`FEED,"init_weight","89",".dat"},weight);
    end else if (OP_NUM==90) begin
            $readmemb({`FEED,"init_weight","90",".dat"},weight);
    end else if (OP_NUM==91) begin
            $readmemb({`FEED,"init_weight","91",".dat"},weight);
    end else if (OP_NUM==92) begin
            $readmemb({`FEED,"init_weight","92",".dat"},weight);
    end else if (OP_NUM==93) begin
            $readmemb({`FEED,"init_weight","93",".dat"},weight);
    end else if (OP_NUM==94) begin
            $readmemb({`FEED,"init_weight","94",".dat"},weight);
    end else if (OP_NUM==95) begin
            $readmemb({`FEED,"init_weight","95",".dat"},weight);
    end else if (OP_NUM==96) begin
            $readmemb({`FEED,"init_weight","96",".dat"},weight);
    end else if (OP_NUM==97) begin
            $readmemb({`FEED,"init_weight","97",".dat"},weight);
    end else if (OP_NUM==98) begin
            $readmemb({`FEED,"init_weight","98",".dat"},weight);
    end else if (OP_NUM==99) begin
            $readmemb({`FEED,"init_weight","99",".dat"},weight);
    end else if (OP_NUM==100) begin
            $readmemb({`FEED,"init_weight","100",".dat"},weight);
    end else if (OP_NUM==101) begin
            $readmemb({`FEED,"init_weight","101",".dat"},weight);
    end else if (OP_NUM==102) begin
            $readmemb({`FEED,"init_weight","102",".dat"},weight);
    end else if (OP_NUM==103) begin
            $readmemb({`FEED,"init_weight","103",".dat"},weight);
    end else if (OP_NUM==104) begin
            $readmemb({`FEED,"init_weight","104",".dat"},weight);
    end else if (OP_NUM==105) begin
            $readmemb({`FEED,"init_weight","105",".dat"},weight);
    end else if (OP_NUM==106) begin
            $readmemb({`FEED,"init_weight","106",".dat"},weight);
    end else if (OP_NUM==107) begin
            $readmemb({`FEED,"init_weight","107",".dat"},weight);
    end else if (OP_NUM==108) begin
            $readmemb({`FEED,"init_weight","108",".dat"},weight);
    end else if (OP_NUM==109) begin
            $readmemb({`FEED,"init_weight","109",".dat"},weight);
    end else if (OP_NUM==110) begin
            $readmemb({`FEED,"init_weight","110",".dat"},weight);
    end else if (OP_NUM==111) begin
            $readmemb({`FEED,"init_weight","111",".dat"},weight);
    end else if (OP_NUM==112) begin
            $readmemb({`FEED,"init_weight","112",".dat"},weight);
    end else if (OP_NUM==113) begin
            $readmemb({`FEED,"init_weight","113",".dat"},weight);
    end else if (OP_NUM==114) begin
            $readmemb({`FEED,"init_weight","114",".dat"},weight);
    end else if (OP_NUM==115) begin
            $readmemb({`FEED,"init_weight","115",".dat"},weight);
    end else if (OP_NUM==116) begin
            $readmemb({`FEED,"init_weight","116",".dat"},weight);
    end else if (OP_NUM==117) begin
            $readmemb({`FEED,"init_weight","117",".dat"},weight);
    end else if (OP_NUM==118) begin
            $readmemb({`FEED,"init_weight","118",".dat"},weight);
    end else if (OP_NUM==119) begin
            $readmemb({`FEED,"init_weight","119",".dat"},weight);
    end else if (OP_NUM==120) begin
            $readmemb({`FEED,"init_weight","120",".dat"},weight);
    end else if (OP_NUM==121) begin
            $readmemb({`FEED,"init_weight","121",".dat"},weight);
    end else if (OP_NUM==122) begin
            $readmemb({`FEED,"init_weight","122",".dat"},weight);
    end else if (OP_NUM==123) begin
            $readmemb({`FEED,"init_weight","123",".dat"},weight);
    end else if (OP_NUM==124) begin
            $readmemb({`FEED,"init_weight","124",".dat"},weight);
    end else if (OP_NUM==125) begin
            $readmemb({`FEED,"init_weight","125",".dat"},weight);
    end else if (OP_NUM==126) begin
            $readmemb({`FEED,"init_weight","126",".dat"},weight);
    end else if (OP_NUM==127) begin
            $readmemb({`FEED,"init_weight","127",".dat"},weight);
    end else begin
        $readmemb({`FEED,"init_weight", "0",".dat"},weight);
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
    		file2 = $fopen({`FEED,"init_wt_wr","0",".dat"},"w");
    	end else if (OP_NUM==1) begin
    		file2 = $fopen({`FEED,"init_wt_wr","1",".dat"},"w");
    	end else if (OP_NUM==2) begin
    		file2 = $fopen({`FEED,"init_wt_wr","2",".dat"},"w");
    	end else if (OP_NUM==3) begin
    			file2 = $fopen({`FEED,"init_wt_wr","3",".dat"},"w");
    	end else if (OP_NUM==4) begin
    			file2 = $fopen({`FEED,"init_wt_wr","4",".dat"},"w");
    	end else if (OP_NUM==5) begin
    			file2 = $fopen({`FEED,"init_wt_wr","5",".dat"},"w");
    	end else if (OP_NUM==6) begin
    			file2 = $fopen({`FEED,"init_wt_wr","6",".dat"},"w");
    	end else if (OP_NUM==7) begin
    			file2 = $fopen({`FEED,"init_wt_wr","7",".dat"},"w");
    	end else if (OP_NUM==8) begin
    			file2 = $fopen({`FEED,"init_wt_wr","8",".dat"},"w");
        end else if (OP_NUM==9) begin
                file2 = $fopen({`FEED,"init_wt_wr","9",".dat"},"w");
        end else if (OP_NUM==10) begin
                file2 = $fopen({`FEED,"init_wt_wr","10",".dat"},"w");
        end else if (OP_NUM==11) begin
                file2 = $fopen({`FEED,"init_wt_wr","11",".dat"},"w");
        end else if (OP_NUM==12) begin
                file2 = $fopen({`FEED,"init_wt_wr","12",".dat"},"w");
        end else if (OP_NUM==13) begin
                file2 = $fopen({`FEED,"init_wt_wr","13",".dat"},"w");
        end else if (OP_NUM==14) begin
                file2 = $fopen({`FEED,"init_wt_wr","14",".dat"},"w");
        end else if (OP_NUM==15) begin
                file2 = $fopen({`FEED,"init_wt_wr","15",".dat"},"w");
        end else if (OP_NUM==16) begin
                file2 = $fopen({`FEED,"init_wt_wr","16",".dat"},"w");
        end else if (OP_NUM==17) begin
                file2 = $fopen({`FEED,"init_wt_wr","17",".dat"},"w");
        end else if (OP_NUM==18) begin
                file2 = $fopen({`FEED,"init_wt_wr","18",".dat"},"w");
        end else if (OP_NUM==19) begin
                file2 = $fopen({`FEED,"init_wt_wr","19",".dat"},"w");
        end else if (OP_NUM==20) begin
                file2 = $fopen({`FEED,"init_wt_wr","20",".dat"},"w");
        end else if (OP_NUM==21) begin
                file2 = $fopen({`FEED,"init_wt_wr","21",".dat"},"w");
        end else if (OP_NUM==22) begin
                file2 = $fopen({`FEED,"init_wt_wr","22",".dat"},"w");
        end else if (OP_NUM==23) begin
                file2 = $fopen({`FEED,"init_wt_wr","23",".dat"},"w");
        end else if (OP_NUM==24) begin
                file2 = $fopen({`FEED,"init_wt_wr","24",".dat"},"w");
        end else if (OP_NUM==25) begin
                file2 = $fopen({`FEED,"init_wt_wr","25",".dat"},"w");
        end else if (OP_NUM==26) begin
                file2 = $fopen({`FEED,"init_wt_wr","26",".dat"},"w");
        end else if (OP_NUM==27) begin
                file2 = $fopen({`FEED,"init_wt_wr","27",".dat"},"w");
        end else if (OP_NUM==28) begin
                file2 = $fopen({`FEED,"init_wt_wr","28",".dat"},"w");
        end else if (OP_NUM==29) begin
                file2 = $fopen({`FEED,"init_wt_wr","29",".dat"},"w");
        end else if (OP_NUM==30) begin
                file2 = $fopen({`FEED,"init_wt_wr","30",".dat"},"w");
        end else if (OP_NUM==31) begin
                file2 = $fopen({`FEED,"init_wt_wr","31",".dat"},"w");
        end else if (OP_NUM==32) begin
                file2 = $fopen({`FEED,"init_wt_wr","32",".dat"},"w");
        end else if (OP_NUM==33) begin
                file2 = $fopen({`FEED,"init_wt_wr","33",".dat"},"w");
        end else if (OP_NUM==34) begin
                file2 = $fopen({`FEED,"init_wt_wr","34",".dat"},"w");
        end else if (OP_NUM==35) begin
                file2 = $fopen({`FEED,"init_wt_wr","35",".dat"},"w");
        end else if (OP_NUM==36) begin
                file2 = $fopen({`FEED,"init_wt_wr","36",".dat"},"w");
        end else if (OP_NUM==37) begin
                file2 = $fopen({`FEED,"init_wt_wr","37",".dat"},"w");
        end else if (OP_NUM==38) begin
                file2 = $fopen({`FEED,"init_wt_wr","38",".dat"},"w");
        end else if (OP_NUM==39) begin
                file2 = $fopen({`FEED,"init_wt_wr","39",".dat"},"w");
        end else if (OP_NUM==40) begin
                file2 = $fopen({`FEED,"init_wt_wr","40",".dat"},"w");
        end else if (OP_NUM==41) begin
                file2 = $fopen({`FEED,"init_wt_wr","41",".dat"},"w");
        end else if (OP_NUM==42) begin
                file2 = $fopen({`FEED,"init_wt_wr","42",".dat"},"w");
        end else if (OP_NUM==43) begin
                file2 = $fopen({`FEED,"init_wt_wr","43",".dat"},"w");
        end else if (OP_NUM==44) begin
                file2 = $fopen({`FEED,"init_wt_wr","44",".dat"},"w");
        end else if (OP_NUM==45) begin
                file2 = $fopen({`FEED,"init_wt_wr","45",".dat"},"w");
        end else if (OP_NUM==46) begin
                file2 = $fopen({`FEED,"init_wt_wr","46",".dat"},"w");
        end else if (OP_NUM==47) begin
                file2 = $fopen({`FEED,"init_wt_wr","47",".dat"},"w");
        end else if (OP_NUM==48) begin
                file2 = $fopen({`FEED,"init_wt_wr","48",".dat"},"w");
        end else if (OP_NUM==49) begin
                file2 = $fopen({`FEED,"init_wt_wr","49",".dat"},"w");
        end else if (OP_NUM==50) begin
                file2 = $fopen({`FEED,"init_wt_wr","50",".dat"},"w");
        end else if (OP_NUM==51) begin
                file2 = $fopen({`FEED,"init_wt_wr","51",".dat"},"w");
        end else if (OP_NUM==52) begin
                file2 = $fopen({`FEED,"init_wt_wr","52",".dat"},"w");
        end else if (OP_NUM==53) begin
                file2 = $fopen({`FEED,"init_wt_wr","53",".dat"},"w");
        end else if (OP_NUM==54) begin
                file2 = $fopen({`FEED,"init_wt_wr","54",".dat"},"w");
        end else if (OP_NUM==55) begin
                file2 = $fopen({`FEED,"init_wt_wr","55",".dat"},"w");
        end else if (OP_NUM==56) begin
                file2 = $fopen({`FEED,"init_wt_wr","56",".dat"},"w");
        end else if (OP_NUM==57) begin
                file2 = $fopen({`FEED,"init_wt_wr","57",".dat"},"w");
        end else if (OP_NUM==58) begin
                file2 = $fopen({`FEED,"init_wt_wr","58",".dat"},"w");
        end else if (OP_NUM==59) begin
                file2 = $fopen({`FEED,"init_wt_wr","59",".dat"},"w");
        end else if (OP_NUM==60) begin
                file2 = $fopen({`FEED,"init_wt_wr","60",".dat"},"w");
        end else if (OP_NUM==61) begin
                file2 = $fopen({`FEED,"init_wt_wr","61",".dat"},"w");
        end else if (OP_NUM==62) begin
                file2 = $fopen({`FEED,"init_wt_wr","62",".dat"},"w");
        end else if (OP_NUM==63) begin
                file2 = $fopen({`FEED,"init_wt_wr","63",".dat"},"w");
        end else if (OP_NUM==64) begin
                file2 = $fopen({`FEED,"init_wt_wr","64",".dat"},"w");
        end else if (OP_NUM==65) begin
                file2 = $fopen({`FEED,"init_wt_wr","65",".dat"},"w");
        end else if (OP_NUM==66) begin
                file2 = $fopen({`FEED,"init_wt_wr","66",".dat"},"w");
        end else if (OP_NUM==67) begin
                file2 = $fopen({`FEED,"init_wt_wr","67",".dat"},"w");
        end else if (OP_NUM==68) begin
                file2 = $fopen({`FEED,"init_wt_wr","68",".dat"},"w");
        end else if (OP_NUM==69) begin
                file2 = $fopen({`FEED,"init_wt_wr","69",".dat"},"w");
        end else if (OP_NUM==70) begin
                file2 = $fopen({`FEED,"init_wt_wr","70",".dat"},"w");
        end else if (OP_NUM==71) begin
                file2 = $fopen({`FEED,"init_wt_wr","71",".dat"},"w");
        end else if (OP_NUM==72) begin
                file2 = $fopen({`FEED,"init_wt_wr","72",".dat"},"w");
        end else if (OP_NUM==73) begin
                file2 = $fopen({`FEED,"init_wt_wr","73",".dat"},"w");
        end else if (OP_NUM==74) begin
                file2 = $fopen({`FEED,"init_wt_wr","74",".dat"},"w");
        end else if (OP_NUM==75) begin
                file2 = $fopen({`FEED,"init_wt_wr","75",".dat"},"w");
        end else if (OP_NUM==76) begin
                file2 = $fopen({`FEED,"init_wt_wr","76",".dat"},"w");
        end else if (OP_NUM==77) begin
                file2 = $fopen({`FEED,"init_wt_wr","77",".dat"},"w");
        end else if (OP_NUM==78) begin
                file2 = $fopen({`FEED,"init_wt_wr","78",".dat"},"w");
        end else if (OP_NUM==79) begin
                file2 = $fopen({`FEED,"init_wt_wr","79",".dat"},"w");
        end else if (OP_NUM==80) begin
                file2 = $fopen({`FEED,"init_wt_wr","80",".dat"},"w");
        end else if (OP_NUM==81) begin
                file2 = $fopen({`FEED,"init_wt_wr","81",".dat"},"w");
        end else if (OP_NUM==82) begin
                file2 = $fopen({`FEED,"init_wt_wr","82",".dat"},"w");
        end else if (OP_NUM==83) begin
                file2 = $fopen({`FEED,"init_wt_wr","83",".dat"},"w");
        end else if (OP_NUM==84) begin
                file2 = $fopen({`FEED,"init_wt_wr","84",".dat"},"w");
        end else if (OP_NUM==85) begin
                file2 = $fopen({`FEED,"init_wt_wr","85",".dat"},"w");
        end else if (OP_NUM==86) begin
                file2 = $fopen({`FEED,"init_wt_wr","86",".dat"},"w");
        end else if (OP_NUM==87) begin
                file2 = $fopen({`FEED,"init_wt_wr","87",".dat"},"w");
        end else if (OP_NUM==88) begin
                file2 = $fopen({`FEED,"init_wt_wr","88",".dat"},"w");
        end else if (OP_NUM==89) begin
                file2 = $fopen({`FEED,"init_wt_wr","89",".dat"},"w");
        end else if (OP_NUM==90) begin
                file2 = $fopen({`FEED,"init_wt_wr","90",".dat"},"w");
        end else if (OP_NUM==91) begin
                file2 = $fopen({`FEED,"init_wt_wr","91",".dat"},"w");
        end else if (OP_NUM==92) begin
                file2 = $fopen({`FEED,"init_wt_wr","92",".dat"},"w");
        end else if (OP_NUM==93) begin
                file2 = $fopen({`FEED,"init_wt_wr","93",".dat"},"w");
        end else if (OP_NUM==94) begin
                file2 = $fopen({`FEED,"init_wt_wr","94",".dat"},"w");
        end else if (OP_NUM==95) begin
                file2 = $fopen({`FEED,"init_wt_wr","95",".dat"},"w");
        end else if (OP_NUM==96) begin
                file2 = $fopen({`FEED,"init_wt_wr","96",".dat"},"w");
        end else if (OP_NUM==97) begin
                file2 = $fopen({`FEED,"init_wt_wr","97",".dat"},"w");
        end else if (OP_NUM==98) begin
                file2 = $fopen({`FEED,"init_wt_wr","98",".dat"},"w");
        end else if (OP_NUM==99) begin
                file2 = $fopen({`FEED,"init_wt_wr","99",".dat"},"w");
        end else if (OP_NUM==100) begin
                file2 = $fopen({`FEED,"init_wt_wr","100",".dat"},"w");
        end else if (OP_NUM==101) begin
                file2 = $fopen({`FEED,"init_wt_wr","101",".dat"},"w");
        end else if (OP_NUM==102) begin
                file2 = $fopen({`FEED,"init_wt_wr","102",".dat"},"w");
        end else if (OP_NUM==103) begin
                file2 = $fopen({`FEED,"init_wt_wr","103",".dat"},"w");
        end else if (OP_NUM==104) begin
                file2 = $fopen({`FEED,"init_wt_wr","104",".dat"},"w");
        end else if (OP_NUM==105) begin
                file2 = $fopen({`FEED,"init_wt_wr","105",".dat"},"w");
        end else if (OP_NUM==106) begin
                file2 = $fopen({`FEED,"init_wt_wr","106",".dat"},"w");
        end else if (OP_NUM==107) begin
                file2 = $fopen({`FEED,"init_wt_wr","107",".dat"},"w");
        end else if (OP_NUM==108) begin
                file2 = $fopen({`FEED,"init_wt_wr","108",".dat"},"w");
        end else if (OP_NUM==109) begin
                file2 = $fopen({`FEED,"init_wt_wr","109",".dat"},"w");
        end else if (OP_NUM==110) begin
                file2 = $fopen({`FEED,"init_wt_wr","110",".dat"},"w");
        end else if (OP_NUM==111) begin
                file2 = $fopen({`FEED,"init_wt_wr","111",".dat"},"w");
        end else if (OP_NUM==112) begin
                file2 = $fopen({`FEED,"init_wt_wr","112",".dat"},"w");
        end else if (OP_NUM==113) begin
                file2 = $fopen({`FEED,"init_wt_wr","113",".dat"},"w");
        end else if (OP_NUM==114) begin
                file2 = $fopen({`FEED,"init_wt_wr","114",".dat"},"w");
        end else if (OP_NUM==115) begin
                file2 = $fopen({`FEED,"init_wt_wr","115",".dat"},"w");
        end else if (OP_NUM==116) begin
                file2 = $fopen({`FEED,"init_wt_wr","116",".dat"},"w");
        end else if (OP_NUM==117) begin
                file2 = $fopen({`FEED,"init_wt_wr","117",".dat"},"w");
        end else if (OP_NUM==118) begin
                file2 = $fopen({`FEED,"init_wt_wr","118",".dat"},"w");
        end else if (OP_NUM==119) begin
                file2 = $fopen({`FEED,"init_wt_wr","119",".dat"},"w");
        end else if (OP_NUM==120) begin
                file2 = $fopen({`FEED,"init_wt_wr","120",".dat"},"w");
        end else if (OP_NUM==121) begin
                file2 = $fopen({`FEED,"init_wt_wr","121",".dat"},"w");
        end else if (OP_NUM==122) begin
                file2 = $fopen({`FEED,"init_wt_wr","122",".dat"},"w");
        end else if (OP_NUM==123) begin
                file2 = $fopen({`FEED,"init_wt_wr","123",".dat"},"w");
        end else if (OP_NUM==124) begin
                file2 = $fopen({`FEED,"init_wt_wr","124",".dat"},"w");
        end else if (OP_NUM==125) begin
                file2 = $fopen({`FEED,"init_wt_wr","125",".dat"},"w");
        end else if (OP_NUM==126) begin
                file2 = $fopen({`FEED,"init_wt_wr","126",".dat"},"w");
        end else if (OP_NUM==127) begin
                file2 = $fopen({`FEED,"init_wt_wr","127",".dat"},"w");
        end else if (OP_NUM==128) begin
                file2 = $fopen({`FEED,"init_wt_wr","128",".dat"},"w");
        end
			
			for(i=0;i<`N1;i=i+1) begin
				$fwrite(file2,"%b\n",weight[i]);
			end
				$fwrite(file2,"%b\n",weight[i]);
				$fclose(file2);
	
	end
end







endmodule
