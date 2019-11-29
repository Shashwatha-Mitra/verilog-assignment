module register32_tb;
reg [31:0]D;
reg rst,clk;
wire [31:0]Q;

register32 m1(D,rst,clk,Q);

//generating clock signal with time period 6 units
initial
begin
	clk=1'b1;				
	repeat(30)
		#3 clk=~clk;
end

initial
begin
	$dumpfile("32bitregister.vcd");
	$dumpvars(0,register32_tb);
end

//testing block
initial
begin
	#2 D=32'hffffffff; rst=1'b0;
	#5 $display("%g READ: Q=%h",$time,Q);
	#1 D=32'hfe34c213; rst=1'b0;
	#2 $display("%g READ: Q=%h",$time,Q);
	#1 rst=1'b1;
	#2 $display("%g READ: Q=%h",$time,Q);
	#1 D=32'h2; rst=1'b0; 
	#2 $display("%g READ: Q=%h",$time,Q);
	//#2 $display("%g READ: Q=%h",$time,Q);
	#2 $finish;
end
endmodule


