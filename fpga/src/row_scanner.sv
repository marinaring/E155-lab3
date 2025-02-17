/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	A module that will carry out switching through rows for the keypad
*/

// define variable type for state
//typedef enum logic [3:0] {R0, R1, R2, R3, P0, P1, P2, P3, W0, W1, W2, W3} statetype;
import statetype_package::*;

module row_scanner(
	input logic clk,
	input logic reset,
	input logic [3:0] cols,
	output logic [3:0] rows,
	output logic press,
	output logic change
);

	statetype state, nextstate;
	logic [5:0] counter;

	// state register
	always_ff @(posedge clk) begin
		if (~reset) begin
			state <= R0;
			counter <= 0;
		end
		else begin
			// reset counter when scanning for columns, and then increment otherwise.
			counter <= (state == RC0 || state == RC1 || state == RC2 || state == RC3) ? 0 : counter + 1;
			state <= nextstate;
		end
	end
	
	// next state logic
	scanner_next_state scan(state, cols, counter, nextstate);
	
	// output logic
	//assign rows[0] = (state == R0 || state == RC0 || state == D0 ||  state == D1 || state == D2 || state == D3 || state == P0 || state == P1 || state == P2 || state == P3 state == W0 || state == W1 || state == W2 || state == W3);
	assign rows[0] = !(state == R1 || state == RC1 || state == R2 || state == RC2 || state == R3 || state == RC3);
	assign rows[1] = !(state == R2 || state == RC2 || state == R3 || state == RC3 || state == R0 || state == RC0);
	assign rows[2] = !(state == R3 || state == RC3 || state == R0 || state == RC0 || state == R1 || state == RC1);
	assign rows[3] = !(state == R0 || state == RC0 || state == R1 || state == RC1 || state == R2 || state == RC2);
	assign press = ((state == RC0 || state == RC1 || state == RC2 || state == RC3) && (cols[0] || cols[1] || cols[2] || cols[3]));
	assign change = (state == P0 || state == P1 || state == P2 || state == P3);	
endmodule