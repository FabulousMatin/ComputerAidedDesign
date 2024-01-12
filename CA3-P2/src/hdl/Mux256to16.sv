module Mux256 (
    input [7:0] in [0:15][0:15],
    input [3:0] k, q,

    output reg [7:0] out [0:3][0:3]
);
    integer i, j;
    always @(*) begin
        for (i = 0; i <= 3; i = i + 1) begin
            for (j = 0; j <= 3; j = j + 1) begin
                out[i][j] = in[i + k][j + q];
            end
        end
    end
    
endmodule