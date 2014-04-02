
`include "timescale.v"
`include "defines.v"


module tcReset (tcResetEn, resetIn, tcAddr, resetOut);

	input tcResetEn, resetIn;
	input [`tcAddrLen-1:0] tcAddr;
	
	output [`tcNumbers-1:0] resetOut;
	
	reg [`tcNumbers-1:0] resets;
	
	
	always @ *
	begin
		if (tcResetEn)
		begin
			resets[tcAddr] = resetIn;
		end
	end
	
	assign resetOut = resets;


endmodule
