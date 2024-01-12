module Mult #(parameter neurons) (
    input [7:0] A [0 : neurons - 1],
    input [7:0] B [0 : neurons - 1],

    output reg [7:0] res [0 : neurons - 1] 
);
    reg [15:0] mult_res [0 : neurons - 1];
    genvar i;
    generate
        for (i = 0; i < neurons; i = i + 1) begin: mults
            assign mult_res[i] = A[i] * B[i];
            assign res[i] = mult_res[i][15:8];
        end
    endgenerate
    

endmodule