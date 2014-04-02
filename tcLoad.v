
`include "timescale.v"
`include "defines.v"


module tcLoad (tcLoadEn, tcAddr, dnIn, ttIn, cuIn, cdIn, tcLoadOut);

	input tcLoadEn;
	input [`tcAddrLen-1:0] tcAddr;
	input [`tcNumbers-1:0] dnIn, ttIn, cuIn, cdIn;
	
	output [7:0] tcLoadOut;
	
	reg [`tcNumbers-1:0] dnInReg, ttInReg, cuInReg, cdInReg;
	
	wire dnSel, ttSel, cuSel, cdSel;
				
	always @ *
	begin
		dnInReg = dnIn;
		ttInReg = ttIn;
		cuInReg = cuIn;
		cdInReg = cdIn;
	end
			
	assign dnSel = dnInReg[tcAddr];
	assign ttSel = ttInReg[tcAddr];
	assign cuSel = cuInReg[tcAddr];
	assign cdSel = cdInReg[tcAddr];

	assign tcLoadOut = {4'b0, dnSel, ttSel, cuSel, cdSel};

endmodule
