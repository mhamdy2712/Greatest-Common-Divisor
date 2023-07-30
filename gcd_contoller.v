module gcd_controller(
	input clk,
	input reset,
	input [1:0] who_greater,
	input start,
	output reg reset_AB,
	output reg [1:0] minusAorB,
	output reg finished
);
	reg [2:0] curr_state,next_state;
	parameter [2:0] checkstart = 3'd0,
					AequalB = 3'd1,
					whogreater = 3'd2,
					Agreater = 3'd3,
					Bgreater = 3'd4,
					result = 3'd5;
	always @(posedge clk) begin
		if(reset==1) begin
			curr_state <= checkstart;
		end
		else begin
			curr_state <= next_state;
		end
	end
	always @(*) begin
		finished=0;
		minusAorB=0;
		case(curr_state)
			checkstart: begin
				if (start) next_state = AequalB;
				else begin
					reset_AB = 1;
					next_state = checkstart;
				end
			end
			AequalB: begin
				reset_AB = 0;
				next_state = (who_greater!=0) ? whogreater : result;
			end
			whogreater: begin
				if (who_greater==1) next_state = Agreater;
				if (who_greater==2) next_state = Bgreater;
			end
			Agreater: begin
				minusAorB = 1;
				next_state = AequalB;
			end
			Bgreater: begin
				minusAorB = 2;
				next_state = AequalB;
			end
			result: begin
				finished = 1;
				next_state = start;
			end
		endcase
	end
endmodule