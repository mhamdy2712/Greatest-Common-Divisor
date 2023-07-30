module gcd_testbench;
	reg rst=0;
	reg start =0;
	reg Finished =0;
	reg [9:0] A,B,Result;
	parameter clk_prd = 10ns;
	reg clk = 0;
	reg done;
	always #(clk_prd/2) clk = ~clk;
	gcd_top my_gcd(
		.clk(clk),
		.rst(rst),
		.A(A),
		.B(B),
		.start(start),
		.Result(Result),
		.done(done)
	);
	task check_GCD(
		input [9:0] input_1,
		input [9:0] input_2
	);
		A=input_1;
		B=input_2;
		#(clk_prd);
		start=1;
		#(clk_prd);
		start=0;
		while(!done)
			#(clk_prd);
		#(clk_prd);
		$display("Result is %d",Result);
	endtask

	initial begin
		rst=1;
		#(clk_prd);
		rst=0;
		check_GCD(15,5);
		check_GCD(30,10);
		check_GCD(18,24);
		$finish();
	end
endmodule