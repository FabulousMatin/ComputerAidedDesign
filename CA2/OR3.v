module OR3 (
    input A, B, C,

    output out
);

    _ACT_C1 or3(A, 1, B, 1, 1, 1, C, 0, out);

endmodule