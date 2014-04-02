
`include "timescale.v"
`include "defines.v"

module bitNegator (bitIn, bitN, bitOut);

	input bitIn, bitN;
	output bitOut;
	
	reg bitOut;
	
	
	always @ (bitIn or bitN)
	begin
	
		if (bitN)
		begin
			bitOut = ~ bitIn;
		end
		else
		begin
			bitOut = bitIn;
		end
	
	end

endmodule
