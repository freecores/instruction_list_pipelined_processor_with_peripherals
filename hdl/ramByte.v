
`include "timescale.v"
`include "defines.v"

module byteRam (clk, reset, byteRamEn, byteRamRw, byteRamIn, byteRamAddr, byteRamOut);

		input clk, reset, byteRamEn, byteRamRw;
		input [`byteRamLen-1:0] byteRamIn;
		input [`byteRamAddrLen-1:0] byteRamAddr;
		
		output [`byteRamLen-1:0] byteRamOut;
		
		reg [`byteRamLen-1:0] byteRam [`byteRamDepth-1:0];
		reg [`byteRamLen-1:0] byteRamOut;
		
		
		always @ (posedge clk or posedge reset)
		begin
		
			if (reset)
			begin
				byteRamOut = `byteRamLen'b0;
				$write ("	module byteRam is reset	");
			end
			
			else
			begin				
			
			if (byteRamEn)
			begin
			
				if (byteRamRw)		// read operation
				begin
					byteRamOut = byteRam[byteRamAddr];
					$write ("	reading byte RAM : module byteRam	");
				end
				
				
				else					// write operation
				begin
					byteRam[byteRamAddr] = byteRamIn;
					$write ("	writing to byte RAM	:	module byteRam	");
				end
			
			end
			
			else			// if Enable = 0
			begin
			
				byteRamOut = `byteRamLen'bz;
				
			end
			
			end		// end else of reset
		
		end	// end always
		
endmodule
