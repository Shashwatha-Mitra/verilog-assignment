module alu_tb;
reg a,b;
reg [3:0]control;
wire result,cout;

alu m0(a,b,control[2],control,result,cout);

initial
begin
	$dumpfile("alu.vcd");
	$dumpvars(0,alu_tb);
	
	//andGate
	$display("%g AND:",$time);
	a=1'b0; b=1'b0; control=4'b0000;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b0; b=1'b1; control=4'b0000;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b0; control=4'b0000;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b1; control=4'b0000;
	#2 $display("%g a=%b b=%b control=%b result=%b\n",$time,a,b,control,result);
	
	//orGate
	$display("%g OR:",$time);
	a=1'b0; b=1'b0; control=4'b0001;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b0; b=1'b1; control=4'b0001;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b0; control=4'b0001;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b1; control=4'b0001;
	#2 $display("%g a=%b b=%b control=%b result=%b\n",$time,a,b,control,result);
	
	//add
	$display("%g ADD:",$time);
	a=1'b0; b=1'b0; control=4'b0010;
	#2 $display("%g a=%b b=%b control=%b result=%b cout=%b",$time,a,b,control,result,cout);
	a=1'b0; b=1'b1; control=4'b0010;
	#2 $display("%g a=%b b=%b control=%b result=%b cout=%b",$time,a,b,control,result,cout);
	a=1'b1; b=1'b0; control=4'b0010;
	#2 $display("%g a=%b b=%b control=%b result=%b cout=%b",$time,a,b,control,result,cout);
	a=1'b1; b=1'b1; control=4'b0010;
	#2 $display("%g a=%b b=%b control=%b result=%b cout=%b\n",$time,a,b,control,result,cout);

	//subtract
	$display("%g SUB:",$time);
	a=1'b0; b=1'b0; control=4'b0110;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b0; b=1'b1; control=4'b0110;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b0; control=4'b0110;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b1; control=4'b0110;
	#2 $display("%g a=%b b=%b control=%b result=%b\n",$time,a,b,control,result);
	
	//slt
	$display("%g SLT:",$time);
	a=1'b0; b=1'b0; control=4'b0111;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b0; b=1'b1; control=4'b0111;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b0; control=4'b0111;
	#2 $display("%g a=%b b=%b control=%b result=%b",$time,a,b,control,result);
	a=1'b1; b=1'b1; control=4'b0111;
	#2 $display("%g a=%b b=%b control=%b result=%b\n",$time,a,b,control,result);

	#2 $finish;
end
endmodule