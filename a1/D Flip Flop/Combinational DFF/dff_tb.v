module dff_tb;
reg D,clk;
wire Q,Qbar;

dff m1(D,clk,Q,Qbar);

initial
begin
	$dumpfile("dff.vcd");
	$dumpvars(0,dff_tb);
	D=1'b1; clk=1'b1; 
	$monitor("%g D=%b clk=%b Q=%b Qbar=%b",$time,D,clk,Q,Qbar);
	#5 D=1'b1; clk=1'b0;
	$monitor("%g D=%b clk=%b Q=%b Qbar=%b",$time,D,clk,Q,Qbar);
	#5 D=1'b0; clk=1'b1; 
	$monitor("%g D=%b clk=%b Q=%b Qbar=%b",$time,D,clk,Q,Qbar);
	#5 D=1'b0; clk=1'b0;
	$monitor("%g D=%b clk=%b Q=%b Qbar=%b",$time,D,clk,Q,Qbar);
	#5 D=1'b1; clk=1'b1;
	$monitor("%g D=%b clk=%b Q=%b Qbar=%b",$time,D,clk,Q,Qbar);
	#5 D=1'b1; clk=1'b0;
	$monitor("%g D=%b clk=%b Q=%b Qbar=%b",$time,D,clk,Q,Qbar);
	#5 $finish;
end
endmodule