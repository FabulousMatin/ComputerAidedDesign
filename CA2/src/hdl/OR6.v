module OR6 (
    input  A, B, C, D, E, F,
    output out
);
    wire out_0;
    wire out_1;

    OR3 or3_0(A, B, C, out_0);
    OR3 or3_1(D, E, F, out_1);
    OR3 or3_2(out_0, out_1, 0, out);

endmodule
