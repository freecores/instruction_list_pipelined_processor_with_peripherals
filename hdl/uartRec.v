
`include "timescale.v"
`include "defines.v"


module uartRec(clk, reset, sTick, rx, rxDoneTick, dOut);

		parameter dataBits = `dataBits;
		parameter sbTick = `sbTick;
		
		input clk, reset, sTick, rx;
		output rxDoneTick;
		output [dataBits-1:0] dOut;
		
		reg rxDoneTick;
		// states:
		
	localparam idle = 2'b00, start = 2'b01, data = 2'b10, stop = 2'b11;
	
		reg [1:0] stateReg, stateNext;	// current and next states
		reg [3:0] sReg, sNext;		//	counter
		reg [2:0] nReg, nNext;		// counter
		reg [7:0] bReg, bNext;		// data recieved in this..
		
		
		always @ (posedge clk or posedge reset)
		begin
			if (reset)
			begin
				stateReg <= idle;
				sReg <= 1'b0;
				bReg <= 1'b0;
				nReg <= 1'b0;
			end	// end if
			
			else
			begin
				stateReg <= stateNext;
				sReg <= sNext;
				bReg <= bNext;
				nReg <= nNext;
			end	// end else
		
		end	// end always
		
		
		
		// FSM next state logic:
		
		always @ *
		begin
		
				stateNext = stateReg;
				sNext = sReg;
				bNext = bReg;
				nNext = nReg;
				rxDoneTick = 1'b0;
				
			case (stateReg)
			
			idle	:	if (~rx)
						begin
							stateNext = start;	// start when rx is activated
							sNext = 0;	// initialize sampling counter
						end	// end if rx
						
			start	:	if (sTick)
							if (sReg == 7)
							begin
								stateNext = data;		// at middle of oversampled start
													// bit, go to data state
								sNext = 0;
								nNext = 0;
							end	// end if sReg==7
							
							else
								sNext = sReg + 1;	// otherwise keep increment sReg upto 7
			
			data	:	if (sTick)
							if (sReg == 15)	// if reached middle of next bit
							begin
								sNext = 0;	// reset counter
								bNext = {rx, bReg[7:1]};	// LSB first, and the
														//data recieved in bReg
								if (nReg == (dataBits-1))	// if all data recvd,
									stateNext = stop;	// go to stop bit(s) state
								else
									nNext = nReg + 1;
							end	// end if sReg==15
							
							else
								sNext = sReg + 1;	// otherwise keep increment sReg upto 15
							
			stop	:	if (sTick)
							if (sReg == (sbTick-1))
							begin
								stateNext = idle;		// done reception, go to idle state
								rxDoneTick = 1'b1;	// raise done tick!
							end	// end if sReg==sbTick-1
							
							else
								sNext = sReg + 1;		// otherwise keep increment sReg 
															//upto (sbTick-1)
			endcase
		
		end	// end always combinatorial
		
		
		// recvd data output
		
		assign dOut = bReg;


endmodule
