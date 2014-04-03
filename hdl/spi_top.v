
`include "timescale.v"
`include "defines.v"


module spi_top(clk, sconEN, statREAD, sconIN, statOUT, wrBUF, rdBUF, bufIN, bufOUT, MI, MO, SCK);

		input clk, MI, sconEN, statREAD, wrBUF, rdBUF;
		input [7:0] sconIN, bufIN;
		
		output MO, SCK;
		output [7:0] statOUT, bufOUT;
		
		
		wire BF;
		
		wire [7:0] sconOUT, bufOUT, bufregIN;
		
		wire [7:0] buffer_out8;
		
		
spiStatReg STATUS_REG (statREAD, statOUT, BF);


spiConReg CONTROL_REG (sconEN, sconIN, sconOUT);


spiBufReg BUFFER_REG (rdBUF, bufregIN, bufOUT);


spiEngine ENGINE (bufIN, bufregIN, clk, MI, MO, SCK, wrBUF, sconOUT[7], sconOUT[0], BF);

endmodule
