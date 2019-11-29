module alucu(op, funct, control);
    
    input [1:0]op;                              //op function
    input [2:0]funct;                           //minimal bits from the funct7 and funct3 fields
    output [3:0]control;
    wire [3:0]temp1,temp2;

    xor( temp1[0], funct[0], funct[1]);
    and( temp1[1], ~funct[1], ~funct[0]);
    assign temp1[2]=funct[2];
    and( temp1[3], funct[2], funct[1]);

    assign temp2[0]=op[1];
    assign temp2[1]=~op[1];
    assign temp2[2]=op[0];
    assign temp2[3]=op[1];

    assign control= op[1]?temp1:temp2;          //checks if aluop is 01/00 or 10 and returns the control signal to the ALU

endmodule

