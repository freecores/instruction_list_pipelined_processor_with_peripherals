
`include "timescale.v"
`include "defines.v"


module accumulator (accIn, accEn, accOut);

	input [7:0] accIn;
	input accEn;
	
	output [7:0] accOut;
	
	reg [7:0] accOut;

	always @ (accIn, accEn)
	begin
		if (accEn)
		begin
			accOut = accIn;
			$write (" %b	data written to accumulator	:	module accumulator	", accIn);
		end
		else
		begin
			accOut = accOut;
		end
	end	// end always


endmodule
