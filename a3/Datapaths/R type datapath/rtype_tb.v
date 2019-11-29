module rtype_tb;
reg [31:0]I;
reg clk, rst;
wire [63:0]ans;

RTypeDataPath m0(I,clk,rst,ans);

initial 
begin
	$dumpfile("rtype.vcd");
	$dumpvars(0,rtype_tb);
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
	$display("RISCV Code     |           Instruction          |result");
	#4 rst=1'b0;
	#1 I=32'b00000000011000101000001110110011;	//add x7,x5,x6
	#1 $display("add x7,x5,x6   |%b|%h",I,ans);
	#1 I=32'b01000000010100111000010000110011;  //sub x8,x7,x5
	#1 $display("sub x8,x7,x5   |%b|%h",I,ans);
	#1 I=32'b00000000010101000111010010110011;	//and x9,x8,x5
	#1 $display("and x9,x8,x5   |%b|%h",I,ans);	
	#1 I=32'b00000000010101000110010100110011;	//or x10,x8,x5
	#1 $display("or x10,x8,x5   |%b|%h",I,ans);
	#1 I=32'b01000000011100111110010110110011;	//nand x11,x7,x7
	#1 $display("nand x11,x7,x7 |%b|%h",I,ans);
	#1 I=32'b01000000011001011111011000110011;	//nor x12,x11,x6
	#1 $display("nor x12,x11,x6 |%b|%h",I,ans);
	#10 $finish; 
end
endmodule