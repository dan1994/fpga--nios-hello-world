module top (
	input logic 			sys_clk_50m,
	input logic 			sys_rst_n,

	input logic[3 : 0] 		buttons,
	output logic[3 : 0] 	leds
);

	logic[$clog2(50_000_000) - 1 : 0] 	cnt;

	always_ff@(posedge sys_clk_50m, negedge sys_rst_n) begin
		if(~sys_rst_n) begin
			leds[0] 	<= '0;
		end else begin
			cnt <= cnt - 1;

			if(cnt == '0) begin
				leds[0] 	<= ~leds[0];
			end
		end
	end

	assign leds[1] 	= ~buttons[1];

	nios_setup nios_setup_i (
		.clk_clk(sys_clk_50m),
		.reset_reset_n(sys_rst_n),
		.buttons_export(buttons[3 : 2]),
		.leds_export(leds[3 : 2])
	);

endmodule