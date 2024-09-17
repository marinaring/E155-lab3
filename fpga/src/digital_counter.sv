

module digital_counter(
	input clk,
	input reset,
	output slow_clk
);
	logic [7:0] counter;

	always_ff @(posedge clk) begin
		if (reset == 0) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1;
		end
	end
			
	assign slow_clk = counter[7];
endmodule