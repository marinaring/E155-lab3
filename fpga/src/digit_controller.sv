/*
	Marina Ring, mring@hmc.edu, 9/14/2024
	Module that controls when digits are changed and what they are changed to
*/

module digit_controller(
		input logic clk,
		input logic reset,
		input logic [3:0] cols,
		output logic [3:0] rows,
		output logic [7:0] val
);

	logic [3:0] temp_digit, digit1, digit2;
	logic change;
	logic [3:0] rows_out;
	
	// scan rows
	row_scanner row_read(clk, reset, cols, rows_out, press, change);
	keypad_logic keypad(rows_out, cols, temp_digit);

	// if the row scanner indicates that a button has been pressed, put the first digit into the second digit and read in a new digit
	always_ff @(posedge clk) begin
		if (~reset) begin
			val <= 7'b0;
		end
		else if (change) begin
			val[7:4] <= val[3:0];
			val[3:0] <= digit1;
		end
		else if (press) begin
			digit1 <= temp_digit;
		end
	end 
	
	assign rows = rows_out;
		
endmodule