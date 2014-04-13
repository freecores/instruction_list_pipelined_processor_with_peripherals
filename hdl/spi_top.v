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


module spi_top(clk, sconEN, statREAD, sconIN, statOUT, wrBUF, rdBUF, bufIN, bufOUT, MI, MO, SCK);

		input clk, MI, sconEN, statREAD, wrBUF, rdBUF;
		input [7:0] sconIN, bufIN;
		
		output MO, SCK;
		output [7:0] statOUT, bufOUT;
		
		
		wire BF;
		
		wire [7:0] sconOUT, bufOUT, bufregIN;
		
		wire [7:0] buffer_out8;
		
		
spiStatReg STATUS_REG (BF, statREAD, statOUT);


spiConReg CONTROL_REG (sconEN, sconIN, sconOUT);


spiBufReg BUFFER_REG (rdBUF, bufregIN, bufOUT);


spiEngine ENGINE (bufIN, bufregIN, clk, MI, MO, SCK, wrBUF, sconOUT[7], sconOUT[0], BF);

endmodule
