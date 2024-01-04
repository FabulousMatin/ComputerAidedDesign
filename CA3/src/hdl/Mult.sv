module Mult (
    input [7:0] A,
    input [7:0] B,

    output reg [7:0] res 
);
    reg [15:0] mult_res;

    assign mult_res = A * B;
    assign res = mult_res[15:8];

endmodule