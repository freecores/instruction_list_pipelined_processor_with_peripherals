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
	wire	[`instOpCodeLen-1:0]	instOpCode;
	wire	[`instFieldLen-1:0] 	instField;
	
	wire	[7:0]		accMuxOut;
	wire	[7:0]		accOut;
	wire	[7:0]		op2MuxOut;
	wire	[7:0]		aluOut;
	
	wire	bitNegatorRamOut, bitOut;
	wire	[7:0]	byteNegatorRamOut, byteOut;
	
	wire	inputReadOut, outputReadOut;
	
// wires (interconnects) of timer & counter

	`ifdef timerAndCounter_peripheral
	
	`endif

	

//-------- Fetch Unit Module Instances
// all necessary

	pgmCounter		ProgramCounter ();
	
	instReg			IntructionRegister ();
	

// instruction ROM is declared using xilinx primitive
	RAMB16_S18 rom ( .DI(),
				 .DIP(),
				 .ADDR(),
				 .EN(1'b1),
				 .WE(),   
				 .SSR(1'b0),
				 .CLK(),
				 .DO(),
				 .DOP());



//-------- Execute Unit Modules Instances
// all necessary


	
	
	accumulatorMUX		accMUX1	();
	
	accumulator			acc		();

	byteNegator			byteNegatorForOp2Mux ();
	
	op2Mux				op2MUX1	();
	
	alu					arithLogicUnit	();
	
	bitNegator			bitNegatorForBitRam	();
	
	bitRam				RAM_Bit	();
	
	byteNegator			byteNegatorForByteRam	();
	
	byteRam				RAM_Byte	();
	
	inputRegister		inputStorage	();
	
	outputReg			outputStorage	();
	

//---------- Timer & Counter Modules
// optional

`ifdef timerAndCounter_peripheral

	tcEnableAndType	tcEnableAndTypeModule();
	
	tcAccum				tcAccumModule();
	
	tcReset				tcResetModule();
	
	tcPreset				tcPresetModule();
	
	tcLoad				tcLoadModule();
	
	timer					timer0();
	
	timer					timer1();
	
	timer					timer2();
	
	timer					timer3();
	
	counter				counter0();
	
	counter				counter1();
	
	counter				counter2();
	
	counter				counter3();

`endif

//---------- UART Modules
// optional

`ifdef UART_peripheral


	uartTrans	UART_TRANSMITTER ();
	
	uartRec		UART_RECIEVER ();
	
	uartBrg		UART_BitRateGenerator ();
	
	uartFifo		UART_TRANS_FIFO ();
	
	uartFifo		UART_REC_FIFO ();
	
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
