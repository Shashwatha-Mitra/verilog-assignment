module half_adder_tb;
reg a,b;
wire sum,carry;

half_adder a1(.a(a),.b(b),.sum(sum),.carry(carry));

initial
begin
	$dumpfile("half_adder.vcd");
	$dumpvars(0,half_adder_tb);
	a=1'b0;
	b=1'b0;
	#2 $display("%g a=%b b=%b sum=%b carry=%b",$time,a,b,sum,carry);
	a=1'b0;
	b=1'b1;
	#2 $display("%g a=%b b=%b sum=%b carry=%b",$time,a,b,sum,carry);
	a=1'b1;
	b=1'b0;
	#2 $display("%g a=%b b=%b sum=%b carry=%b",$time,a,b,sum,carry);
	a=1'b1;
	b=1'b1;
	#2 $display("%g a=%b b=%b sum=%b carry=%b",$time,a,b,sum,carry);
	#15 $finish; 
end
endmodule