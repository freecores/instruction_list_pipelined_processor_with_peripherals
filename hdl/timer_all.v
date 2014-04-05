
`include "timescale.v"
`include "defines.v"


module timer (clk, en, reset, type, preset, DN, TT, ACC);

	input clk, en, reset;
	input [`tcTypeLen-1:0] type;
	input [`tcPresetLen-1:0] preset;
	
	output DN, TT;
	output [`tcAccLen-1:0] ACC;
	
	reg DN = 0, TT = 0;
	reg [`tcAccLen-1:0] ACC = 0;
	
	reg [`tcTypeLen-1:0]	TimerType;
	reg [`tcTypeLen-1:0]	typeNext;
	

	
	parameter	OnDelayTimer			= `tcTypeLen'b0;
	parameter	OffDelayTimer			= `tcTypeLen'b1;
	parameter	RetOnDelayTimer		= `tcTypeLen'b10;
	parameter	defaultType				= `tcTypeLen'b11;
	
	always @ (type)
	begin
		case (type)
		
		`timerType1		:	begin
								typeNext = OnDelayTimer;
								end
								
		`timerType2		:	begin
								typeNext = OffDelayTimer;
								end
								
		`timerType3		:	begin
								typeNext = RetOnDelayTimer;
								end
								
		default			:	begin

								$display("	Timer is defined for unknown type.\n Valid types: On-delay, Off-delay, retentive-on-delay");
								end
								
		endcase
	end
	
	
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
		begin
			$write ("	timer module is reset	");
			TimerType = defaultType;
		end
		else
		begin
			TimerType = typeNext;
		end
	end
	
	
	always @ (posedge clk)
	begin

	
		case (TimerType)
		
		OnDelayTimer	:	begin
										if (reset)
										begin
											ACC = `tcAccLen'b0;
											DN = 1'b0;
											TT = 1'b0;
										end
										else
										begin
											if (en)
											begin
												if (ACC < preset)
												begin
													ACC = ACC + 1'b1;
													DN = 1'b0;
													TT = 1'b1;
												end
												else if (ACC >= preset)
												begin
													ACC = ACC;

													DN = 1'b1;
													TT = 1'b0;
												end
											end
											else
											begin
												ACC = `tcAccLen'b0;	// if not enabled
												DN = 1'b0;
												TT = 1'b0;
											end
										end
									end	// end this case
		
		OffDelayTimer	:	begin							// not correct implementation!
										if (reset)
										begin
											ACC = `tcAccLen'b0;
											DN = 1'b0;
											TT = 1'b0;
										end
										else
										begin
											if (!en)
											begin
												if (ACC < preset)
												begin
													ACC = ACC + 1'b1;
													DN = 1'b0;
													TT = 1'b1;
												end
												else if (ACC >= preset)
												begin
													ACC = ACC;
													DN = 1'b1;
													TT = 1'b0;
												end
											end
											else
											begin
												ACC = `tcAccLen'b0;	// if not enabled
												DN = 1'b0;
												TT = 1'b0;
											end
										end
									end	// end this case
		
		RetOnDelayTimer	:	begin

										if (reset)
										begin
											ACC = `tcAccLen'b0;
											DN = 1'b0;
											TT = 1'b0;
										end
										else
										begin
											if (en)
											begin
												if (ACC < preset)
												begin
													ACC = ACC + 1'b1;
													DN = 1'b0;
													TT = 1'b1;
												end
												else if (ACC >= preset)
												begin
													ACC = ACC;
													DN = 1'b1;




													TT = 1'b0;
												end
											end
											else
											begin
												ACC = ACC;	// retain ACC
												DN = 1'b0;
												TT = 1'b0;
											end
										end
									end	// end this case
				
				
				default		:	begin
									if (!reset)
									$display("	Error in timer type	");
									end
									
				endcase
		
	end

		
endmodule
