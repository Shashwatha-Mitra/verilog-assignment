module fullDataPath_tb;
reg [63:0]PC;
reg clk,rst;
wire [63:0]New_PC,ans;
wire [31:0]I;
integer k;

fullDataPath m0(PC,clk,rst,New_PC,ans,I);

initial
begin
	$dumpfile("fullDataPath.vcd");
	$dumpvars(0,fullDataPath_tb);
	rst=1'b1;
end

initial
begin
	clk = 1'b0;
	repeat(100)
		#1 clk= ~clk;
end

initial
begin
	#4 rst=1'b0;
	$display("RISCV High level Code");
	$display("\n\tld x2,0(x9)\n\tld x1,4(x9)\n\tbeq x2,x1,6\nelse:\n\tsub x3,x2,x1\n\tsd x3,8(x9)\nif:\n\taddi x3,x2,-20\n\tsd x3,8(x9)");
	$display("\nInstruction Execution\n");
	$display("           Instruction          |\tPC\t | \tNew PC\t  | Result");
	PC=64'ha;
	#1 $monitor("%b|%h|%h|  %3d",I,PC,New_PC,ans);
	for(k=0;k<5;k=k+1)
		#2 PC = New_PC;
	#10 $finish;
end
endmodule