module dm_tb;
reg [63:0]Add,WriteData;
reg MemWrite,MemRead,clk;
wire [63:0]ReadData;

datamemory m0(clk,Add,MemWrite,MemRead,WriteData,ReadData);

initial 
begin
	$dumpfile("dm.vcd");
	$dumpvars(0,dm_tb);
end

initial 
begin
	clk=1'b1;
	repeat(100)
		#1 clk=~clk;
end

initial
begin
	#8
	#2	Add=64'haaae; 
		WriteData=64'hefa; 
		MemRead=1'b0; 
		MemWrite=1'b1;
	
	#2	$display("\nWRITE\nMemWrite=%b\nMemRead=%b\nData=%3h\nLocation=%2h",MemWrite,MemRead,WriteData,Add);
	
	#10	MemRead=1'b1; 
		MemWrite=1'b0; 
	
	#2	$display("\nREAD\nMemWrite=%b\nMemRead=%b\nLocation=%2h\nData=%3h",MemWrite,MemRead,Add,ReadData);

	#10	MemRead=1'b1; 
		MemWrite=1'b0; 
		Add=64'haf;
	#2	$display("\nREAD\nMemWrite=%b\nMemRead=%b\nLocation=%2h\nData=%3h",MemWrite,MemRead,Add,ReadData);
		
	#2	$finish;
end
endmodule