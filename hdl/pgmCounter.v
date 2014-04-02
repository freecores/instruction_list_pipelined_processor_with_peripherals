
`include "timescale.v"
`include "defines.v"


module pgmCounter (clk, reset, branch, pcIn, pcOut);

	input clk, reset, branch;
	input [`instLen-1:0] pcIn;
	
	output [`instLen-1:0] pcOut;
	
	reg [`instLen-1:0] pc = `instLen'b0;
	
	always @ (posedge clk or posedge reset)
	begin
	
		if (reset)
		begin
			pc = `instLen'b0;
			$write ("	program counter module is reset. Starting at address 00h	");
		end
		
		else
		begin
			
			if(branch)
			begin
				pc = pcIn;
				$write ("	branching at address %h", pcIn);
			end
			else
			begin
				pc = pc + 1'b1;
			end
		end
	end	// end always
	
	
	assign pcOut = pc;


endmodule
