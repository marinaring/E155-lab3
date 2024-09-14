/*
	Marina Ring, mring@hmc.edu, 9/13/24
	Module to test the digit controller
	
*/

module digit_controller_testbench();
	logic clk, reset;
	logic [3:0] cols, rows, rows_expected;
	logic [7:0] val, val_expected;
	logic [31:0] vectornum, errors;
	logic [15:0] testvectors[10000:0];
	
	digit_controller controller(clk, reset, cols, rows, val);
	
	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	
	initial 
		begin
			$readmemb("digit_controller_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 0; #22; reset = 1;
		end
	
	always @(posedge clk)
		begin
			#1; {cols, rows_expected, val_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (reset) begin // skip during reset
			if (rows != rows_expected || val != val_expected) begin // check result
				$display("Error: input = %b", {cols});
				$display(" outputs = %b (%b expected)", {rows, val}, {rows_expected, val_expected});
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 16'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule
