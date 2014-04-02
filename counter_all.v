
`include "timescale.v"
`include "defines.v"


module counter (clk, reset, preset, type, DN, CU, CD, ACC);

	input clk, reset;
	input [`tcPresetLen-1:0] preset;
	input [`tcTypeLen-1:0] type;
	
	output DN, CU, CD;
	output [`tcAccLen-1:0] ACC;
	
	reg DN, CU, CD;
	reg [`tcAccLen-1:0] ACC;
	
	reg [`tcTypeLen-1:0] CounterType;
	reg [`tcTypeLen-1:0] typeNext;
	
	
	parameter	UpCounter	= `tcTypeLen'b01;
	parameter	DownCounter	= `tcTypeLen'b10;
	parameter	defaultType	= `tcTypeLen'b00;
	
	
	
	always @ (type)
	begin
	
		case (type)
		
		`counterType1	:	begin
								typeNext = UpCounter;
								end
								
		`counterType2	:	begin
								typeNext = DownCounter;
								end
								
		default			:	begin
								$display ("counter is of undefined type.\n Valid types are Up counter & Down counter");
								end
		endcase
	end
	
	
	always @ (posedge clk or posedge reset)
	begin
	
		if (reset)
		begin
			$display ("counter module is reset");
			CounterType = defaultType;
		end
		else
		begin
			CounterType = typeNext;
		end
	end
	
	
	always @ (posedge clk)
	begin
	
		case (CounterType)
		
		UpCounter	:	begin
									CD = 0;			// CD id always 0 for this state
									
									if (reset)
									begin
										ACC = `tcAccLen-1'b0;	// starts at lowest value
										CU = 0;
										DN = 0;
									end
									else
									begin
										ACC = ACC + 1'b1;
										CU = 1'b1;
										if (ACC > preset)
										begin
											DN = 1'b1;
										end
									end
							end
		
		
		
		DownCounter	:	begin
									CU = 0;			// CU id always 0 for this state
									
									if (reset)
									begin
										ACC = `tcAccLen-1'b1;	// starts at highest value
										CD = 0;
										DN = 0;
									end
									else
									begin
										ACC = ACC - 1'b1;
										CD = 1'b1;
										if (ACC < preset)
										begin
											DN = 1'b1;
										end
									end
							end
		
		
		
		default		:	begin
							$display ("	error in counter type	");
							end
				
		endcase
	end


endmodule
