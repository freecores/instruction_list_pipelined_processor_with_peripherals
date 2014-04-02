
`include "timescale.v"
`include "defines.v"


module tcEnableAndType (entypeEn, enIn, typeIn, tcAddr, enOut, typeOut);

	input entypeEn, enIn;
	input [`tcTypeLen-1:0] typeIn;	// could be `counterTypeLen
	input [`tcAddrLen-1:0] tcAddr;
	
	output wire [`tcNumbers-1:0] enOut;
	output wire [(`tcNumbers*`tcTypeLen)-1:0] typeOut;
	
	reg enables [`tcNumbers-1:0];
	reg [`tcTypeLen-1:0] types [`tcNumbers-1:0];
	
	always @ *
	begin
		if (entypeEn)
		begin
			enables[tcAddr] = enIn;
			types[tcAddr] = typeIn;
		end
	end
	
	// assign outputs . . .
	// can write generic???
	
	assign enOut[0]= enables[0];
	assign enOut[1]= enables[1];
	assign enOut[2]= enables[2];
	assign enOut[3]= enables[3];
	assign enOut[4]= enables[4];
	assign enOut[5]= enables[5];
	assign enOut[6]= enables[6];
	assign enOut[7]= enables[7];
	
	assign typeOut[`tcTypeLen-1:0] = types[0];
	assign typeOut[(`tcTypeLen*2)-1:`tcTypeLen] = types[1];
	assign typeOut[(`tcTypeLen*3)-1:(`tcTypeLen*2)] = types[2];
	assign typeOut[(`tcTypeLen*4)-1:(`tcTypeLen*3)] = types[3];
	assign typeOut[(`tcTypeLen*5)-1:(`tcTypeLen*4)] = types[4];
	assign typeOut[(`tcTypeLen*6)-1:(`tcTypeLen*5)] = types[5];
	assign typeOut[(`tcTypeLen*7)-1:(`tcTypeLen*6)] = types[6];
	assign typeOut[(`tcTypeLen*8)-1:(`tcTypeLen*7)] = types[7];


endmodule
