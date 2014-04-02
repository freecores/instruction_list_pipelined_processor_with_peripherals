
`include "timescale.v"
`include "defines.v"


module op2Mux (op2MuxSel, inputReadOut, outputReadOut, bitOut, byteOut, op2MuxOut);

	input [`op2MuxSelLen-1:0] op2MuxSel;
	input inputReadOut, outputReadOut, bitOut;
	input [7:0] byteOut;
	
	output [7:0] op2MuxOut;
	
	reg [7:0] op2MuxOut;
	
	
	always @ *
	begin
	
		case (op2MuxSel)
		
		`op2MuxSel0		:	begin
								op2MuxOut = {7'b0, inputReadOut};
								end
								
		`op2MuxSel1		:	begin
								op2MuxOut = {7'b0, outputReadOut};
								end
								
		`op2MuxSel2		:	begin
								op2MuxOut = {7'b0, bitOut};
								end
								
		`op2MuxSel3		:	begin
								op2MuxOut = byteOut;
								end
								
								
		default			:	begin
								op2MuxOut = 8'bzzzzzzzz;
								end
								
		endcase
		
	end	// end always


endmodule
