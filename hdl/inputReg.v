
`include "timescale.v"
`include "defines.v"



module inputRegister (reset, inputs, inputRead, inputReadAddr, inputReadOut);

	input [`inputNumber-1:0] inputs;
	input inputRead, reset;
	input [`inputAddrLen-1:0] inputReadAddr;
	
	output inputReadOut;
	
	reg inputReadOut;
	reg [`inputNumber-1:0] inputReg;
	
	
	always @ (reset or inputs or inputRead or inputReadAddr)
	begin
	
		if (reset)
		begin
			inputReadOut = 1'bz;
			$write ("\nmodule inputRegister is reset	");
		end
		
		else
		begin
		
			inputReg = inputs;
			
			if (inputRead)
			begin
				inputReadOut = inputReg [inputReadAddr];
				$write ("\nreading input	:	module inputRegister	");
			end
		
		end
	
	end


endmodule
