module full_adder_tb;
reg a,b,cin;
wire sum,cout;

full_adder a1(.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));

initial
begin
	$dumpfile("full_adder.vcd");
	$dumpvars(0,full_adder_tb);
	a=1'b0;
	b=1'b0;
	cin=1'b0;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	a=1'b0;
	b=1'b0;
	cin=1'b1;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	a=1'b0;
	b=1'b1;
	cin=1'b0;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	a=1'b0;
	b=1'b1;
	cin=1'b1;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	a=1'b1;
	b=1'b0;
	cin=1'b0;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	a=1'b1;
	b=1'b0;
	cin=1'b1;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	a=1'b1;
	b=1'b1;
	cin=1'b0;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	a=1'b1;
	b=1'b1;
	cin=1'b1;
	#2 $display("%g a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	#24 $finish; 
end
endmodule