
`include "timescale.v"
`include "defines.v"


module pgmCounter (clk, reset, branch, pcIn, pcOut);

	input clk, reset, branch;
	input [`instAddrLen-1:0] pcIn;
	
	output [`instAddrLen-1:0] pcOut;
	
	reg [`instAddrLen-1:0] pc = `instAddrLen'b0;
	
	always @ (posedge clk or posedge reset)
	begin
	
		if (reset)
		begin
			pc = `instAddrLen'b0;
			$write ("\nprogram counter module is reset. Starting at address 00h	");
		end
		
		else
		begin
			
			if(branch)
			begin
				pc = pcIn;
				$write ("\nbranching at address %h", pcIn);
			end
			else
			begin
				pc = pc + 1'b1;
			end
		end
	end	// end always
	
	
	assign pcOut = pc;


endmodule
