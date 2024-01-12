module PE #(parameter neurons) (
    input clock, reset, enable,
    input [1:0] row, col,
    input [7:0] A [0 : neurons - 1][0:3][0:3],
    input [7:0] B [0 : neurons - 1][0:3][0:3],

    output reg [7:0] res
);
    reg [7:0] mult_res [0 : neurons - 1];

    wire [7:0] muxOutA [0 : neurons - 1];
    wire [7:0] muxOutB [0 : neurons - 1];

    genvar i;
    generate
        for (i = 0; i < neurons; i = i + 1) begin: Muxs
            Mux16 mxA(A[i], row, col, muxOutA[i]);
            Mux16 mxB(B[i], row, col, muxOutB[i]);
        end
    endgenerate

    Mult #(neurons) mlt(
        muxOutA, 
        muxOutB, 
        mult_res
    );


    Sum #(neurons) sm(
        clock, reset, enable,
        mult_res,
        res
    );


endmodule