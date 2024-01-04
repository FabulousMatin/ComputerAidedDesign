module AND6 (
    input  A, B, C, D, E, F,
    output out
);
    wire out_0;
    wire out_1;

    AND3 and3_0(A, B, C, out_0);
    AND3 and3_1(D, E, F, out_1);
    AND3 and3_2(out_0, out_1, 1, out);

endmodule
