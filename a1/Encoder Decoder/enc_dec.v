module priority_encoder(in,out);     
	input [15:0]in;     				//inputs
	output [3:0]out;					//outputs
	reg [3:0]out;
	always@(in)
	begin
			 if(in[15]) out=4'hf;		//in=1000000000000000 => out=1111
		else if(in[14]) out=4'he;		//in=0100000000000000 => out=1110
		else if(in[13]) out=4'hd;		//in=0010000000000000 => out=1101
		else if(in[12]) out=4'hc;		//in=0001000000000000 => out=1100
		else if(in[11]) out=4'hb;		//in=0000100000000000 => out=1011
		else if(in[10]) out=4'ha;		//in=0000010000000000 => out=1010
		else if(in[9])  out=4'h9;		//in=0000001000000000 => out=1001
		else if(in[8])  out=4'h8;		//in=0000000100000000 => out=1000
		else if(in[7])  out=4'h7;		//in=0000000010000000 => out=0111
		else if(in[6])  out=4'h6;		//in=0000000001000000 => out=0110
		else if(in[5])  out=4'h5;		//in=0000000000100000 => out=0101
		else if(in[4])  out=4'h4;		//in=0000000000010000 => out=0100
		else if(in[3])  out=4'h3;		//in=0000000000001000 => out=0011
		else if(in[2])  out=4'h2;		//in=0000000000000100 => out=0010
		else if(in[1])  out=4'h1;		//in=0000000000000010 => out=0001
		else if(in[0])  out=4'h0;		//in=0000000000000001 => out=0000
	end
endmodule

module decoder(in,out);
	input [3:0]in;						//inputs
	output [15:0]out;					//outputs
	//the next 16 lines define each bit of the output as a combination of the 4 input bits
	assign out[15] = in[3] & in[2] & in[1] & in[0];
	assign out[14] = in[3] & in[2] & in[1] & (~in[0]);
	assign out[13] = in[3] & in[2] & (~in[1]) & in[0];
	assign out[12] = in[3] & in[2] & (~in[1]) & (~in[0]);
	assign out[11] = in[3] & (~in[2]) & in[1] & in[0];
	assign out[10] = in[3] & (~in[2]) & in[1] & (~in[0]);
	assign out[9] = in[3] & (~in[2]) & (~in[1]) & in[0];
	assign out[8] = in[3] & (~in[2]) & (~in[1]) & (~in[0]);
	assign out[7] = (~in[3]) & in[2] & in[1] & in[0];
	assign out[6] = (~in[3]) & in[2] & in[1] & (~in[0]);
	assign out[5] = (~in[3]) & in[2] & (~in[1]) & in[0];
	assign out[4] = (~in[3]) & in[2] & (~in[1]) & (~in[0]);
	assign out[3] = (~in[3]) & (~in[2]) & in[1] & in[0];
	assign out[2] = (~in[3]) & (~in[2]) & in[1] & (~in[0]);
	assign out[1] = (~in[3]) & (~in[2]) & (~in[1]) & in[0];
	assign out[0] = (~in[3]) & (~in[2]) & (~in[1]) & (~in[0]);
endmodule
