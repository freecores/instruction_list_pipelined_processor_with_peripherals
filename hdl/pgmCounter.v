
`include "timescale.v"
`include "defines.v"


module pgmCounter (clk, reset, branch, pcIn, pcOut);

	input clk, reset, branch;
	input [`instAddrLen-1:0] pcIn;
	
	output [`instAddrLen-1:0] pcOut;
	
	reg [`instAddrLen-1:0] pcOut = `instAddrLen'b0;
	
	always @ (posedge clk)
	begin
	
		if (reset)
		begin
			pcOut = `instAddrLen'b0;
			$write ("\nprogram counter module is reset. Starting at address 00h	");
		end
		
		else
		begin
			
			if(branch)
			begin
				pcOut = pcIn;
				$write ("\nbranching at address %h", pcIn);
			end
			else
			begin
				pcOut = pcOut + 1'b1;
			end
		end
	end	// end always
	

endmodule
