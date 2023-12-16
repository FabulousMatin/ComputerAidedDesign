module Adder (
    input A, B, carry_in,

    output sum, carry_out
);
    wire w1, w2, w3;

    XOR2 x1(A, B, w1);
    XOR2 x2(w1, carry_in, sum);
    AND3 a1(1, w1, carry_in, w2);
    AND3 a2(1, A, B, w3);
    OR3 o1(0, w2, w3, carry_out);
    
endmodule