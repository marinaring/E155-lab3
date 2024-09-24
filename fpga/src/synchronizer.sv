/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	A module to synchronize asynchronous inputs, will help to debounce the keypad input
*/

module synchronizer(
	input logic clk,
	input logic reset,
	input logic [3:0] cols,
	output logic [3:0] cols_sync
);

	logic [3:0] temp;
	
	// makes it so that the cols signal goes through two registers (hopefully giving it time to stabilize)
	always_ff @(posedge clk) begin
		if (~reset) begin
			temp <= 4'b0;
		end
		else begin
			temp <= cols;
			cols_sync <= temp;
		end
	end
	
endmodule