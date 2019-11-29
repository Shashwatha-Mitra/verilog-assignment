`include "half_adder.v"					//including half adder file to import half adder module

module full_adder(a,b,cin,cout,sum);
	input a,b,cin;
	output cout,sum;
	wire temp,temp1,temp2;
	half_adder ha1(.a(a),.b(b),.sum(temp),.carry(temp1));		//ha1 calculates temp=a^b
	half_adder ha2(.a(temp),.b(cin),.sum(sum),.carry(temp2));	//ha2 calculates sum=temp^cin=a^b^cin
	or(cout,temp1,temp2);										//cout=temp1|temp2=ab|((a^b)&cin)
endmodule
