module _ACT_S2 #(parameter bits = 2) (
    input clock, reset,
    input [bits - 1 : 0] D00, D01, D10, D11,
    input A1, B1, A0, B0,

    output reg [bits - 1 : 0] out
);
    wire S0, S1;
    wire [bits - 1 : 0] D;

    assign S0 = (A0 & B0);
    assign S1 = (A1 | B1);

    assign D = (S0 == 0 & S1 == 0) ? D00 :
               (S0 == 0 & S1 == 1) ? D01 :
               (S0 == 1 & S1 == 0) ? D10 :
               (S0 == 1 & S1 == 1) ? D11 : 'bz;

    always @(posedge clock) begin
        if(reset)
            out = 0;
        else
            out = D;
    end
endmodule