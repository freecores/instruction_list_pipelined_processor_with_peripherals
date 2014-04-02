
`include "timescale.v"
`include "defines.v"


module accumulatorMUX (accMuxSel, immData, aluOut 
								`ifdef timerAndCounter_peripheral
								, tcLoadIn, tcAccIn
								`endif
								`ifdef UART_peripheral
								, uartDataIn
								`endif
								`ifdef SPI_peripheral
								, spiStatIn, spiBufIn
								`endif
								, accMuxOut
								);

	input [`accMuxSelLen-1:0]	accMuxSel;
	input [`immDataLen-1:0]		immData;
	input	[7:0]	aluOut;
	`ifdef timerAndCounter_peripheral
	input [7:0] tcLoadIn, tcAccIn;
	`endif
	`ifdef UART_peripheral
	input [7:0] uartDataIn;
	`endif
	`ifdef SPI_peripheral
	input [7:0] spiStatIn, spiBufIn;
	`endif
	
	output [7:0]	accMuxOut;
	
	reg [7:0]	accMuxOut;
	
	
	always @ *
	begin
	
		case (accMuxSel)
		
			`accMuxSelImmData	:	begin
										accMuxOut = immData;
										end
								
			`accMuxSelAluOut	:	begin
										accMuxOut = aluOut;
										end
			
			`ifdef timerAndCounter_peripheral
			`accMuxSelTcLoad	:	begin
										accMuxOut = tcLoadIn;
										end
			
			`accMuxSelTcAcc	:	begin
										accMuxOut = tcAccIn;
										end
			`endif
			
			`ifdef UART_peripheral
			`accMuxSelUart	:		begin
										accMuxOut = uartDataIn;
										end
			`endif
			
			`ifdef SPI_peripheral
			`accMuxSelSpiStat	:	begin
										accMuxOut = spiStatIn;
										end
			
			`accMuxSelSpiBuf	:	begin
										accMuxOut = spiBufIn;
										end
			`endif
			
			
			default		:	begin
								accMuxOut = 8'bzzzzzzzz;
								end
								
		endcase
	
	end


endmodule
