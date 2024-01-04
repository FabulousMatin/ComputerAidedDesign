module Filter (
    input clock, load,
    input [1:0] index,
    input [7:0] in [0:3],

    output reg [7:0] out [0:3][0:3]
);

    always @(posedge clock) begin
        if(load) begin
            out[index] = in;
        end
    end
endmodule