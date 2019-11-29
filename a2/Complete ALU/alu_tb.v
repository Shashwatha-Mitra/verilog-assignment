module alu_tb;
reg [63:0]a,b;
reg [1:0]op;
reg [2:0]funct;
reg cin;
wire [63:0]result;
wire cout,overflow,zero;

completeALU a0(a,b,cin,op,funct,result,cout,zero,overflow);

initial 
begin
    $dumpfile("alu.vcd");
    $dumpvars(0,alu_tb);

	//andGate
	$display("%g AND:",$time);
	op=2'b10; funct=3'b011;
	a=64'hffffffffffffffff; b=64'h3;
	#2 $display("%g  op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321;
	#2 $display("%g  op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);
	
	//orGate
	$display("%g OR:",$time);
	op=2'b10; funct=3'b010;
	a=64'hffffffffffffffff; b=64'h3;
	#2 $display("%g  op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321;
	#2 $display("%g  op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);
	
	//add
	$display("%g ADD:",$time);
	op=2'b10; funct=3'b000;
	a=64'hffffffffffffffff; b=64'h8000000000000000;
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h overflow=%b zero=%b",$time,op,funct,a,b,result,overflow,zero);
	a=64'h123456789abcdef; b=64'hfedcba987654321;
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h overflow=%b zero=%b",$time,op,funct,a,b,result,overflow,zero);

	//subtract
	$display("%g SUB:",$time);
	op=2'b10; funct=3'b100;
	a=64'hffffffffffffffff; b=64'h8000000000000000;
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h overflow=%b zero=%b",$time,op,funct,a,b,result,overflow,zero);
	a=64'h123456789abcdef; b=64'hfedcba987654321;
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h overflow=%b zero=%b",$time,op,funct,a,b,result,overflow,zero);
	
	//NAND
	$display("%g NAND:",$time);
	op=2'b10; funct=3'b110;
	a=64'hffffffffffffffff; b=64'h3;
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321;
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);

	//NOR
	$display("%g NOR:",$time);
	op=2'b10; funct=3'b111;
	a=64'hffffffffffffffff; b=64'h3; 
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321; 
	#2 $display("%g op=%b | funct=%b | a=%h b=%h result=%h",$time,op,funct,a,b,result);
	
end

endmodule