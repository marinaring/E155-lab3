/*
	Marina Ring, mring@hmc.edu, 9/13/24
	Module to test the row scanner
	
*/


module row_scanner_testbench();
	logic clk, reset;
	logic [3:0] cols, rows, rows_expected;
	logic change_expected;
	logic [31:0] vectornum, errors;
	logic [8:0] testvectors[10000:0];
	
	row_scanner scanner(clk, reset, cols, rows, change);
	
	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	
	initial 
		begin
			$readmemb("row_scanner_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 0; #22; reset = 1;
		end
	
	always @(posedge clk)
		begin
			#1; {cols, rows_expected, change_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (reset) begin // skip during reset
			if (rows != rows_expected || change != change_expected) begin // check result
				$display("Error: cols = %b", {cols});
				$display(" outputs = %b (%b expected)", {rows, change}, {rows_expected, change_expected});
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 9'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule
