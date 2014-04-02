
`include "timescale.v"
`include "defines.v"


module uartFifo(clk, reset, wData, rData, wr, rd, full, empty);

		parameter dataBits = `dataBits;
		parameter fifoWidth = `fifoWidth;
		parameter fiforegs = `number_fifo_regs;
		parameter fifoCntrWidth = `fifoCntrWidth;
		parameter fifodepth = `fifoDepth;
		
	//	integer i;
		
		input [dataBits-1 : 0] wData;
		input clk, reset, rd, wr;
		output [`dataBits-1 : 0] rData;
		output full, empty;
		
		reg [dataBits-1 : 0] fifoReg [0:fiforegs-1];
		
		reg [dataBits-1 : 0] rData;
		
		reg full=1'b0, empty=1'b1;
		
		// pointers
		reg [fifoWidth-1 : 0] top = 4'b1111, bottom = 4'b1111;
		wire [fifoWidth-1 : 0] topPlusOne = top + 1'b1;
		
		//counter
		reg [fifoCntrWidth-1 : 0] cntr = 0;

		
			always @ (posedge clk or posedge reset)
			begin
			
				if (reset)
				begin
						top = 0;
						bottom = 0;
						
						fifoReg[0] = 0;
						fifoReg[1] = 0;
						fifoReg[2] = 0;
						fifoReg[3] = 0;
						fifoReg[4] = 0;
						fifoReg[5] = 0;
						fifoReg[6] = 0;
						fifoReg[7] = 0;
						fifoReg[8] = 0;
						fifoReg[9] = 0;
						fifoReg[10] = 0;
						fifoReg[11] = 0;
						fifoReg[12] = 0;
						fifoReg[13] = 0;
						fifoReg[14] = 0;
						fifoReg[15] = 0;
				end //end if(reset)
				
				
				
				else
				begin
				
					case ({rd, wr})
					
						2'b 01	:	if (cntr <= fifodepth)
										begin
										fifoReg[top] = wData;
										top = topPlusOne;
										cntr = cntr + 1'b1;
										end
						
						2'b 10	:	if (cntr > 0)
										begin
										rData = fifoReg[bottom];
										fifoReg[bottom] = 0;
										bottom = bottom + 1'b1;
										cntr = cntr - 1'b1;
																				
										end
						
						2'b 11	:	if ((cntr >0) & (cntr <= fifodepth))
										begin
										rData = fifoReg[bottom];
										fifoReg[bottom] = 0;
										bottom = bottom + 1'b1;
										fifoReg[top] = wData;
										top = topPlusOne;
										end
						
						default	:	;
					endcase
				
				end // end else
				
			end // end always
			
			//assign rData = fifoReg[bottom];
			
			always @ (posedge clk or posedge reset)
			begin
				
				if (reset)
				begin
					full <= 1'b0;
					empty <= 1'b1;	end
				
				else 
				begin
					if(~rd & (cntr>=(fifodepth-1)))
					begin
						full <= 1'b1;
						//$display ($time, " ns \t * FIFO FULL ");
						empty <= 1'b0;	end
					
					else if (~wr & (cntr==4'b0000))
					begin
						empty <= 1'b1;
						full <= 1'b0;	end
					
					else if ((cntr != 0) | (cntr != fifodepth))
					begin
						empty <= 1'b0;
						full <= 1'b0;	end
					end	// end else i.e. (!reset)
			
			end	// end always 
			
			
			always @ *
			begin
			
				if (full & wr)
				$display ($time, "ns \t\t attempting to write to full fifo.... data overwritten");
				
				else
				if (empty & rd)
				$display ($time, "ns \t\t attempting to read from empty fifo...");
			
			end
					
	
endmodule
