module hello_world_tb;

initial 
begin	
	$dumpfile("hello.vcd");
	$dumpvars(0,hello_world_tb);
	repeat(100)
	#2	$display("%g Hello World",$time);
	$finish;
end
endmodule
