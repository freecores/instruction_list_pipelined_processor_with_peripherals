
`include "timescale.v"
`include "defines.v"


module ppReg1 (clk, opcodeIn, fieldIn, opcodeOut, fieldOut);

		input clk;
		input [`instOpCodeLen-1:0] opcodeIn;
		input [`instFieldLen-1:0] fieldIn;
		
		output [`instOpCodeLen-1:0] opcodeOut;
		output [`instFieldLen-1:0] fieldOut;
		
		reg [`instOpCodeLen-1:0] opcodeOut;
		reg [`instFieldLen-1:0] fieldOut;
		
		
		always @ (posedge clk)
		begin
		
				opcodeOut = opcodeIn;
				fieldOut = fieldIn;
		end



endmodule
