/*
	Marina Ring, mring@hmc.edu, 9/16/24
	Module to test the top module
	
*/

module lab3_mr_testbench();
	logic clk, reset;
	logic [3:0] cols, rows, rows_expected;
	logic [1:0] transistor, transistor_expected;
	logic [6:0] seg, seg_expected;
	logic [31:0] vectornum, errors;
	logic [16:0] testvectors[10000:0];
	
	lab3_mr top(clk, reset, cols, rows, transistor, seg);
	
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
			#1; {cols, rows_expected, transistor_expected, seg_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (reset) begin // skip during reset
			if (rows != rows_expected || transistor != transistor_expected || seg != seg_expected) begin // check result
				$display("Error: input = %b", {cols});
				$display(" outputs = %b (%b expected)", {rows, val}, {rows_expected, transistor_expected, seg_expected});
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 17'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule
