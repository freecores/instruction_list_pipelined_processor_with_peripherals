
`include "timescale.v"
`include "defines.v"

	module alu (input [`aluOpcodeLen-1:0] aluOpcode, input [7:0] op1, input [7:0] op2, input aluEn,
				output [7:0] aluOut, output carryOut);
				
		
		wire [8:0] operand1 = {1'b0, op1};
		wire [8:0] operand2 = {1'b0, op2};
		
		wire [8:0] addRes = operand1 + operand2;
		wire [8:0] subRes = operand1 - operand2;
		
		reg [8:0] aluOutput;
		reg carryOutput;
		
		always @ (aluEn or addRes or subRes or op1 or op2 or aluOpcode)
		begin

			
		if (aluEn)
		begin
				
				case (aluOpcode)
				
				`AND_alu	:	begin
								aluOutput = op1 & op2;
								end
								
				`OR_alu		:	begin
								aluOutput = op1 | op2;
								end
								
				`XOR_alu	:	begin
								aluOutput = op1^op2;
								end
								
				`GT_alu		:	begin
								aluOutput = op1>op2 ? 1'b1 : 1'b0;
								end
								
				`GE_alu		:	begin
								aluOutput = op1>=op2 ? 1'b1 : 1'b0;
								end
				
				`EQ_alu		:	begin
								aluOutput = op1==op2 ? 1'b1 : 1'b0;
								end
								
				`LE_alu		:	begin
								aluOutput = op1<=op2 ? 1'b1 : 1'b0;
								end
								
				`LT_alu		:	begin
								aluOutput = op1<op2 ? 1'b1 : 1'b0;
								end
				
				`ADD_alu	:	begin
								aluOutput = addRes[7:0];
								carryOutput = addRes[8];
								end
				
				`SUB_alu	:	begin
								aluOutput = subRes[7:0];
								carryOutput = subRes[8];
								end
								
				`LD_data	:	begin
								aluOutput = op1;
								end
				
				default		:	begin
								aluOutput = 16'b0;
								$write ("\nUnknown operation. \tmodule : ALU");
								end
				endcase
				
			end
			else
			begin
			
				aluOutput = aluOutput;
			end
				
		end
		
		assign aluOut = aluOutput;
		assign carryOut = carryOutput;
		
endmodule
