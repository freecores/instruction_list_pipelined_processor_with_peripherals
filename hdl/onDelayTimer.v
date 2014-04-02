
`include "timescale.v"
`include "defines.v"


module onDelayTimer (reset, en, clk1, clk2, tb, preset, DN, TT, ACC);

	input reset, en, clk1, clk2, tb;
	input [`timerPresetLen-1:0]	preset;
	
	output DN, TT;
	output [`timerAccLen-1:0]	ACC;
	
	reg DN, TT;
	reg [`timerAccLen-1:0] ACC;
	
	
	reg	clk;
	
	
	always @ (tb or clk1 or clk2)
	begin
		if (tb)
		begin
			clk = clk1;
			$write ("	on-delay timer running on timer-base1	");
		end
		else
		begin
			clk = clk2;
			$write ("	on-delay timer running on timer-base2	");
		end
	end	// end always
	
	
	always @ (posedge clk or posedge reset)	// for ACC
	begin
	
		if (reset)
		begin
			ACC = `timerAccLen'b0;
			$write ("	on-delay timer is reset	");
		end
		else
		begin
			if (en)
			begin
				if ((ACC < preset))
				begin
					ACC = ACC + 1'b1;
				end
				else
				begin
					ACC = ACC;
				end
			end
			else
			begin
				ACC = `timerAccLen'b0;
			end
		end
	
	end	// end always for ACC
	
	
	always @ (reset or en or ACC or preset)	// for DN, TT
	begin
	
		if (reset)
		begin
			DN = 1'b0;
			TT = 1'b0;
		end
		else
		begin
			if (en)
			begin
				if (ACC < preset)
				begin
					DN = 1'b0;
					TT = 1'b1;
				end
				else
				begin
					DN = 1'b1;
					TT = 1'b0;
				end
			end
			else
			begin
				DN = 1'b0;
				TT = 1'b0;
			end
		end
	
	end	// end always for DN, TT


endmodule
