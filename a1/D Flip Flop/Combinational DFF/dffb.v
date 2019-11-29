module dff(D,clk,Q,Qbar);
	input D,clk;
	output Q,Qbar;
	wire S,R;
	wire t1,t2;
	nand g1(t1,S,t2);
	nand g2(S,t1,~clk);
	nand g3(R,~clk,S,t2);
	nand g4(t2,R,D);
	nand g5(Q,S,Qbar);
	nand g6(Qbar,R,Q);
endmodule
