module dLatch(D,En,Q);
	input D,En,rst;
	output Q;
	reg Q;
	always@(En,D,rst)
	begin
		if(En) 					//if enable is 1, Q follows D
			Q<=D;
		else					//if enable is 0, Q will retain its previous state
			Q<=Q;
	end
endmodule

module dff(D,clk,Q,Qbar);
	input D,clk;
	output Q,Qbar;
	assign Qbar=~Q;
	wire t1,t2;
	assign t2=~clk;
	dLatch d1(D,clk,t1);		//Master DLatch
	dLatch d2(t1,t2,Q);			//Slave DLatch
endmodule

