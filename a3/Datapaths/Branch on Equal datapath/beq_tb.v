module beq_tb;
reg [63:0]PC;
reg clk, rst;
wire [63:0]New_PC;
wire [31:0]I;

BranchDataPath m0(PC,clk,rst,I,New_PC);

initial
begin
	$dumpfile("beq.vcd");
	$dumpvars(0,beq_tb);
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
	$display("RISCV Code     |           Instruction          |\tPC\t |\tNew PC\t");
	#4 rst=1'b0;PC=64'ha;
	#1 $display("beq x5,x6,40   |%b|%h|%h",I,PC,New_PC);
	#1 PC=New_PC;
	#1 $display("sd x5,-12(x6)  |%b|%h|%h",I,PC,New_PC);
	#10 $finish;
end

endmodule
