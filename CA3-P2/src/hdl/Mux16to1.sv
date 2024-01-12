module Mux16 (
    input [7:0] in [0:3][0:3],
    input [1:0] i, j,
    output [7:0] out
);
    assign out = in[i][j];
    
endmodule