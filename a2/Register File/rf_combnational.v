//MUX MODULES
//2x1 Mux module
module mux2x1(I0,I1,sel,O);

	input [63:0]I0,I1;
	input sel;
	output [63:0]O;

	assign O = sel ? I1:I0;							//chooses I0,I1 based on select signal

endmodule

//4x1 Mux module 
module mux4x1(I0,I1,I2,I3,sel,O);
	
	input [63:0]I0,I1,I2,I3;
	input [1:0]sel;
	output [63:0]O;
	wire [63:0]t1,t2;

	mux2x1 a0(I0,I1,sel[0],t1);
	mux2x1 a1(I2,I3,sel[0],t2);
	mux2x1 a2(t1,t2,sel[1],O);						//chooses between 4 64 bit values
	
endmodule

//16x1 Mux module
module mux16x1(I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,sel,O);

	input [63:0]I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15;
	input [3:0]sel;
	output [63:0]O;
	wire [63:0]t1,t2,t3,t4,t5,t6;

	mux4x1 a0(I0,I1,I2,I3,sel[1:0],t1);
	mux4x1 a1(I4,I5,I6,I7,sel[1:0],t2);
	mux4x1 a2(I8,I9,I10,I11,sel[1:0],t3);
	mux4x1 a3(I12,I13,I14,I15,sel[1:0],t4);
	mux4x1 a4(t1,t2,t3,t4,sel[3:2],O);				//chooses between 16 64 bit values

endmodule

//32x1 Mux module
module mux32x1(I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17,I18,I19,I20,I21,I22,I23,I24,I25,I26,I27,I28,I29,I30,I31,sel,O);

	input [63:0]I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15;
	input [63:0]I16,I17,I18,I19,I20,I21,I22,I23,I24,I25,I26,I27,I28,I29,I30,I31;
	input [4:0]sel;
	output [63:0]O;
	wire [63:0]t1,t2;

	mux16x1 a0(I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,sel[3:0],t1);
	mux16x1 a1(I16,I17,I18,I19,I20,I21,I22,I23,I24,I25,I26,I27,I28,I29,I30,I31,sel[3:0],t2);
	mux2x1 a2(t1,t2,sel[4],O);						//chooses between 32 64 bit values
	
endmodule

//DECODER MODULES
//2x4 Decoder module
module Decoder2x4(I,E,O);
	
	input [1:0]I;
	input E;
	output [3:0]O;

	and (O[3],I[1],I[0],E);					
	and (O[2],I[1],~I[0],E);
	and (O[1],~I[1],I[0],E);
	and (O[0],~I[1],~I[0],E);				//one of the four lines will be 1 depending on the input

endmodule

//4x16 Decoder module
module Decoder4x16(I,E,O);

	input [3:0]I;
	input E;
	output [15:0]O;
	wire [3:0]t;

	Decoder2x4 m0(I[3:2],E,t);
	Decoder2x4 m1(I[1:0],t[0],O[3:0]);
	Decoder2x4 m2(I[1:0],t[1],O[7:4]);
	Decoder2x4 m3(I[1:0],t[2],O[11:8]);
	Decoder2x4 m4(I[1:0],t[3],O[15:12]);	//one of the 16 lines will be 1 depending on the input

endmodule

//5x32 Decoder module
module Decoder5x32(I,O);

	input [4:0]I;
	output [31:0]O;

	Decoder4x16 m0(I[3:0],~I[4],O[15:0]);
	Decoder4x16 m1(I[3:0],I[4],O[31:16]);	//one of the 32 lines will be 1 depending on the input

endmodule

//d flip flop module
module dff(D,rst,clk,write,Q);		
	input D,clk,rst,write;
	output Q;
	reg Q;
	always@(posedge clk, negedge rst)			//updates value of Q at either the positive edge of clock 
	begin									 				
		if(rst)									//if (reset=1) Q<=0 else if (write=1) Q<=D otherwise it holds its 
			Q <= 1'b0;								//previous value
		else 
		begin
			if(write)
				Q <= D;
		end
	end
endmodule


//32 bit PIPO register
//D Flip Flop is instantiated 64 times 
module register64(D,rst,clk,write,Q);
	input [63:0]D;
	input rst,clk,write;
	output [63:0]Q;

	dff d[63:0](D[63:0],rst,clk,write,Q[63:0]);

endmodule


//RegisterFileModule
module rf(regRNum1,regRNum2,wReg,Data,RegWrite,reset,clk,rData1,rData2);

	input [4:0]regRNum1,regRNum2,wReg;
	input [63:0]Data;
	input RegWrite,reset,clk;
	output [63:0]rData1,rData2;
	wire [63:0]x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31;
	wire [31:0]t;
	wire [31:0]write;
	
	Decoder5x32 m0(wReg,t);

	assign write = RegWrite ? (t & 32'hffffffff): 32'b0;			//checks which register has to be written

	//register bank and write function

	register64 X0(Data,reset,clk,write[0],x0);
	register64 X1(Data,reset,clk,write[1],x1);
	register64 X2(Data,reset,clk,write[2],x2);
	register64 X3(Data,reset,clk,write[3],x3);
	register64 X4(Data,reset,clk,write[4],x4);
	register64 X5(Data,reset,clk,write[5],x5);
	register64 X6(Data,reset,clk,write[6],x6);
	register64 X7(Data,reset,clk,write[7],x7);
	register64 X8(Data,reset,clk,write[8],x8);
	register64 X9(Data,reset,clk,write[9],x9);
	register64 X10(Data,reset,clk,write[10],x10);
	register64 X11(Data,reset,clk,write[11],x11);
	register64 X12(Data,reset,clk,write[12],x12);
	register64 X13(Data,reset,clk,write[13],x13);
	register64 X14(Data,reset,clk,write[14],x14);
	register64 X15(Data,reset,clk,write[15],x15);
	register64 X16(Data,reset,clk,write[16],x16);
	register64 X17(Data,reset,clk,write[17],x17);
	register64 X18(Data,reset,clk,write[18],x18);
	register64 X19(Data,reset,clk,write[19],x19);
	register64 X20(Data,reset,clk,write[20],x20);
	register64 X21(Data,reset,clk,write[21],x21);
	register64 X22(Data,reset,clk,write[22],x22);
	register64 X23(Data,reset,clk,write[23],x23);
	register64 X24(Data,reset,clk,write[24],x24);
	register64 X25(Data,reset,clk,write[25],x25);
	register64 X26(Data,reset,clk,write[26],x26);
	register64 X27(Data,reset,clk,write[27],x27);
	register64 X28(Data,reset,clk,write[28],x28);
	register64 X29(Data,reset,clk,write[29],x29);
	register64 X30(Data,reset,clk,write[30],x30);
	register64 X31(Data,reset,clk,write[31],x31);

	//Read Function
	mux32x1 a0(x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,regRNum1,rData1);
	mux32x1 a1(x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,regRNum2,rData2);

endmodule
