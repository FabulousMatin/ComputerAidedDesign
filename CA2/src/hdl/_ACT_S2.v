module _ACT_S2 #(parameter bits) (

    input clock, reset,
    input [bits - 1 : 0] D00,
    input [bits - 1 : 0] D01,
    input [bits - 1 : 0] D10,
    input [bits - 1 : 0] D11,
    input A1, B1, A0, B0,

    output reg [bits - 1 : 0] out
);
    wire S0, S1;
    wire [bits - 1 : 0] D;
    assign S0 = (A0 & B0);
    assign S1 = (A1 | B1);

    assign D = (S1 == 0 & S0 == 0) ? D00 :
               (S1 == 0 & S0 == 1) ? D01 :
               (S1 == 1 & S0 == 0) ? D10 :
               (S1 == 1 & S0 == 1) ? D11 : 'bz;

    always @(posedge clock, posedge reset) begin
        if (reset) 
            out = 0;
        else 
            out = D;
    end
endmodule
