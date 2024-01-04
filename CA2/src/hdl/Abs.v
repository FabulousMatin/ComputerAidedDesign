module Abs #(parameter bits) (
    input [bits - 1 : 0] A,
    input sign,

    output [bits - 1 : 0] out
);
    wire [bits - 1 : 0] negA;
    TwosComp #(bits) tc(A, negA);
    MUX2 #(bits) mx2(A, negA, sign, out);
endmodule