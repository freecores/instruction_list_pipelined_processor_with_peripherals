
`include "timescale.v"
`include "defines.v"


module spiBufReg(Rd, in8, bufOUT);

	input Rd;
	input [7:0] in8;
	
	output [7:0] bufOUT;
	
	
	reg [7:0] bufOUT, BUFFER = 8'b 00000000;
	

	always @ (Rd)

				bufOUT = BUFFER;
		

	always @ (in8)
				BUFFER = in8;

	

endmodule
