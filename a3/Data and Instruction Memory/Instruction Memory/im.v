//1 MB Instruction Memory Module
module instmemory(clk,rst,PC,instruction,New_PC);
	input clk,rst;
	input [63:0]PC;
	output reg [31:0]instruction;
	output reg [63:0]New_PC;

	reg [31:0]IM[0:262143];
	
	always@(posedge clk)
	begin

		//New PC value generation
		New_PC = PC+1;

		//Assigning some initial PC values
		IM[10] <= 32'b00000000011000111000001100110011;
		IM[11] <= 32'b01000000011000111000001100110011;
		IM[12] <= 32'b00000000000100010111000110110011;
		IM[13] <= 32'b00000000000100010110000110110011;
		IM[14] <= 32'b01000000010000101110001100110011;
		IM[15] <= 32'b01000000010000101111001110110011;
		IM[16] <= 32'b00110011010100100000001010010011;
		IM[17] <= 32'b00000000000000010011000110000011;
		IM[18] <= 32'b00000000000100010000001001100111;
		
		//Updates the instruction memory if reset is 0
		if(!rst)
			instruction <= IM[PC];
		else
			New_PC <= 64'b0;
	
	end
endmodule