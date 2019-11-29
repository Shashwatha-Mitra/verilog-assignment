//Full Adder Module
module FA(a,b,cin,sum,cout);

	input a,b,cin;
	output sum,cout;
	wire t1,t2,t3;

	xor(sum,a,b,cin);
	and(t1,a,b);
	and(t2,a,cin);
	and(t3,b,cin);
	or(cout,t1,t2,t3);

endmodule

//ALU module
module alu(a,b,cin,control,result,cout);

	input a,b,cin;
	input [3:0]control;
	output result,cout;
	wire t1,t2;
	wire ain,bin;
	wire sum,slt;
	wire t3,t4;

	assign ain=control[3] ? ~a:a; 				//checks if a needs to be inverted
	assign bin=control[2] ? ~b:b;				//checks if b needs to be inverted
	
	and (t1,ain,bin);
	or (t2,ain,bin);
	FA a0(ain,bin,cin,sum,cout);
	assign slt=~cout;
	
	assign t3 = control[0]?t2:t1;				//chooses and/or function
	assign t4 = control[0]?slt:sum;				//chooses slt/sum function
	assign result = control[1]?t4:t3;			//gets result of the four operations

endmodule

//4 bit ALU module
module alu4(a,b,cin,control,result,cout);

	input [3:0]a,b,control;
	input cin;
	output [3:0]result;
	output cout;
	wire [3:1]c;

	alu1 a0(a[0],b[0],cin,control,result[0],c[1]);
	alu1 a1(a[1],b[1],c[1],control,result[1],c[2]);
	alu1 a2(a[2],b[2],c[2],control,result[2],c[3]);
	alu1 a3(a[3],b[3],c[3],control,result[3],cout);

endmodule

//16 bit ALU module
module alu16(a,b,cin,control,result,cout);

	input [15:0]a,b;
	input [3:0]control;
	input cin;
	output [15:0]result;
	output cout;
	wire [3:1]c;

	alu4 a0(a[3:0],b[3:0],cin,control,result[3:0],c[1]);
	alu4 a1(a[7:4],b[7:4],c[1],control,result[7:4],c[2]);
	alu4 a2(a[11:8],b[11:8],c[2],control,result[11:8],c[3]);
	alu4 a3(a[15:12],b[15:12],c[3],control,result[15:12],cout);

endmodule

//64 bit ALU module
module alu64(a,b,cin,control,result,cout,zero,overflow);

	input [63:0]a,b;
	input [3:0]control;
	input cin;
	output [63:0]result;
	output cout,zero,overflow;
	wire [3:1]c;
	wire t1,t2,t3,t4,t5,t6,t7,t8;
	
	alu16 a0(a[15:0],b[15:0],cin,control,result[15:0],c[1]);
	alu16 a1(a[31:16],b[31:16],c[1],control,result[31:16],c[2]);
	alu16 a2(a[47:32],b[47:32],c[2],control,result[47:32],c[3]);
	alu16 a3(a[63:48],b[63:48],c[3],control,result[63:48],cout);

	assign zero = ~|result;							//checks if result is zero

	and (t1,a[63],b[63],~result[63]);				
	and (t2,~a[63],~b[63],result[63]);
	or  (t3,t1,t2);
	and (t4,~control[2],control[1],t3);				//checks if there is an overflow in addition

	and (t5,a[63],~b[63],~result[63]);
	and (t6,~a[63],b[63],result[63]);
	or  (t7,t5,t6);
	and (t8,control[2],control[1],t7);				//checks if there is an overflow in subtraction

	or  (overflow,t8,t4);							//checks if there is overall overflow

endmodule
