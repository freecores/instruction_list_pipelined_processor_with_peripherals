
`include "timescale.v"
`include "defines.v"


module outputReg (reset, outputRw, outputRwAddr, outputWriteIn, outputReadOut, outputs);

	input reset, outputRw;
	input [`outputAddrLen-1:0] outputRwAddr;
	input outputWriteIn;
	
	output outputReadOut;
	output [`outputNumber-1:0] outputs;
	
	reg outputReadOut;
	reg [`outputNumber-1:0] outputs;
	reg [`outputNumber-1 :0] outputReg;
	
	
	
	always @ (reset or outputRw or outputRwAddr or outputWriteIn or outputReg)
	begin
	
		if (reset)
		begin
			outputReadOut = 1'bz;
			$write ("	module outputRegister is reset	");
		end
		
		else
		begin
		
			outputs = outputReg;
		
			if (outputRw)	// read output status
			begin
				outputReadOut = outputReg[outputRwAddr];
				$write ("	reading output register	:	module outputRegister	");
			end
			else				// write operation
			begin
				outputReg[outputRwAddr] = outputWriteIn;
				$write ("	writing to the output register	:	module outputRegister	");
			end
		
		end
	
	end


endmodule
