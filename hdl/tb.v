
`include "timescale.v"
`include "defines.v"


module tb;

	reg clk, reset;
	reg [`inputNumber-1:0] IN;
	
	wire [`outputNumber-1:0] OUT;
	
	`ifdef UART_peripheral
	reg rx;
	wire tx;
	`endif
	
	`ifdef SPI_peripheral
	reg MISO;
	wire MOSI, SCK;
	`endif
	
	top	DUT(clk, reset, IN, OUT

				`ifdef UART_peripheral
					, rx, tx
				`endif
				
				`ifdef SPI_peripheral
					, MISO, MOSI, SCK
				`endif				
				
				);
	
	initial
	clk = 0;
	
	always
	#10	clk = ~clk;
	
	initial
	reset = 1'b1;
	
	initial
	#50	reset = 0;
	
	initial
	begin
			IN = 0;
			rx = 0;
			MISO = 0;
	end
	

endmodule
