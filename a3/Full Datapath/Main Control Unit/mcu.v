/*-----------------------------------------------------------------------
Assignment 3: Question 1
File Name   : mcu.v
Function    : Building the Main Control Unit for complete RISCV Datapath     
Done by     : Shashwatha Mitra G B (171CO144)
		      Rohit M P (171CO136)
-------------------------------------------------------------------------*/


module mcu(I,rst,clk,alusrc,memToReg,regWrite,memRead,memWrite,branch,aluOP);

	input [31:0]I;
	input rst, clk;
	output alusrc, memToReg, regWrite, memWrite, memRead, branch;
	output [1:0]aluOP;	

	assign alusrc   = (~I[4] & ~I[6]) | (~I[5] & ~I[6]);
	assign memToReg = ~(I[6] | I[5] | I[4]);
	assign regWrite = (I[5] & I[4]) | (~I[5] & ~I[4]) | (~I[5] & ~I[6]);
	assign memRead  = ~(I[6] | I[5] | I[4]);
	assign memWrite = ~(I[6] | ~I[5] | I[4]);
	assign branch   = I[6] & I[5] & ~I[4];
	assign aluOP[1] = ~I[6] & I[4];
	assign aluOP[0] = I[6] & I[5] & ~I[4];
	
endmodule