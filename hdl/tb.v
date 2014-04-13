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
