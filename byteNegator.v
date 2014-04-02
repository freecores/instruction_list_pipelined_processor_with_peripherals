
`include "timescale.v"
`include "defines.v"

module byteNegator (byteIn, byteN, byteOut);

	input [7:0]	byteIn;
	input byteN;
	
	output [7:0] byteOut;
	
	reg [7:0] byteOut;
	
	
	always @ (byteIn or byteN)
	begin
	
		if (byteN)
		begin
			byteOut = ~ byteIn;
		end
		else
		begin
			byteOut = byteIn;
		end
	
	end

endmodule
