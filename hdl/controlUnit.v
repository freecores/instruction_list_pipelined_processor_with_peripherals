
`include "timescale.v"
`include "defines.v"


module controlUnit (clk, reset, instOpCode, acc0, iomemCode,
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
	`endif
	
	`ifdef UART_peripheral
	output uartRead, uartWrite;
	`endif
							
	`ifdef SPI_peripheral
	output sconEn, spiStatRead, spiBufRead, spiBufWrite, spiBufShift;
	`endif

	reg branch;
	reg [`accMuxSelLen-1:0]	accMuxSel;
	reg accEn;
	reg [`op2MuxSelLen-1:0]	op2MuxSel;
	reg [`aluOpcodeLen-1:0] aluOpcode;
	reg bitRamEn, bitRamRw, byteRamEn, byteRamRw;
	reg inputRead, outputRw;
	
	`ifdef timerAndCounter_peripheral
	reg entypeEn, tcAccRead, tcResetEn, tcPresetEn, tcLoadEn;
	`endif
	
	`ifdef UART_peripheral
	reg uartRead, uartWrite;
	`endif
							
	`ifdef SPI_peripheral
	reg sconEn, spiStatRead, spiBufRead, spiBufWrite, spiBufShift;
	`endif
	
	reg [`cuStateLen-1:0] state;
	
	// control unit FSM states:
	
	parameter	s		= `cuStateLen'b0;
	parameter	sTc	= `cuStateLen'b1;
	parameter	sBr	= `cuStateLen'b10;
	parameter	sLd	= `cuStateLen'b11;
	parameter	sSt	= `cuStateLen'b100;
	parameter	sUart	= `cuStateLen'b101;
	parameter	sSpi	= `cuStateLen'b110;
	parameter	sAlu	= `cuStateLen'b111;
	
	
	
	
	always @ (negedge clk)
	begin
	
	
		if (reset)
		begin
			state = s;
			
			branch = 0;	accMuxSel = 0;	accEn = 0;	op2MuxSel = 0;	aluOpcode = 0;	bitRamEn = 0;
			bitRamRw = 1;	byteRamEn = 0;	byteRamRw = 1;	inputRead = 0;	outputRw = 1;
			
			`ifdef timeAndCounter_peripheral
				entypeEn = 0;	tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
			`endif
			
			`ifdef UART_peripheral
				uartRead = 0;	uartWrite = 0;
			`endif
			
			`ifdef SPI_peripheral
				sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
			`endif			
		end
		
		else
		begin
			
			// execution unit control signals
			
			case (state)
			
			s		:		begin
			

				case (instOpCode)
				
				`END			:	begin
				
						state = sBr;
						
						branch = 1;			// branch to some address . . .
						accMuxSel = 0;
						accEn = 0;
						op2MuxSel = 0;
						aluOpcode = 0;
						bitRamEn = 0;
						bitRamRw = 1;
						byteRamEn = 0;
						byteRamRw = 1;
						inputRead = 0;
						outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;
							spiBufShift = 0;
						`endif
				
				end	// end case END



				`JMP			:	begin
				
						state = sBr;
						
						branch = 1;			// branch to some address . . .
						accMuxSel = 0;
						accEn = 0;
						op2MuxSel = 0;
						aluOpcode = 0;
						bitRamEn = 0;
						bitRamRw = 1;
						byteRamEn = 0;
						byteRamRw = 1;
						inputRead = 0;
						outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end	// end case JMP



				`Ld			:	begin
				// load thr. op2 MUX and alu.... enable acc in next cycle
						state = sLd;
						
						branch = 0;
						accMuxSel = 0;
						accEn = 0;
							
							case (iomemCode)
							2'b00	:	op2MuxSel = `op2MuxSelInput;
							2'b01	:	op2MuxSel = `op2MuxSelOutput;
							2'b10	:	op2MuxSel = `op2MuxSelBitRam;
							2'b11	:	op2MuxSel = `op2MuxSelByteRam;
							default:	op2MuxSel = `op2MuxSelInput;
							endcase
							
							aluOpcode = `LD_data;
							
						bitRamEn = 0;
						bitRamRw = 1;
						byteRamEn = 0;
						byteRamRw = 1;
						inputRead = 0;
						outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end	// end case Ld
				
				
				
				
				`Ldi			:	begin
						state = sAlu;
						
						branch = 0;
							accMuxSel = `accMuxSelImmData;	// select imm data thr mux
							accEn = 1;		// acc enabled
						op2MuxSel = 0;							
						aluOpcode = 0;
						bitRamEn = 0;
						bitRamRw = 1;
						byteRamEn = 0;
						byteRamRw = 1;
						inputRead = 0;
						outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end		// end case Ldi
				
				
				
				`ST			:	begin
						state = sSt;
						
						branch = 0;
						accMuxSel = 0;
						accEn = 0;
						op2MuxSel = 0;							
						aluOpcode = 0;
						bitRamRw = 0;
						byteRamRw = 0;
						inputRead = 0;

							case (iomemCode)
							2'b01	:	begin	bitRamRw = 0;	byteRamRw = 1;	outputRw = 1; end
							2'b10	:	begin	bitRamRw = 1;	byteRamRw = 0;	outputRw = 1; end
							2'b11	:	begin	bitRamRw = 1;	byteRamRw = 1;	outputRw = 0; end
							default:	begin	bitRamRw = 1;	byteRamRw = 1;	outputRw = 1;	end
							endcase
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif

				end
				
				
				
				`ADD			:	begin
						state = sAlu;
						aluOpcode = `ADD_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				
				`SUB			:	begin
						state = sAlu;
						aluOpcode = `SUB_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				// MUL & DIV are not implemented
				
				
				
				`AND			:	begin
						state = sAlu;
						aluOpcode = `AND_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				
				
				`OR			:	begin
						state = sAlu;
						aluOpcode = `OR_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				


				`XOR			:	begin
						state = sAlu;
						aluOpcode = `XOR_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				


				`GrT			:	begin
						state = sAlu;
						aluOpcode = `GT_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				
				


				`GE			:	begin
						state = sAlu;
						aluOpcode = `GE_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				
				


				`EQ			:	begin
						state = sAlu;
						aluOpcode = `EQ_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				
				


				`LE			:	begin
						state = sAlu;
						aluOpcode = `LE_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				
				


				`LT			:	begin
						state = sAlu;
						aluOpcode = `LT_alu;
						
						branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timeAndCounter_peripheral
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				
				end
				
				
				`ifdef timeAndCounter_peripheral
				`PRE			:	begin
						state = sTc;
						
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 1;	tcLoadEn = 0;
						
						
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				end
				`endif
		

				`ifdef timeAndCounter_peripheral
				`ETY			:	begin
						state = sTc;
						
						entypeEn = 1;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						
						
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				end
				`endif



				`ifdef timeAndCounter_peripheral
				`RST			:	begin
						state = sTc;
						
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 1;		tcPresetEn = 0;	tcLoadEn = 0;
						
						
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				end
				`endif



				`ifdef timeAndCounter_peripheral
				`LdTC			:	begin
						state = sTc;
						
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 1;
						
						accMuxSel = `accMuxSelTcLoad;		accEn = 1;	// loading TC status data
						
						aluOpcode = 0;		branch = 0;			op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				end
				`endif



				`ifdef timeAndCounter_peripheral
				`LdACC			:	begin
						state = sTc;
						
						entypeEn = 0;		tcAccRead = 1;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						
						accMuxSel = `accMuxSelTcAcc;		accEn = 1;	// loading TC ACC data
						
						aluOpcode = 0;		branch = 0;		op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						
						`ifdef UART_peripheral
							uartRead = 0;		uartWrite = 0;
						`endif
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				end
				`endif




				`ifdef UART_peripheral
				`UARTrd			:	begin
						state = sUart;
						
						uartRead = 1;		uartWrite = 0;
						
						accMuxSel = `accMuxSelUart;		accEn = 1;	// loading UART data
						
						aluOpcode = 0;		branch = 0;op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timerAndCounter_peripheral
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				end
				`endif




				`ifdef UART_peripheral
				`UARTwr			:	begin
						state = sUart;
						
						uartRead = 0;		uartWrite = 1;
						
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timerAndCounter_peripheral
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						
						`ifdef SPI_peripheral
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
						`endif
				end
				`endif




				`ifdef SPI_peripheral
				`SPIxFER			:	begin
						state = sSpi;
										
						sconEn = 1;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;						
	
	
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timerAndCounter_peripheral
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
						uartRead = 0;		uartWrite = 0;
						`endif
						
				end
				`endif



				`ifdef SPI_peripheral
				`SPIstat			:	begin
						state = sSpi;
										
						sconEn = 0;		spiStatRead = 1;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;						
	
	
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timerAndCounter_peripheral
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
						uartRead = 0;		uartWrite = 0;
						`endif
						
				end
				`endif



				`ifdef SPI_peripheral
				`SPIwBUF			:	begin
						state = sSpi;
										
						sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 1;	spiBufShift = 0;						
	
	
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timerAndCounter_peripheral
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
						uartRead = 0;		uartWrite = 0;
						`endif
						
				end
				`endif



				`ifdef SPI_peripheral
				`SPIrBUF			:	begin
						state = sSpi;
										
						sconEn = 0;		spiStatRead = 0;	spiBufRead = 1;	spiBufWrite = 0;	spiBufShift = 0;						
	
	
						aluOpcode = 0;		branch = 0;		accMuxSel = 0;		accEn = 0;	op2MuxSel = 0;
						bitRamEn = 0;	bitRamRw = 1;	byteRamEn = 0;		byteRamRw = 1;		inputRead = 0;		outputRw = 1;
						
						`ifdef timerAndCounter_peripheral
						entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
						`endif
						
						`ifdef UART_peripheral
						uartRead = 0;		uartWrite = 0;
						`endif
						
				end
				`endif

				default		:	begin
				
				$write ("	unknown/unused instruction op-code encountered by control unit	");
				$stop;
				end
				endcase	// end 	case (instOpCode)
			
			
				
			end	// end case (s)
			
			
			sBr		:	begin
							branch = 0;
							state = s;
							end		// end case sBr
			
			
			sLd		:	begin
							accEn = 0;
							state = s;
							end		// end case sLd
							
			sSt		:	begin
							bitRamRw = 1;	byteRamRw = 1; outputRw = 1;
							state = s;
							end
							
			sAlu		:	begin
							accEn = 1;
							accMuxSel = `accMuxSelAluOut;
							state = s;
							end
							
			`ifdef timerAndCounter_peripheral
			sTc		:	begin
							entypeEn = 0;		tcAccRead = 0;	tcResetEn = 0;		tcPresetEn = 0;	tcLoadEn = 0;
							state = s;
							end
			`endif

			`ifdef UART_peripheral
			sUart		:	begin
							uartRead = 0;		uartWrite = 0;
							state = s;
							end
			`endif

			`ifdef SPI_peripheral
			sSpi		:	begin
							sconEn = 0;		spiStatRead = 0;	spiBufRead = 0;	spiBufWrite = 0;	spiBufShift = 0;
							state = s;
							end
			`endif
			
			default		:	begin
			$write ("	control unit FSM in unknown state.	");
			end
			endcase	// end 	case (state)
		end	// end else part (outermost)
			
		
	
	end	// end always
	
	
endmodule
