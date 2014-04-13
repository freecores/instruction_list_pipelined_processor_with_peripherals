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


module tcLoad (tcLoadEn, tcAddr, dnIn, ttIn, cuIn, cdIn, tcLoadOut);

	input tcLoadEn;
	input [`tcAddrLen-1:0] tcAddr;
	input [`tcNumbers-1:0] dnIn, ttIn, cuIn, cdIn;
	
	output [7:0] tcLoadOut;
	
	reg [`tcNumbers-1:0] dnInReg, ttInReg, cuInReg, cdInReg;
	
	wire dnSel, ttSel, cuSel, cdSel;
				
	always @ *
	begin
		dnInReg = dnIn;
		ttInReg = ttIn;
		cuInReg = cuIn;
		cdInReg = cdIn;
	end
			
	assign dnSel = dnInReg[tcAddr];
	assign ttSel = ttInReg[tcAddr];
	assign cuSel = cuInReg[tcAddr];
	assign cdSel = cdInReg[tcAddr];

	assign tcLoadOut = {4'b0, dnSel, ttSel, cuSel, cdSel};

endmodule
