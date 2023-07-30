module gcd_datapath(
	input clk,
	input [1:0] MinusAorB,
	input finished,
	input [9:0] A,
	input [9:0] B,
	input reset_AB,
	output reg [1:0] who_greater,
	output reg [9:0] result
);
	reg [9:0] dp_A;
	reg [9:0] dp_B;
	always @(posedge clk) begin
		if(reset_AB) begin
			dp_A = A;
			dp_B = B;
		end
		if (dp_A==dp_B) who_greater =0;
		else if (dp_A>dp_B) who_greater=1;
		else who_greater=2;
		if(MinusAorB==1) dp_A = dp_A-dp_B;
		else if(MinusAorB==2) dp_B = dp_B-dp_A;
		if (finished) result = dp_A;
	end
endmodule
	