//1 MB Data Memory Module
module datamemory(clk,Add,MemWrite,MemRead,WriteData,ReadData);
	input [63:0]Add,WriteData;
	input MemRead,MemWrite,clk;
	output reg [63:0]ReadData;

	reg [63:0]DM[0:131071];

	always@(posedge clk)
	begin
		//Reading
		if(MemRead)
			ReadData <= DM[Add];
		//Writing
		if(MemWrite)
			DM[Add] <= WriteData;
	end
endmodule