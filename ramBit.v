
`include "timescale.v"
`include "defines.v"

module bitRam (clk, reset, bitRamEn, bitRamRw, bitRamIn, bitRamAddr, bitRamOut);


		input	clk, reset, bitRamEn, bitRamRw, bitRamIn;
		input [`bitRamAddrLen-1:0]	bitRamAddr;
		
		output bitRamOut;
		
		reg bitRam [`bitRamDepth-1:0];
		reg bitRamOut;
		
		
		always @ (posedge clk or posedge reset)
		begin
		
			if (reset)
			begin
				bitRamOut = 1'b0;
				$write ("	module bitRam is reset	");
			end
			
			else
			begin
			
			if (bitRamEn)
			begin
				if (bitRamRw)	// read operation
				begin
					bitRamOut = bitRam[bitRamAddr];
					$write (" reading bit-RAM	:	module bitRAM	");
				end
				
				else				// write operation
				begin
					bitRam[bitRamAddr] = bitRamIn;
					$write ("	writing to bit-RAM	:	module bitRam	");
				end
			end
			
			else
			begin
				bitRamOut = 1'bZ;
			end
			
			end	// end else of reset
				
		end	// end always block
		
		
endmodule
