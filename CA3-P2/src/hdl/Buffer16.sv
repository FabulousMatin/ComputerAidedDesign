module Buffer16 (
    input clock, load,
    input [5:0] index,
    input [7:0] in [0:3],

    output reg [7:0] out [0:15][0:15]
);
    reg [3:0] col;
    reg [3:0] row;


    assign row = index / 4;
    assign col = 4 * (index % 4);
    
    integer i;
    always @(posedge clock) begin
        if(load) begin
            for (i = 0; i < 4; i = i + 1) begin
                out[row][col + i] = in[i];
            end
        end
    end

endmodule