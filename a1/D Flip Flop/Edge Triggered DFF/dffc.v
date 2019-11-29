module dff(D,clk,Q,Qbar);
	input D,clk;
	output Q,Qbar;
	reg Q;
	assign Qbar=~Q;
	always@(negedge clk)		//updates value of Q only at the negative edge of the clock signal
		Q<=D;
endmodule
