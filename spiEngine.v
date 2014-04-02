
`include "timescale.v"
`include "defines.v"


module spiEngine (in8, out8, clk, s_in, s_out, sclk, bufMe, EN, Sh, BF);


		input s_in, EN, clk, Sh, bufMe;
		input [7:0] in8;
		
		output s_out, sclk, BF;
		output [7:0] out8;
		
		reg s_out, sclk, BF=1'b0;
		reg [7:0] sbuf = 8'b 00000000, out8 = 8'b 00000000;
		
		integer i = 4'b 0000;
		
		parameter data_width = 8;
		
		parameter ready = 3'b 000, sch = 3'b 001, scl = 3'b 010, fnsh = 3'b 011;// set-clock-high, set-clock-low, finish (states for shifting)
		reg [2:0] state = ready;
		reg [2:0] nxtCycle;

		
		always @ (posedge clk or posedge bufMe)
		begin
		
				if (bufMe)
						sbuf <= in8;
				
				else
				if (Sh && EN)
				
					case (state)
					
					ready		:		begin
										sclk <= 1'b z;
										s_out <= 1'b z;
										nxtCycle <= sch;
										state <= scl;
										end
										
					sch		:		begin
										sclk <= 1'b 1;								// set SCLK
						
									
								if (i > data_width) begin
									s_out <= 1'b z;
									sclk <= 1'b z;								// stop out-ing the SPI clock
									BF <= 1'b 1;
									out8 <= sbuf;
									
									state <= fnsh;						// next state should be fnsh after sclk=0 since 1-byte Xfer is done
									end
					
								if (i <= data_width) begin
									sbuf[0] <= s_in;						// receive MSB from MASTER_IN pin
									sbuf <= sbuf << 1;					// shift SBUF reg content
									BF <= 1'b 0;
						
									nxtCycle <= sch;						// next state should be sch after sclk=0 to Xfer remaining bits
									
									state <= scl;
									end
											end
						scl	:	begin
									sclk <= 1'b 0;		// SPI clock goes low
									s_out <= sbuf[data_width - 1];		// send MSB over MASTER_OUT pin
									i <= i+1;
									state <= nxtCycle;	// go to either sch or fnsh state (depending upon 'i')
									end
									
									
						fnsh	:	begin
									BF <= 1'b 1;									// raise the buffer-full flag
									i <= 0;										// reset counter
									sclk <= 1'b z;								// stop out-ing the SPI clock
									s_out <= 1'b z;								// stop sending data over MO
				
								//	state = ready;	//***
									end
									
						
						default	:	begin
										BF <= 1'b 0;
										end
					endcase
					
					
				else
				if (!Sh || !EN)
						begin
						state <= ready;
						sclk <= 1'b z;
						s_out <= 1'b z;
						BF <= 1'b 0;
						i <= 0;
						end
								
		end
		
		
endmodule
