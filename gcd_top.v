module gcd_top (
	input clk,
	input rst,
	input start,
	input [9:0] A,
	input [9:0] B,
	output reg [9:0] Result,
	output reg done
);
	wire [1:0] minusAOrB,AorBGreater;
	wire Finished,Reset_AB;
	gcd_controller my_contoller(
		.clk(clk),
		.reset(rst),
		.start(start),
		.who_greater(AorBGreater),
		.minusAorB(minusAOrB),
		.finished(Finished),
		.reset_AB(Reset_AB)
	);
	assign done = Finished;
	gcd_datapath my_dp(
		.clk(clk),
		.A(A),
		.B(B),
		.result(Result),
		.MinusAorB(minusAOrB),
		.who_greater(AorBGreater),
		.finished(Finished),
		.reset_AB(Reset_AB)

	);
endmodule