module XOR2 (
    input A, B,

    output out
);

    _ACT_C1 xor2(0, 1, B, 1, 0, B, A, 0, out);

endmodule