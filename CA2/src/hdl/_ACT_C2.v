module _ACT_C2 #(parameter bits) (
    input [bits - 1 : 0] D00,
    input [bits - 1 : 0] D01,
    input [bits - 1 : 0] D10,
    input [bits - 1 : 0] D11,
    input A1, B1, A0, B0,
    
    output [bits - 1 : 0] out
);
    wire S0, S1;
    assign S0 = (A0 & B0);
    assign S1 = (A1 | B1);

    assign out = (S1 == 0 & S0 == 0) ? D00 :
                 (S1 == 0 & S0 == 1) ? D01 :
                 (S1 == 1 & S0 == 0) ? D10 :
                 (S1 == 1 & S0 == 1) ? D11 : 'bz;
endmodule
