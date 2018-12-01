`include "header.vh"

module control(
	 input	clk,
    input	rst,
    input	start_main,
	 input	[1:0]train_test_classify,	
	 input	valid_buffering,
	 input	valid_rfing,
	 input	valid_maxing,
	 input	done_core_img,
	 input	valid_deciding,

	 
	 output	buffering,
	 output	rfing,
	 output	maxing,
	 output	coring,
	 output	start_core_img,
	 output	deciding,
    output	valid_all

    );
	 
 
reg	buffering;
reg	rfing;
reg	maxing;
reg	coring;
reg	start_core_img;
reg	deciding;
reg	valid_all;		
	 
parameter M=784, N=8, W=8, D = 1,IM_WID = 28, IM_HEI = 28,
			 REF = 30, TH = 5, PRES = 0, PMIN = -1;	

//States
localparam	[3:0]	idle   				 	= 4'b0000,
						train_buff				= 4'b0001,
						train_rf					= 4'b0010,
						train_maxer				= 4'b0011,
						train_core				= 4'b0100,
						train_decider			= 4'b0101,							
						
						test_buff				= 4'b0110,
						test_rf					= 4'b0111,
						test_core				= 4'b1000,
						test_decider			= 4'b1001,
						
						classify_buff			= 4'b1010,
						classify_rf				= 4'b1011,
						classify_core			= 4'b1100,
						classify_decider		= 4'b1101;

reg[3:0]				state_reg;

	

always@(posedge clk, posedge rst)
begin
	if(rst) begin
		state_reg		<= idle;
		buffering		<= 0;
		rfing				<= 0;
		maxing			<= 0;
		coring			<= 0;
		deciding			<= 0;
		start_core_img <= 0;
		valid_all		<= 0;
	end else begin
		valid_all		<= 0;
		start_core_img <= 0;
		
		case(state_reg)
		
		idle:	
			begin
				if(start_main) begin
					case(train_test_classify)	
						2'b01:	begin
									state_reg <= train_buff;
									end
						2'b10:	begin	
									state_reg <= test_buff;
									end 
						2'b11:	begin	
									state_reg <= classify_buff;
									end	
						default: begin
									state_reg <= idle;
									end
					endcase
					buffering <= 1;
				end
			end
		
		train_buff:
			begin
				if(valid_buffering) begin
					state_reg	<= train_rf;
					buffering	<= 0;
					rfing			<= 1;
				end
			end
		
		train_rf:
			begin
				if(valid_rfing) begin
					state_reg	<= train_maxer;
					rfing			<= 0;
					maxing		<= 1;
				end
			end
			
		train_maxer:
			begin
				if(valid_maxing) begin
					state_reg	<= train_core;
					maxing		<= 0;
					coring		<= 1;
					start_core_img	<= 1;
				end
			end
			
		train_core:
			begin
				if(done_core_img) begin
					state_reg	<= train_decider;
					coring		<= 0;
					deciding		<= 1; 				//just for 1 cycle
				end
			end
			
		train_decider:
			begin
				if(valid_deciding) begin
					state_reg	<= idle;
					deciding		<= 0;
					valid_all	<= 1;
				end
			end
		
		
		test_buff:
			begin
				if(valid_buffering) begin
					state_reg	<= train_rf;
					buffering	<= 0;
					rfing			<= 1;
				end
			end
			
		test_rf:
			begin
				if(valid_rfing) begin
					state_reg	<= test_core;
					rfing			<= 0;
					coring		<= 1;
					start_core_img	<= 1;
				end	
			end
			
		test_core:
			begin
				if(done_core_img) begin
					state_reg	<= test_decider;
					coring		<= 0;
					deciding		<= 1;
				end
			end

		test_decider:
			begin
				if(valid_deciding) begin
					state_reg	<= idle;
					deciding		<= 0;
					valid_all	<= 1;
				end
			end
			
		
		classify_buff:
			begin
				if(valid_buffering) begin
					state_reg	<= classify_rf;
					buffering	<= 0;
					rfing			<= 1;
				end
			end
			
		classify_rf:
			begin
				if(valid_rfing) begin
					state_reg	<= classify_core;
					rfing			<= 0;
					coring		<= 1;
					start_core_img	<= 1;
				end
			end
			
		classify_core:
			begin
				if(done_core_img) begin
					state_reg	<= classify_decider;
					coring		<= 0;
					deciding		<= 1;
				end
			end

		classify_decider:
			begin
				if(valid_deciding) begin
					state_reg	<= idle;
					deciding		<= 0;
					valid_all	<= 1;
				end
			end
		
		default:
			begin
				state_reg	<= idle;
			end
		endcase
	end
end






endmodule
