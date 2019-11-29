module alucu_tb;
reg [1:0]op;
reg [2:0]funct;
wire [3:0]control;

alucu m0(op,funct,control);

initial
begin
    $dumpfile("alucu.vcd");
    $dumpvars(0,alucu_tb);
    op=2'b00; funct=3'b111;
    #10 $display("%g R type(load/store) | control: %b", $time, control);
    op=2'b01; funct=3'b010;
    #10 $display("%g R type(beq)        | control: %b", $time, control);
    op=2'b10; funct=3'b000;
    #10 $display("%g R type(add)        | control: %b", $time, control);
    op=2'b10; funct=3'b100;
    #10 $display("%g R type(sub)        | control: %b", $time, control);
    op=2'b10; funct=3'b011;
    #10 $display("%g R type(and)        | control: %b", $time, control);
    op=2'b10; funct=3'b010;
    #10 $display("%g R type(or)         | control: %b", $time, control);
    op=2'b10; funct=3'b110;
    #10 $display("%g R type(nand)       | control: %b", $time, control);
    op=2'b10; funct=3'b111;
    #10 $display("%g R type(nor)        | control: %b", $time, control);
    $finish;
end
endmodule
