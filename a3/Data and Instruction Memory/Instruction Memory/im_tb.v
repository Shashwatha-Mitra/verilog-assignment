module im_tb;
reg clk,rst;
reg [63:0]PC;
wire [31:0]instruction;
wire [63:0]New_PC;
integer k;

instmemory m0(clk,rst,PC,instruction,New_PC);

initial 
begin
	$dumpfile("im.vcd");
	$dumpvars(0,im_tb);
	rst=1'b0;
end

initial 
begin
	clk=1'b1;
	repeat(100)
		#1 clk=~clk;
end

initial 
begin
	$display("\n\tclk\t|\tPC\t |\tNew_PC\t  |\trst\t|\t\tInstruction\t\t");
	#10	PC = 64'ha; 
	for(k=0;k<9;k=k+1)
	begin
		$display("\t%b\t|%h|%h|\t%b\t|%b",clk,PC,New_PC,rst,instruction);
		#2 PC = New_PC;
	end

	#4 rst = 1'b1;
	$display("\t%b\t|%h|%h|\t%b\t|%b",clk,PC,New_PC,rst,instruction);
	#10 $finish;
end
endmodule