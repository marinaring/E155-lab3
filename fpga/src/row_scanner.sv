/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	A module that will carry out switching through rows for the keypad
*/

module row_scanner(
	input logic clk,
	input logic reset,
	input logic [3:0] rows,
	inpuy logic [3:0] cols,
	output logic row_out
);

	// define variable type for state
	typedef enum logic [1:0] {R0, R1, R2, R3} statetype;
	statetype state, nextstate;

	// state register
	always_ff @(posedge clk) begin
		if (~reset) begin
			state <= R0;
		end
		else begin
			state <= nextstate;
		end
	end
	
	// next state logic
	always_comb
		case(state)
			R0: if 
			R1:
			R2:
			R3:
			default: R0
		endcase