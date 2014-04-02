
`include "timescale.v"
`include "defines.v"


module tcPreset (tcPresetEn, presetIn, tcAddr, presetOut);

	input tcPresetEn;
	input [`tcPresetLen-1:0] presetIn;
	input [`tcAddrLen-1:0] tcAddr;
	
	output [(`tcPresetLen*`tcNumbers)-1:0] presetOut;
	
	reg [`tcPresetLen-1:0] presets [`tcNumbers-1:0];
	
	
	always @ *
	begin
		if (tcPresetEn)
		begin
			presets[tcAddr] = presetIn;
		end
	end
	
	assign presetOut[`tcPresetLen-1:0] = presets[0];
	assign presetOut[(`tcPresetLen*2)-1:`tcPresetLen] = presets[1];
	assign presetOut[(`tcPresetLen*3)-1:(`tcPresetLen*2)] = presets[2];
	assign presetOut[(`tcPresetLen*4)-1:(`tcPresetLen*3)] = presets[3];
	assign presetOut[(`tcPresetLen*5)-1:(`tcPresetLen*4)] = presets[4];
	assign presetOut[(`tcPresetLen*6)-1:(`tcPresetLen*5)] = presets[5];
	assign presetOut[(`tcPresetLen*7)-1:(`tcPresetLen*6)] = presets[6];
	assign presetOut[(`tcPresetLen*8)-1:(`tcPresetLen*7)] = presets[7];
	assign presetOut[(`tcPresetLen*9)-1:(`tcPresetLen*8)] = presets[8];
	assign presetOut[(`tcPresetLen*10)-1:(`tcPresetLen*9)] = presets[9];
	assign presetOut[(`tcPresetLen*11)-1:(`tcPresetLen*10)] = presets[10];
	assign presetOut[(`tcPresetLen*12)-1:(`tcPresetLen*11)] = presets[11];
	assign presetOut[(`tcPresetLen*13)-1:(`tcPresetLen*12)] = presets[12];
	assign presetOut[(`tcPresetLen*14)-1:(`tcPresetLen*13)] = presets[13];
	assign presetOut[(`tcPresetLen*15)-1:(`tcPresetLen*14)] = presets[14];
	assign presetOut[(`tcPresetLen*16)-1:(`tcPresetLen*15)] = presets[15];
	

endmodule
