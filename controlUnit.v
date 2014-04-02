
`include "timescale.v"
`include "defines.v"


module controlUnit (clk, reset, instOpCodeIn, acc0, iomemCode,
							branch,
							accMuxSel, accEn, op2MuxSel, aluOpcode,
							bitRamEn, bitRamRw, byteRamEn, byteRamRw,
							inputRead, outputRw
							
							`ifdef timerAndCounter_peripheral
								, entypeEn, tcAccRead, tcResetEn, tcPresetEn, tcLoadEn
							`endif
							
							`ifdef UART_peripheral
								, uartRead, uartWrite
							`endif
							
							`ifdef SPI_peripheral
								, sconEn, spiStatRead, spiBufRead, spiBufWrite, spiBufShift
							`endif
							
							);
							
	
	input clk, reset;
	input [`instOpCodeLen-1:0] instOpCode;
	input acc0;
	input [1:0] iomemCode;
	
	output branch;
	output [`accMuxSelLen-1:0]	accMuxSel;
	output accEn;
	output [`op2MuxSelLen-1:0]	op2MuxSel;
	output [`aluOpcodeLen-1:0] aluOpcode;
	output bitRamEn, bitRamRw, byteRamEn, byteRamRw;
	output inputRead, outputRw;
	
	`ifdef timerAndCounter_peripheral
	output entypeEn, tcAccRead, tcResetEn, tcPresetEn, tcLoadEn;
	`endif;
	
	`ifdef UART_peripheral
	output uartRead, uartWrite;
	`endif
							
	`ifdef SPI_peripheral
	output sconEn, spiStatRead, spiBufRead, spiBufWrite, spiBufShift;
	`endif
							



endmodule
