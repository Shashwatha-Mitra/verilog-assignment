module memaccess_tb;
reg [31:0]I;
reg clk, rst;
wire [63:0]ans;

MemAccessDataPath m0(I,clk,rst,ans);

initial 
begin
	$dumpfile("memaccess.vcd");
	$dumpvars(0,memaccess_tb);
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
	#1 I=32'b11111110010100110010101000100011;
	#2 $display("sd x5,-12(x6)  |%b|%h",I,ans);
	I=32'b11111111010000110011001110000011;
	#2 $display("ld x7,-12(x6)  |%b|%h",I,ans);
	I=32'b00000000011000111010000000100011;
	#2 $display("sd x6,0(x7)    |%b|%h",I,ans);
	I=32'b00000000000000111011010000000011;
	#2 $display("ld x8,0(x7)    |%b|%h",I,ans);
	#10 $finish;
end
endmodule