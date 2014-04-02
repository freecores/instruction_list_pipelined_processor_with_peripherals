`include "timescale.v"
`include "defines.v"

module top(clk, reset, IN, OUT

				`ifdef UART_peripheral
					, rx, tx
				`endif
				
				`ifdef SPI_peripheral
					, MISO, MOSI, SCK
				`endif				
				
				);



	input	clk,reset;
	input [`inputNumber-1:0] IN;
	output [`outputNumber-1:0] OUT;
	
	`ifdef UART_peripheral
	input rx;
	output tx;
	`endif
	
	`ifdef SPI_peripheral
	input MISO;
	output MOSI, SCK;
	`endif

// wires (interconnects) of execution unit

	wire	[`instLen-1:0]			pcOut;
	wire	[`instOpCodeLen+`instFieldLen-1:0] romOut;
	wire	[`instOpCodeLen-1:0]	instOpCode;
	wire	[`instFieldLen-1:0] 	instField;
	
	wire	[7:0]		accMuxOut;
	wire	[7:0]		accOut;
	wire	[7:0]		op2MuxOut;
	wire	[7:0]		aluOut;
	
	wire	bitNegatorRamOut, bitOut;
	wire	[7:0]	byteNegatorRamOut, byteOut;
	
	wire	inputReadOutData, outputReadOut;
	
	wire branchOutc;
	wire [`accMuxSelLen-1:0]	accMuxSelOutc;
	wire accEnOutc;
	wire [`op2MuxSelLen-1:0]	op2MuxSelOutc;
	wire [`aluOpcodeLen-1:0] aluOpcodeOutc;
	wire bitRamEnOutc, bitRamRwOutc, byteRamEnOutc, byteRamRwOutc;
	wire inputReadOutc, outputRwOutc;
	`ifdef timerAndCounter_peripheral
	wire entypeEnOutc, tcAccReadOutc, tcResetEnOutc, tcPresetEnOutc, tcLoadEnOutc;
	`endif
	`ifdef UART_peripheral
	wire uartReadOutc, uartWriteOutc;
	`endif
	`ifdef SPI_peripheral
	wire sconEnOutc, spiStatReadOutc, spiBufReadOutc, spiBufWriteOutc, spiBufShiftOutc;
	`endif

	wire branchOut;
	wire [`accMuxSelLen-1:0]	accMuxSelOut;
	wire accEnOut;
	wire [`op2MuxSelLen-1:0]	op2MuxSelOut;
	wire [`aluOpcodeLen-1:0] aluOpcodeOut;
	wire bitRamEnOut, bitRamRwOut, byteRamEnOut, byteRamRwOut;
	wire inputReadOut, outputRwOut;
	`ifdef timerAndCounter_peripheral
	wire entypeEnOut, tcAccReadOut, tcResetEnOut, tcPresetEnOut, tcLoadEnOut;
	`endif
	`ifdef UART_peripheral
	wire uartReadOut, uartWriteOut;
	`endif
	`ifdef SPI_peripheral
	wire sconEnOut, spiStatReadOut, spiBufReadOut, spiBufWriteOut, spiBufShiftOut;
	`endif

	
	
// wires (interconnects) of timer & counter

`ifdef timerAndCounter_peripheral

	wire	[(`tcNumbers*`tcPresetLen)-1:0] presetWires;
	wire	[7:0] tcAccumOut;
	wire	[7:0] tcLoadOut;
	wire [`tcNumbers-1:0] enWires;
	wire [`tcNumbers-1:0] resetWires;
	wire [`tcNumbers-1:0] dnWires, ttWires, cuWires, cdWires;
	wire [(`tcNumbers*2)-1:0] typeWires;
	wire [(`tcNumbers*`tcAccLen)-1:0] tcAccWires;

`endif

// wires (interconnects) of UART

	`ifdef UART_peripheral
	
		
		
	`endif
	
// wires (interconnects) of SPI

	`ifdef SPI_peripheral
	
	`endif


	

//-------- Fetch Unit Module Instances
// all necessary

	pgmCounter		ProgramCounter (clk, reset, branchOutc, instField[7:0], pcOut);
	
	
// instruction ROM is declared using xilinx primitive
	RAMB16_S18 rom ( .DI(),
				 .DIP(),
				 .ADDR(pcOut),
				 .EN(1'b1),
				 .WE(),   
				 .SSR(1'b0),
				 .CLK(clk),
				 .DO(romOut),
				 .DOP());

	instReg			IntructionRegister (romOut, instOpCode, instField);


// pipeline register

	wire	[`instOpCodeLen-1:0] instOpCode1;
	wire	[`instFieldLen-1:0] instField1;
	wire	[`instFieldLen-1:0] instField2;
	
	ppReg1	PipeLine_Reg1 (clk, instOpcode, instField, instOpcode1, instField1);


//-------- Control Unit Module Instance

	controlUnit		CONTROL_UNIT (clk, reset, instOpCode1, accOut[0], instField2[8:7],
											branchc,
											accMuxSelc, accEnc, op2MuxSelc, aluOpcodec,
											bitRamEnc, bitRamRwc, byteRamEnc, byteRamRwc,
											inputReadc, outputRwc
											
											`ifdef timerAndCounter_peripheral
												, entypeEnc, tcAccReadc, tcResetEnc, tcPresetEnc, tcLoadEnc
											`endif
											
											`ifdef UART_peripheral
												, uartReadc, uartWritec
											`endif
											
											`ifdef SPI_peripheral
												, sconEnc, spiStatReadc, spiBufReadc, spiBufWritec, spiBufShiftc
											`endif
											
											);



// pipeline register

	

	ppReg2	PipeLine_Reg2 (clk,
									branchOutc,
									accMuxSelOutc, accEnOutc, op2MuxSelOutc, aluOpcodeOutc, bitRamEnOutc,
									bitRamRwOutc, byteRamEnOutc, byteRamRwOutc, inputReadOutc, outputRwOutc
								`ifdef timerAndCounter_peripheral
								, entypeEnOutc, tcAccReadOutc, tcResetEnOutc, tcPresetEnOutc, tcLoadEnOutc
								`endif
								`ifdef UART_peripheral
								, uartReadOutc, uartWriteOutcc
								`endif
								`ifdef SPI_peripheral
								, sconEnOutc, spiStatReadOutc, spiBufReadOutc, spiBufWriteOutc, spiBufShiftOutc
								`endif
								, instField1
									
									, branchOut,
									accMuxSelOut, accEnOut, op2MuxSelOut, aluOpcodeOut,
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
									
									, instField2
								);


//-------- Execute Unit Modules Instances
// all necessary


	
	
	accumulatorMUX		accMUX1	(accMuxSelOut, instField2[7:0], aluOut 
										`ifdef timerAndCounter_peripheral
										, tcLoadOut, tcAccOut
										`endif
										`ifdef UART_peripheral
										, uartDataOut
										`endif
										`ifdef SPI_peripheral
										, spiStatOut, spiBufOut
										`endif
										, accMuxOut
										);

	
	accumulator			acc		(accMuxOut, accEnOut, accOut);

	op2Mux				op2MUX1	(op2MuxSelOut, inputReadOutData, outputReadOut, bitOut, byteOut, op2MuxOut);
	
	wire [7:0] op2Out;
	
	byteNegator			byteNegatorForOp2Mux (op2MuxOut, instField2[9], op2Out);
	
	alu					arithLogicUnit	(aluOpcodeOut, accOut, op2Out, aluOut, carryOut);
	
	wire bitIn;
	
	bitNegator			bitNegatorForBitRam	(accOut[0], instField2[9], bitIn);
	
	bitRam				RAM_Bit	(clk, reset, bitRamEnOut, bitRamRwOut, bitIn, instField2[6:0], bitOut);
	
	wire [7:0] byteIn;
	
	byteNegator			byteNegatorForByteRam	(accOut, instField2[9], byteIn);
	
	byteRam				RAM_Byte	(clk, reset, byteRamEnOut, byteRamRwOut, byteIn, instField2[6:0], byteOut);
	
	inputRegister		inputStorage	(reset, IN, inputReadOut, instField2[6:0], inputReadOutData);
	
	outputReg			outputStorage	(reset, outputRwOut, instField2[6:0], accOut[0], outputReadOut, OUT);
	

//---------- Timer & Counter Modules
// optional

`ifdef timerAndCounter_peripheral




	tcEnableAndType	tcEnableAndTypeModule(entypeEnOut, instField2[6], instField2[5:4], instField2[3:0], enWires, typeWires);
	
	tcAccum				tcAccumModule(tcAccumReadOut, instField2[3:0], tcAccumWires, tcAccOut);
	
	tcReset				tcResetModule(tcResetEnOut, instField2[4], instField2[3:0], resetWires);
	
	tcPreset				tcPresetModule(tcPresetEnOut, accOut, instField2[3:0], presetWires);
	
	tcLoad				tcLoadModule(tcLoadEnOut, instField2[3:0], dnWires, ttWires, cuWires, cdWires, tcLoadOut);
	
	timer					timer0	(clk, enWires[0], resetWires[0], typeWires[1:0], presetWires[7:0], dnWires[0], ttWires[0], tcAccWires[7:0]);
	
	timer					timer1	(clk, enWires[1], resetWires[1], typeWires[3:2], presetWires[15:8], dnWires[1], ttWires[1], tcAccWires[15:8]);
	
	timer					timer2	(clk, enWires[2], resetWires[2], typeWires[5:4], presetWires[23:16], dnWires[2], ttWires[2], tcAccWires[23:16]);
	
	timer					timer3	(clk, enWires[3], resetWires[3], typeWires[7:6], presetWires[31:24], dnWires[3], ttWires[3], tcAccWires[31:24]);
	
	counter				counter0	(enWires[4], resetWires[4], presetWires[39:32], typeWires[9:8], dnWires[4], cuWires[0], cdWires[0], tcAccWires[39:32]);
	
	counter				counter1	(enWires[5], resetWires[5], presetWires[47:40], typeWires[11:10], dnWires[5], cuWires[1], cdWires[1], tcAccWires[47:40]);
	
	counter				counter2	(enWires[6], resetWires[6], presetWires[55:48], typeWires[13:12], dnWires[6], cuWires[2], cdWires[2], tcAccWires[55:48]);
	
	counter				counter3	(enWires[7], resetWires[7], presetWires[63:56], typeWires[15:14], dnWires[7], cuWires[3], cdWires[3], tcAccWires[63:56]);

`endif

//---------- UART Modules
// optional

`ifdef UART_peripheral

	wire	brgOut;
	wire txDoneTick, txStart;
	wire rxDoneTick;
	wire [7:0] recFifoData, transFifoData;
	

	uartTrans	UART_TRANSMITTER (clk, reset, brgOut, txDoneTick, transFifoData, tx, ~txStart);
	
	uartRec		UART_RECIEVER (clk, reset, brgOut, rx, rxDoneTick, recFifoData);
	
	uartBrg		UART_BitRateGenerator (.clk(clk), .reset(reset), .outp(brgOut));
	
	uartFifo		UART_TRANS_FIFO (clk, reset, accOut, transFifoData, uartWriteOut, txDoneTick, txFull, txStart);
	
	uartFifo		UART_REC_FIFO (clk, reset, recFifoData, uartDataOut, rxDoneTick, uartReadOut, rxFull, rxEmpty);

`endif

//---------- SPI Modules
// optional

`ifdef SPI_peripheral

	spiStatReg	SPI_STATUS_REG ();
	
	spiConReg	SPI_CONTROL_REG ();
	
	spiBufReg	SPI_BUFFER_REG ();
	
	spiEngine	SPI_MAIN	();
	
`endif
	
endmodule
