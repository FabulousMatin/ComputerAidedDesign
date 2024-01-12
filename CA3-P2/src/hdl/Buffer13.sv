module Buffer13 (
    input clock, load,
    input [5:0] index,
    input [7:0] in [0:3],

    output reg [7:0] out [0:12][0:12]
);
    reg [3:0] col;
    reg [3:0] row;

    
    integer i;
    always @(posedge clock) begin
        if(load && index == 43) begin
            out[12][12] = in[0];
        end
        else if(load) begin
            for (i = 0; i < 4; i = i + 1) begin
                row = (4 * index + i) / 13;
                col = (4 * index + i) % 13;
                out[row][col] = in[i];
            end
        end
    end

endmodule