/*
	Marina Ring, mring@hmc.edu, 9/13/24
	Module to test the next state logic for the scanner
	
*/

// define variable type for state
import statetype_package::*;

module scanner_next_state_testbench();
	logic clk, reset;
	logic [3:0] cols;
	statetype state, nextstate, nextstate_expected;
	logic [31:0] vectornum, errors;
	logic [11:0] testvectors[10000:0];
	
	scanner_next_state scanner(state, cols, nextstate);
	
	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	
	initial 
		begin
			$readmemb("scanner_next_state_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
	
	always @(posedge clk)
		begin
			#1; {state, cols, nextstate_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if (nextstate != nextstate_expected) begin // check result
				$display("Error: input = %b", {state, cols});
				$display(" outputs = %b (%b expected)", nextstate, nextstate_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 12'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule