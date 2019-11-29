module alu64_tb;
reg [63:0]a,b;
reg [3:0]control;
wire [63:0]result;
wire cout,overflow,zero;

alu64 m0(a,b,control[2],control,result,cout,zero,overflow);

initial
begin
	$dumpfile("alu64.vcd");
	$dumpvars(0,alu64_tb);

	//andGate
	$display("%g AND:",$time);
	a=64'hffffffffffffffff; b=64'h3; control=4'b0000;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321; control=4'b0000;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);
	
	//orGate
	$display("%g OR:",$time);
	a=64'hffffffffffffffff; b=64'h3; control=4'b0001;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321; control=4'b0001;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);
	
	//add
	$display("%g ADD:",$time);
	a=64'hffffffffffffffff; b=64'h8000000000000000; control=4'b0010;
	#2 $display("%g a=%h b=%h control=%b result=%h overflow=%b zero=%b",$time,a,b,control,result,overflow,zero);
	a=64'h123456789abcdef; b=64'hfedcba987654321; control=4'b0010;
	#2 $display("%g a=%h b=%h control=%b result=%h overflow=%b zero=%b",$time,a,b,control,result,overflow,zero);

	//subtract
	$display("%g SUB:",$time);
	a=64'hffffffffffffffff; b=64'h8000000000000000; control=4'b0110;
	#2 $display("%g a=%h b=%h control=%b result=%h overflow=%b zero=%b",$time,a,b,control,result,overflow,zero);
	a=64'h123456789abcdef; b=64'hfedcba987654321; control=4'b0110;
	#2 $display("%g a=%h b=%h control=%b result=%h overflow=%b zero=%b",$time,a,b,control,result,overflow,zero);
	
	//NAND
	$display("%g NAND:",$time);
	a=64'hffffffffffffffff; b=64'h3; control=4'b1101;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321; control=4'b1101;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);

	//NOR
	$display("%g NOR:",$time);
	a=64'hffffffffffffffff; b=64'h3; control=4'b1100;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);
	a=64'h123456789abcdef; b=64'hfedcba987654321; control=4'b1100;
	#2 $display("%g a=%h b=%h control=%b result=%h",$time,a,b,control,result);
	
end
endmodule