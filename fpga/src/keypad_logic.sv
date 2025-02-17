/*
	Marina Ring, mring@hmc.edu, 9/13/2024
	A module to decode the keypad into its appropriate hex digit
*/

module keypad_logic(
	input logic [3:0] rows,
	input logic [3:0] cols,
	output logic [3:0] val
);
	
	always_comb
		case(rows)
			// first row
			4'b0001: begin
				case(cols)
					4'b0001: val = 4'b0001;
					4'b0010: val = 4'b0010;
					4'b0100: val = 4'b0011;
					4'b1000: val = 4'b1010;
					default: val = 4'bx;
				endcase
			end
			// second row
			4'b0010: begin
				case(cols)
					4'b0001: val = 4'b0100;
					4'b0010: val = 4'b0101;
					4'b0100: val = 4'b0110;
					4'b1000: val = 4'b1011;
					default: val = 4'bx;
				endcase
			end
			// third row
			4'b0100: begin
				case(cols)
					4'b0001: val = 4'b0111;
					4'b0010: val = 4'b1000;
					4'b0100: val = 4'b1001;
					4'b1000: val = 4'b1100;
					default: val = 4'bx;
				endcase
			end
			// fourth row
			4'b1000: begin
				case(cols)
					4'b0001: val = 4'b1110;
					4'b0010: val = 4'b0000;
					4'b0100: val = 4'b1111;
					4'b1000: val = 4'b1101;
					default: val = 4'bx;
				endcase
			end 
			default: val = 4'bx;
		endcase

endmodule