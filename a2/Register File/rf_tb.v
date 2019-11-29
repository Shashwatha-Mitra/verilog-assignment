module rf_tb;
reg [4:0]regRNum1,regRNum2,wReg;
reg [63:0]data;
reg RegWrite,clk,reset;
wire [63:0]rData1,rData2;
integer k;

rf m0(regRNum1,regRNum2,wReg,data,RegWrite,reset,clk,rData1,rData2);

initial 
begin
	clk=1'b0;
	repeat(120)
		#5 clk = ~clk;
end

initial
begin
	$dumpfile("rf.vcd");
	$dumpvars(0,rf_tb);
	#1 reset = 1'b1; RegWrite=1'b0;
	#5 reset = 1'b0;
end

initial
begin
	#7
	for(k=0;k<32;k=k+1)
	begin
		wReg=k;
		data=k*10;
		RegWrite=1;
		#10 RegWrite=0;
	end
end

initial
begin
	#350
	for(k=0;k<32;k=k+2)
	begin
		regRNum1=k;
		regRNum2=k+1;
		#5;
		$display("reg[%2d]=%3d, reg[%2d]=%3d",regRNum1,rData1,regRNum2,rData2);
	end
end

initial 
begin	
	#450 $finish;
end

endmodule
