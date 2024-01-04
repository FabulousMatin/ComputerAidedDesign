module _ACT_C1 (
    input A0, A1, SA, B0, B1, SB, S0, S1,

    output out
);
    
    wire F1, F2, S2;

    assign F1 = (SA == 1) ? A1 : A0;
    assign F2 = (SB == 1) ? B1 : B0;
    assign S2 = (S0 | S1);
    assign out = (S2 == 1) ? F2 : F1;

endmodule