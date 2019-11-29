module itype_tb;
reg [31:0]I;
reg clk, rst;
wire [63:0]ans;

ITypeDataPath m0(I,clk,rst,ans);

initial 
begin
	$dumpfile("itype.vcd");
	$dumpvars(0,itype_tb);
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
	#1 I=32'b00000011010100101000001110010011;
	#1 $display("addi x7,x5,53  |%b|%h",I,ans);
	#1 I=32'b11111111101100111000011110010011;
	#1 $display("addi x15,x7,-5 |%b|%h",I,ans);
	#10 $finish;
end
endmodule