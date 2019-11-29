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
