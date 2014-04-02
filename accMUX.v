
`include "timescale.v"
`include "defines.v"


module accumulatorMUX (accMuxSel, immData, aluOut, accMuxOut);

	input [`accMuxSelLen-1:0]	accMuxSel;
	input [`immDataLen-1:0]		immData;
	input	[7:0]	aluOut;
	
	output [7:0]	accMuxOut;
	
	reg [7:0]	accMuxOut;
	
	
	always @ *
	begin
	
		case (accMuxSel)
		
			`accMuxSel0	:	begin
								accMuxOut = immData;
								end
								
			`accMuxSel1	:	begin
								accMuxOut = aluOut;
								end
			
			default		:	begin
								accMuxOut = 8'bzzzzzzzz;
								end
								
		endcase
	
	end


endmodule
