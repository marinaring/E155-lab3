/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	A module that implements the next state logic for the row_scanner module. Made separate module to make it look cleaner
*/

// define variable type for state
//typedef enum logic [3:0] {R0, R1, R2, R3, P0, P1, P2, P3, W0, W1, W2, W3} statetype;
import statetype_package::*;

module scanner_next_state(
	input statetype state,
	input logic [3:0] cols,
	output statetype nextstate
);
	logic press;
	
	// if any of the columns are read to be high, then that indicates a press.
	assign press = cols[0] || cols[1] || cols[2] || cols[3];
	
	always_comb
		case(state)
			// in the scanning row state
			R0: begin
					nextstate = (press) ? P0 : R1;  
				end
			R1: begin
					nextstate = (press) ? P1 : R2;  
				end
			R2: begin
					nextstate = (press) ? P2 : R3;  
				end
			R3: begin
					nextstate = (press) ? P3 : R0;  
				end
			// in the sending pulse state (where pulse is the message that a row with a pressed button has been identified)
			P0: begin
					nextstate = (press) ? W0 : R0;  
				end
			P1: begin
					nextstate = (press) ? W1 : R1;  
				end
			P2: begin
					nextstate = (press) ? W2 : R2;  
				end
			P3: begin
					nextstate = (press) ? W3 : R3;  
				end
			// in the waiting state (waiting for pressed button to be released)
			W0: begin
					nextstate = (press) ? W0 : R0;  
				end
			W1: begin
					nextstate = (press) ? W1 : R1;  
				end
			W2: begin
					nextstate = (press) ? W2 : R2;  
				end
			W3: begin
					nextstate = (press) ? W3 : R3;  
				end
			default: nextstate = R0;
		endcase

endmodule