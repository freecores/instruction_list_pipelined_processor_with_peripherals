
`include "timescale.v"
`include "defines.v"


module spiConReg (sconEn, sconIn, sconOut);

		input sconEn;
		input [7:0] sconIn;
		
		output [7:0] sconOut;
		
		reg [7:0] sconOut, controlBits = 8'b 00000000;
		
		
		always @ (sconEn or controlBits)
		begin
		
			if (sconEn)
				sconOut = controlBits;
				
		end
		
		always @ (sconIn)
		begin
				controlBits = sconIn;
		end

endmodule
