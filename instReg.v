
`include "timescale.v"
`include "defines.v"


module instReg (instIn, instOpCode, instField);

	input [`instLen:0-1] instIn;
	
	output [`instOpCodeLen-1:0] instOpCode;
	output [`instFieldLen-1:0] instField;
	
	reg [`instLen-1:0] instRegister;
	
	
	always @ (instIn)
	begin
	
		instRegister = instIn;
	
	end
	
	
	assign instOpcode = instRegister[`instLen-1:(`instLen-`instOpCodeLen)];
	
	assign instField = instRegister[(`instFieldLen-1):0];



endmodule
