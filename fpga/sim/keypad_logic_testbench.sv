
/*
	Marina Ring, mring@hmc.edu, 9/1/24
	Module to test the signals for the seven segment generator
	
*/

module seg_testbench();
	logic clk, reset;
	logic [3:0] rows, cols;
	logic [3:0] val, val_expected;
	logic [31:0] vectornum, errors;
	logic [11:0] testvectors[10000:0];
	
	keypad_logic keypad(rows, cols, val);
	
	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	
	initial 
		begin
			$readmemb("keypad_logic_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 0; #22; reset = 1;
		end
	
	always @(posedge clk)
		begin
			#1; {rows, cols, val_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (reset) begin // skip during reset
			if (val != val_expected) begin // check result
				$display("Error: input = %b", {rows, cols});
				$display(" outputs = %b (%b expected)", val, val_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 12'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule