module MUX2 #(parameter bits) (
    input [bits - 1 : 0] A, B,
    input select,

    output [bits - 1 : 0] out
);

    _ACT_C2 #(bits) mux2(A, B, 'bz, 'bz, 0, 0, select, 1, out);

endmodule