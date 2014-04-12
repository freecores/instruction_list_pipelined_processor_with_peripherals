
`include "timescale.v"
`include "defines.v"


module op2Mux (op2MuxSel, inputReadOut, outputReadOut, bitOut, byteOut, op2MuxOut);

	input [`op2MuxSelLen-1:0] op2MuxSel;
	input inputReadOut, outputReadOut, bitOut;
	input [7:0] byteOut;
	
	output [7:0] op2MuxOut;
	
	reg [7:0] op2MuxOut = 0;
	
	
	always @ (op2MuxSel)
	begin
	
		case (op2MuxSel)
		
		`op2MuxSelInput	:	begin
								op2MuxOut = {7'b0, inputReadOut};
								end
								
		`op2MuxSelOutput	:	begin
								op2MuxOut = {7'b0, outputReadOut};
								end
								
		`op2MuxSelBitRam	:	begin
								op2MuxOut = {7'b0, bitOut};
								end
								
		`op2MuxSelByteRam	:	begin
								op2MuxOut = byteOut;
								end
								
								
		default			:	begin
								op2MuxOut = op2MuxOut;
								end
								
		endcase
		
	end	// end always


endmodule
