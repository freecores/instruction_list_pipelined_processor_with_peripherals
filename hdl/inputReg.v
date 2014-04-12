
`include "timescale.v"
`include "defines.v"



module inputRegister (inputs, inputReadAddr, inputReadOut);

	input [`inputNumber-1:0] inputs;
	input [`inputAddrLen-1:0] inputReadAddr;
	
	output inputReadOut;
	
	wire [`inputNumber-1:0] inputs;
	
	
	
	assign inputReadOut = inputs[inputReadAddr];


endmodule
