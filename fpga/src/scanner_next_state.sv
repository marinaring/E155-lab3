/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	A module that implements the next state logic for the row_scanner module. Made separate module to make it look cleaner
*/

// define variable type for state
import statetype_package::*;

module scanner_next_state(
	input statetype state,
	input logic [3:0] cols,
	input logic [5:0] counter,
	output statetype nextstate
);
	logic press;
	
	// if any of the columns are read to be high, then that indicates a press.
	assign press = cols[0] || cols[1] || cols[2] || cols[3];
	
	always_comb
		case(state)
			// row turns on, we wait two clock cycles for the column signal to change after the row changes
			R0: begin
					nextstate = (counter == 1) ? RC0 : R0;
				end
			R1: begin
					nextstate = (counter == 1) ? RC1 : R1;
				end
			R2: begin
					nextstate = (counter == 1) ? RC2 : R2;  
				end
			R3: begin
					nextstate = (counter == 1) ? RC3 : R3;
				end
			// in the scanning row state
			RC0: begin
					nextstate = (press) ? D0 : R1;  
				end
			RC1: begin
					nextstate = (press) ? D1 : R2;  
				end
			RC2: begin
					nextstate = (press) ? D2 : R3;  
				end
			RC3: begin
					nextstate = (press) ? D3 : R0;  
				end
			// debouncing state, we wait 10 clock cycles for the signal to settle
			D0: begin
					if (counter == 10) begin
						nextstate = (press) ? P0 : RC0;
					end
					else begin
						nextstate = D0;
					end
				end
			D1: begin
					if (counter == 10) begin
						nextstate = (press) ? P1 : RC1;
					end
					else begin
						nextstate = D1;
					end
				end
			D2: begin
					if (counter == 10) begin
						nextstate = (press) ? P2 : RC2;
					end
					else begin
						nextstate = D2;
					end
				end
			D3: begin
					if (counter == 10) begin
						nextstate = (press) ? P3 : RC3;
					end
					else begin
						nextstate = D3;
					end
				end
			// in the sending pulse state (where pulse is the message that a row with a pressed button has been identified)
			P0: begin
					nextstate = (press) ? W0 : RC0;  
				end
			P1: begin
					nextstate = (press) ? W1 : RC1;  
				end
			P2: begin
					nextstate = (press) ? W2 : RC2;  
				end
			P3: begin
					nextstate = (press) ? W3 : RC3;  
				end
			// in the waiting state (waiting for pressed button to be released)
			W0: begin
					nextstate = (press) ? W0 : RC0;  
				end
			W1: begin
					nextstate = (press) ? W1 : RC1;  
				end
			W2: begin
					nextstate = (press) ? W2 : RC2;  
				end
			W3: begin
					nextstate = (press) ? W3 : RC3;  
				end
			default: nextstate = R0;
		endcase

endmodule