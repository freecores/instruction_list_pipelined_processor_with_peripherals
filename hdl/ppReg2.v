////////////////////////////////////////////////////////////////////////////////////////////////
////                                                              							////
////                                                              							////
////  	This file is part of the project                 									////
////	"instruction_list_pipelined_processor_with_peripherals"								////
////                                                              							////
////  http://opencores.org/project,instruction_list_pipelined_processor_with_peripherals	////
////                                                              							////
////                                                              							////
//// 				 Author:                                                  				////
////      			- Mahesh Sukhdeo Palve													////
////																						////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////																						////
//// 											                 							////
////                                                              							////
//// 					This source file may be used and distributed without         		////
//// 					restriction provided that this copyright statement is not    		////
//// 					removed from the file and that any derivative work contains  		////
//// 					the original copyright notice and the associated disclaimer. 		////
////                                                              							////
//// 					This source file is free software; you can redistribute it   		////
//// 					and/or modify it under the terms of the GNU Lesser General   		////
//// 					Public License as published by the Free Software Foundation; 		////
////					either version 2.1 of the License, or (at your option) any   		////
//// 					later version.                                               		////
////                                                             							////
//// 					This source is distributed in the hope that it will be       		////
//// 					useful, but WITHOUT ANY WARRANTY; without even the implied   		////
//// 					warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      		////
//// 					PURPOSE.  See the GNU Lesser General Public License for more 		////
//// 					details.                                                     		////
////                                                              							////
//// 					You should have received a copy of the GNU Lesser General    		////
//// 					Public License along with this source; if not, download it   		////
//// 					from http://www.opencores.org/lgpl.shtml                     		////
////                                                              							////
////////////////////////////////////////////////////////////////////////////////////////////////

`include "timescale.v"
`include "defines.v"


module ppReg2 (clk,
					branchIn,
					accMuxSelIn, accEnIn, op2MuxSelIn, aluEnIn, aluOpcodeIn,
					bitRamEnIn, bitRamRwIn, byteRamEnIn, byteRamRwIn,
					inputReadIn, outputRwIn
					
					`ifdef timerAndCounter_peripheral
						, entypeEnIn, tcAccReadIn, tcResetEnIn, tcPresetEnIn, tcLoadEnIn
					`endif
					
					`ifdef UART_peripheral
						, uartReadIn, uartWriteIn
					`endif
					
					`ifdef SPI_peripheral
						, sconEnIn, spiStatReadIn, spiBufReadIn, spiBufWriteIn, spiBufShiftIn
					`endif
					, fieldIn
					, branchOut,
					accMuxSelOut, accEnOut, op2MuxSelOut, aluEnOut, aluOpcodeOut,
					bitRamEnOut, bitRamRwOut, byteRamEnOut, byteRamRwOut,
					inputReadOut, outputRwOut
					
					`ifdef timerAndCounter_peripheral
						, entypeEnOut, tcAccReadOut, tcResetEnOut, tcPresetEnOut, tcLoadEnOut
					`endif
					
					`ifdef UART_peripheral
						, uartReadOut, uartWriteOut
					`endif
					
					`ifdef SPI_peripheral
						, sconEnOut, spiStatReadOut, spiBufReadOut, spiBufWriteOut, spiBufShiftOut
					`endif
					
					, fieldOut
					);

	input clk;
	
	input branchIn;
	input [`accMuxSelLen-1:0]	accMuxSelIn;
	input accEnIn;
	input [`op2MuxSelLen-1:0]	op2MuxSelIn;
	input aluEnIn;
	input [`aluOpcodeLen-1:0] aluOpcodeIn;
	input bitRamEnIn, bitRamRwIn, byteRamEnIn, byteRamRwIn;
	input inputReadIn, outputRwIn;
	`ifdef timerAndCounter_peripheral
	input entypeEnIn, tcAccReadIn, tcResetEnIn, tcPresetEnIn, tcLoadEnIn;
	`endif
	`ifdef UART_peripheral
	input uartReadIn, uartWriteIn;
	`endif
	`ifdef SPI_peripheral
	input sconEnIn, spiStatReadIn, spiBufReadIn, spiBufWriteIn, spiBufShiftIn;
	`endif
	input [`instFieldLen-1:0] fieldIn;

	
	output branchOut;
	output [`accMuxSelLen-1:0]	accMuxSelOut;
	output accEnOut;
	output [`op2MuxSelLen-1:0]	op2MuxSelOut;
	output aluEnOut;
	output [`aluOpcodeLen-1:0] aluOpcodeOut;
	output bitRamEnOut, bitRamRwOut, byteRamEnOut, byteRamRwOut;
	output inputReadOut, outputRwOut;
	`ifdef timerAndCounter_peripheral
	output entypeEnOut, tcAccReadOut, tcResetEnOut, tcPresetEnOut, tcLoadEnOut;
	`endif
	`ifdef UART_peripheral
	output uartReadOut, uartWriteOut;
	`endif
	`ifdef SPI_peripheral
	output sconEnOut, spiStatReadOut, spiBufReadOut, spiBufWriteOut, spiBufShiftOut;
	`endif
	
	output [`instFieldLen-1:0] fieldOut;
	
	reg branchOut;
	reg [`accMuxSelLen-1:0]	accMuxSelOut;
	reg accEnOut;
	reg [`op2MuxSelLen-1:0]	op2MuxSelOut;
	reg aluEnOut;
	reg [`aluOpcodeLen-1:0] aluOpcodeOut;
	reg bitRamEnOut, bitRamRwOut, byteRamEnOut, byteRamRwOut;
	reg inputReadOut, outputRwOut;
	`ifdef timerAndCounter_peripheral
	reg entypeEnOut, tcAccReadOut, tcResetEnOut, tcPresetEnOut, tcLoadEnOut;
	`endif
	`ifdef UART_peripheral
	reg uartReadOut, uartWriteOut;
	`endif
	`ifdef SPI_peripheral
	reg sconEnOut, spiStatReadOut, spiBufReadOut, spiBufWriteOut, spiBufShiftOut;
	`endif

	reg [`instFieldLen-1:0] fieldOut;



	always @ (posedge clk)
	begin
	
	fieldOut = fieldIn;
	
	branchOut = branchIn;
	accMuxSelOut = accMuxSelIn;
	accEnOut = accEnIn;
	op2MuxSelOut = op2MuxSelIn;
	aluEnOut = aluEnIn;
	aluOpcodeOut = aluOpcodeIn;
	bitRamEnOut = bitRamEnIn;
	bitRamRwOut = bitRamRwIn;
	byteRamEnOut = byteRamEnIn;
	byteRamRwOut = byteRamRwIn;
	inputReadOut = inputReadIn;
	outputRwOut = outputRwIn;
	
	`ifdef timerAndCounter_peripheral

	entypeEnOut = entypeEnIn;
	tcAccReadOut = tcAccReadIn;
	tcResetEnOut = tcResetEnIn;
	tcPresetEnOut = tcPresetEnIn;
	tcLoadEnOut = tcLoadEnIn;

	`endif


	`ifdef UART_peripheral

	uartReadOut = uartReadIn;
	uartWriteOut = uartWriteIn;

	`endif


	`ifdef SPI_peripheral
	
	sconEnOut = sconEnIn;
	spiStatReadOut = spiStatReadIn;
	spiBufReadOut = spiBufReadIn;
	spiBufWriteOut = spiBufWriteIn;
	spiBufShiftOut = spiBufShiftIn;
	
	`endif
	
	end


endmodule
