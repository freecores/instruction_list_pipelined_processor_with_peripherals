
`include "timescale.v"
`include "defines.v"


module spiStatReg (spiStatIn, spiStatRead, spiStatOut);

		input spiStatRead;
		input [7:0] spiStatIn;
		
		output [7:0] spiStatOut;
		
		reg [7:0] spiStatOut, status = 8'b 00000000;
		
		always @ (spiStatRead or status)
				if (spiStatRead)
					spiStatOut = status;
		
		always @ (spiStatIn)
			status = spiStatIn;
		
endmodule
