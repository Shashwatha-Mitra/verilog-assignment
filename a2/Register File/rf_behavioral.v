module rf(regRNum1,regRNum2,wReg,Data,RegWrite,reset,clk,rData1,rData2);

	input [4:0]regRNum1,regRNum2,wReg;					//Register Numbers
	input [63:0]Data;									//Data
	input RegWrite,reset,clk;							//control signals
	output [63:0]rData1,rData2;							//outputs
	integer k;
	reg [63:0] regFile[0:31];							//register File


//ReadModule

	assign rData1=regFile[regRNum1];
	assign rData2=regFile[regRNum2];

//WriteModule
//Writes data only at the positive edge of the clock cycle and when write is 1

	always@(posedge clk)
	begin	
		if(reset)
		begin
			for(k=0;k<32;k=k+1)
			begin
				regFile[k] <= 64'b0;					//resets all registers to zero
			end
		end
		else
		begin
			if(RegWrite)
			begin
				regFile[wReg] <= Data;
			end
		end
	end

endmodule
