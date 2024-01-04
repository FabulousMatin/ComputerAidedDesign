module TwosComp #(parameter bits) (
    input [bits - 1 : 0] A,

    output [bits - 1 : 0] out
);
    wire [bits : 0] res;
    wire [bits - 1 : 0] not_A;
    NOT #(bits) nt(A, not_A);
    Adder #(bits) adr(not_A, 0, 1'b1, res);
    assign out = res[bits - 1 : 0];

endmodule