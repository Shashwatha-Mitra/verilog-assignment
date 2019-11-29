module half_adder(a,b,sum,carry);
	output sum,carry;		//outputs
	input a,b;				//inputs
	assign sum=a^b;			
	assign carry=a&b;
endmodule
