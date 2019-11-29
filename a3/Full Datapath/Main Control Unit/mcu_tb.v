module mcu_tb;
reg [31:0]I;
reg clk;
reg rst;
wire alusrc,memToReg,regWrite,memRead,memWrite,branch;
wire [1:0]aluOP;

mcu m0(I,rst,clk,alusrc,memToReg,regWrite,memRead,memWrite,branch,aluOP);

initial 
begin
	$dumpfile("mcu.vcd");
	$dumpvars(0,mcu_tb);
	rst=1'b1;
end

initial
begin
	clk=1'b1;
	repeat(100)
		#1 clk=~clk;
end

initial 
begin
	#4 rst=1'b0;
	#1 $display("\tInstruction\t\t| ALUSrc | MemToReg | RegWrite | MemRead | MemWrite | Branch | ALUOp");
	   I=32'b00000000011000111000001100110011;	//add  x6,x7,x6 
	#1 $monitor("%b|    %b   |    %b     |    %b     |    %b    |    %b     |   %b    |  %b",I,alusrc,memToReg,regWrite,memRead,memWrite,branch,aluOP);
	#1 I=32'b01000000011000111000001100110011;  //sub  x6,x7,x6
	#1 I=32'b00000000000100010111000110110011;	//and  x3,x2,x1
	#1 I=32'b00000000000100010110000110110011;	//or   x3,x2,x1
	#1 I=32'b01000000010000101110001100110011;	//nand x6,x5,x4
	#1 I=32'b01000000010000101111001110110011;	//nor  x7,x5,x4
	#1 I=32'b00110011010100100000001010010011;	//addi x5,x4,821
	#1 I=32'b00000000000000010011000110000011;	//ld   x3,0(x2)
	#1 I=32'b00000000000100010000001001100111;	//beq  x1,x2,2
	#1 I=32'b00000000010100110000000000100011;	//sd   x6,0(x5)
	#4 $finish;
end
endmodule