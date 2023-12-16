module MUX4 #(parameter bits = 1) (
    input [bits - 1 : 0] A, B, C, D,
    input [1:0] select,

    output [bits - 1 : 0] out
);
    // S1S0
    //  00 -> A
    //  01 -> B
    //  10 -> C
    //  11 -> D
    
    _ACT_C2 #(bits) mux4(A, B, C, D, select[1], 0, select[0], 1, out);

endmodule