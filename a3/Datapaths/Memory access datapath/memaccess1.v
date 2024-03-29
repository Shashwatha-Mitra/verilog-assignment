module alucu(op, funct, control);
    
    input [1:0]op;                              //op function
    input [2:0]funct;                           //minimal bits from the funct7 and funct3 fields
    output [3:0]control;
    wire [3:0]temp1,temp2;

    xor( temp1[0], funct[0], funct[1]);
    and( temp1[1], ~funct[1], ~funct[0]);
    assign temp1[2]=funct[2];
    and( temp1[3], funct[2], funct[1]);

    assign temp2[0]=op[1];
    assign temp2[1]=~op[1];
    assign temp2[2]=op[0];
    assign temp2[3]=op[1];

    assign control= op[1]?temp1:temp2;          //checks if aluop is 01/00 or 10 and returns the control signal to the ALU

endmodule

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

	alu a0(a[0],b[0],cin,control,result[0],c[1]);
	alu a1(a[1],b[1],c[1],control,result[1],c[2]);
	alu a2(a[2],b[2],c[2],control,result[2],c[3]);
	alu a3(a[3],b[3],c[3],control,result[3],cout);

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

//complete ALU module
module completeALU(a,b,op,funct,result,cout,zero,overflow);

	input [63:0]a,b;
    input [1:0]op;
    input [2:0]funct;
	output [63:0]result;
	output cout,zero,overflow;
	wire [3:0]control;

	alucu a0(op,funct,control);										//generates control signal for ALU
	alu64 a1(a,b,control[2],control,result,cout,zero,overflow);		//generates required output and output flags

endmodule	

module MemAccessDataPath(I,clk,rst,ans);

	input [31:0]I;
	input [63:0]num;
	input clk,rst;
	output [63:0]ans;
	integer k;
	wire [63:0]result;
	wire [1:0]aluop;
	wire [2:0]funct;
	wire [6:0]opcode;
	wire cout,zero,overflow,MemWrite,MemRead,RegWrite,temp;

	reg [63:0]RF[0:31];
	reg [63:0]imm,rData;
	//reg [63:0]DM[0:131071];

	assign aluop[1]  = (~I[6]) & I[5] & I[4];
	assign aluop[0]  = I[6] & I[5] & (~I[4]); 
	assign funct     = I[14:12];
	assign opcode    = I[6:0];

	always@(opcode)
	begin
		if(opcode == 7'b0000011)
		begin
			imm[11:0]  <= I[31:20];
			if(imm[11])
				imm[63:12] <= 52'hfffffffffffff;
			else
				imm[63:12] <= 52'h0;
		end

		else if(opcode == 7'b0100011)
		begin
			imm[4:0]   <= I[11:7];
			imm[11:5]  <= I[31:25];
			if(I[31])
				imm[63:12] <= 52'hfffffffffffff;
			else
				imm[63:12] <= 52'h0;
		end

		else
			imm <= 64'hx;
	end

	nor (MemRead,I[6],I[5],I[4]);
	nor (MemWrite,I[6],~I[5],I[4]);
	xnor(temp,I[4],I[5]);
	and (RegWrite,~I[6],temp);

	completeALU m0(RF[I[19:15]],imm,aluop,funct,result,cout,zero,overflow);
	reg [63:0]DM[0:131071];

	always@(posedge clk,rData)
	begin
		if(RegWrite)
			RF[I[11:7]] <= rData;
				
		if(rst)
		begin	
			for(k=0;k<32;k=k+1)
				RF[k] <= 64'h0;
			RF[5] <= 100;
			RF[6] <= 150;
		end

	end

	always@(posedge clk)
	begin

		if(MemRead)
			rData <= DM[result];
		if(MemWrite)
			DM[result] <= RF[I[24:20]];

	end

	assign ans = rData;

endmodule