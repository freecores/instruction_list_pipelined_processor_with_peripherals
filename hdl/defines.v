// 16-bit process controller defines
// 16-bit process controller defines

`define		immDataLen			8

// program counter & instruction register
`define		instLen				15			// 15-bit fixed-length instructions
`define		instOpCodeLen		5
`define		instFieldLen		10


// control unit
`define		cuStateLen			4		// max 16 states
`define		END					`instOpCodeLen'b0
`define		JMP					`instOpCodeLen'b1
`define		Ld						`instOpCodeLen'b10
`define		Ldi					`instOpCodeLen'b11
`define		ST						`instOpCodeLen'b100
`define		ADD					`instOpCodeLen'b101
`define		SUB					`instOpCodeLen'b110
`define		MUL					`instOpCodeLen'b111
`define		DIV					`instOpCodeLen'b1000
`define		AND					`instOpCodeLen'b1001
`define		OR						`instOpCodeLen'b1010
`define		XOR					`instOpCodeLen'b1011
`define		GrT					`instOpCodeLen'b1100
`define		GE						`instOpCodeLen'b1101
`define		EQ						`instOpCodeLen'b1110
`define		LE						`instOpCodeLen'b1111
`define		LT						`instOpCodeLen'b10000
`define		PRE					`instOpCodeLen'b10001
`define		ETY					`instOpCodeLen'b10010
`define		RST					`instOpCodeLen'b10011
`define		LdTC					`instOpCodeLen'b10100
`define		LdACC					`instOpCodeLen'b10101
`define		UARTrd				`instOpCodeLen'b10110
`define		UARTwr				`instOpCodeLen'b10111
`define		SPIxFER				`instOpCodeLen'b11000
`define		SPIstat				`instOpCodeLen'b11001
`define		SPIwBUF				`instOpCodeLen'b11010
`define		SPIrBUF				`instOpCodeLen'b11011

// alu opcodes
`define		aluOpcodeLen		4
`define		AND_alu				`aluOpcodeLen'b0
`define		OR_alu				`aluOpcodeLen'b1
`define		XOR_alu				`aluOpcodeLen'b10
`define		GT_alu				`aluOpcodeLen'b11
`define		GE_alu				`aluOpcodeLen'b100
`define		EQ_alu				`aluOpcodeLen'b101
`define		LE_alu				`aluOpcodeLen'b110
`define		LT_alu				`aluOpcodeLen'b111
`define		ADD_alu				`aluOpcodeLen'b1000
`define		SUB_alu				`aluOpcodeLen'b1001
`define		MUL_alu				`aluOpcodeLen'b1010
`define		DIV_alu				`aluOpcodeLen'b1011
`define		LD_data				`aluOpcodeLen'b1100

// bit RAM
`define		bitRamAddrLen		7		// 7-bit address
`define		bitRamDepth			128	// 2^7 = 128 locations

// byte RAM
`define		byteRamLen			8		// 8-bit input
`define		byteRamAddrLen		7		// 7-bit address
`define		byteRamDepth		128	// 2^7 = 128 locations

// input register
`define		inputNumber			128	// 128 inputs
`define		inputAddrLen		7		// 7-bit address

// output register
`define		outputNumber		128	// 128 outputs
`define		outputAddrLen		7		// 7-bit address

// accumulator multiplexer
`define		accMuxSelLen			4		// 2^4 = 16 selections available for accumulator
`define		accMuxSelImmData		`accMuxSelLen'b0
`define		accMuxSelAluOut		`accMuxSelLen'b1
`define		accMuxSelTcLoad		`accMuxSelLen'b10
`define		accMuxSelTcAcc			`accMuxSelLen'b11
`define		accMuxSelUart			`accMuxSelLen'b100
`define		accMuxSelSpiStat		`accMuxSelLen'b101
`define		accMuxSelSpiBuf		`accMuxSelLen'b110

// operand2 multiplexer
`define		op2MuxSelLen			4		// 2^4 = 16 selections available for op2
`define		op2MuxSelInput			`op2MuxSelLen'b0
`define		op2MuxSelOutput		`op2MuxSelLen'b1
`define		op2MuxSelBitRam		`op2MuxSelLen'b10
`define		op2MuxSelByteRam		`op2MuxSelLen'b11
`define		op2MuxSel4			`op2MuxSelLen'b100
`define		op2MuxSel5			`op2MuxSelLen'b101
`define		op2MuxSel6			`op2MuxSelLen'b110

//-----------------------------------------------------------------------------------------------------

// peripheral defines
`define		timerAndCounter_peripheral
`define		UART_peripheral
`define		SPI_peripheral


//-----------------------------------------------------------------------------------------------------

// Timer-Counter
`define		tcAccLen				8		// 8-bit accumulated value
`define		tcPresetLen			8		// 8-bit preset value
`define		tcAddrLen			4
`define		tcTypeLen			2		// max 4-types
`define		tcNumbers			16		// total 16 modules (8-timers, 8-counters)

`define		timerType1			`tcTypeLen'b0
`define		timerType2			`tcTypeLen'b1
`define		timerType3			`tcTypeLen'b10

`define		counterType1		`tcTypeLen'b1
`define		counterType2		`tcTypeLen'b10


//-----------------------------------------------------------------------------------------------------

// UART
`define		dataBits 			8
`define		sbTick 				16	// ticks for stop bits (16 for 1-stopBit)
`define		fifoWidth 			4
`define 		number_fifo_regs 	16
`define 		fifoCntrWidth 		5
`define 		fifoDepth 			16
