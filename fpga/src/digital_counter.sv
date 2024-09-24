/*
	Marina Ring, mring@hmc.edu, 9/23/2024
	A module to slow down the clock using a counter
*/


module digital_counter(
	input clk,
	input reset,
	output slow_clk
);
	logic [7:0] counter;

	always_ff @(posedge clk) begin
		if (~reset) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1;
		end
	end
			
	assign slow_clk = counter[7];
endmodule