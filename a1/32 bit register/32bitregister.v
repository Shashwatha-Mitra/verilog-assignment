//d flip flop module
module dff(D,rst,clk,Q);		
	input D,clk,rst;
	output Q;
	reg Q;
	always@(negedge clk, posedge rst)			//updates value of Q at either the negative edge 
	begin										//or positive edge of the reset signal 				
		if(rst)									//if reset Q<=0 else Q<=D
			Q<=0;
		else
			Q<=D;
	end
endmodule


//32 bit PIPO register
//D Flip Flop is instantiated 32 times 
module register32(D,rst,clk,Q);
	input [31:0]D;
	input rst,clk;
	output [31:0]Q;
	dff d0(D[0],rst,clk,Q[0]);
	dff d1(D[1],rst,clk,Q[1]);
	dff d2(D[2],rst,clk,Q[2]);
	dff d3(D[3],rst,clk,Q[3]);
	dff d4(D[4],rst,clk,Q[4]);
	dff d5(D[5],rst,clk,Q[5]);
	dff d6(D[6],rst,clk,Q[6]);
	dff d7(D[7],rst,clk,Q[7]);
	dff d8(D[8],rst,clk,Q[8]);
	dff d9(D[9],rst,clk,Q[9]);
	dff d10(D[10],rst,clk,Q[10]);
	dff d11(D[11],rst,clk,Q[11]);
	dff d12(D[12],rst,clk,Q[12]);
	dff d13(D[13],rst,clk,Q[13]);
	dff d14(D[14],rst,clk,Q[14]);
	dff d15(D[15],rst,clk,Q[15]);
	dff d16(D[16],rst,clk,Q[16]);
	dff d17(D[17],rst,clk,Q[17]);
	dff d18(D[18],rst,clk,Q[18]);
	dff d19(D[19],rst,clk,Q[19]);
	dff d20(D[20],rst,clk,Q[20]);
	dff d21(D[21],rst,clk,Q[21]);
	dff d22(D[22],rst,clk,Q[22]);
	dff d23(D[23],rst,clk,Q[23]);
	dff d24(D[24],rst,clk,Q[24]);
	dff d25(D[25],rst,clk,Q[25]);
	dff d26(D[26],rst,clk,Q[26]);
	dff d27(D[27],rst,clk,Q[27]);
	dff d28(D[28],rst,clk,Q[28]);
	dff d29(D[29],rst,clk,Q[29]);
	dff d30(D[30],rst,clk,Q[30]);
	dff d31(D[31],rst,clk,Q[31]);
endmodule
