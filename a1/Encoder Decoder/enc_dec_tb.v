module enc_dec_tb;
reg [4:0]in_dec;
wire [31:0]out_dec;

Decoder5x32 m2(in_dec,out_dec);

initial
begin
	$dumpfile("enc_dec.vcd");
	$dumpvars(0,enc_dec_tb);
	in_dec=5'b10111; 
	#5 $display("%g DECODER: input=%b output=%b",$time,in_dec,out_dec);
	#5 in_dec=5'b0; 
	#5 $display("%g DECODER: input=%b output=%b",$time,in_dec,out_dec);
	#5 $finish;
end
endmodule