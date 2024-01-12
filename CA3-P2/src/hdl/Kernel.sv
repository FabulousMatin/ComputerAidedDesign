module Kernel #(parameter neurons) (
    input clock,
    input load [0 : neurons - 1],
    input [1:0] index,
    input [7:0] in [0:3],

    output reg [7:0] out [0 : neurons - 1][0:3][0:3]
);
    integer i;
    always @(posedge clock) begin
        for(i = 0; i < neurons; i = i + 1) begin
            if(load[i]) begin
                out[i][index] = in;
            end
        end
    end
endmodule