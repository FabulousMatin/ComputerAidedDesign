module Buffer8 (
    input clock, load,
    input [3:0] index,
    input [7:0] in [0:3],

    output reg [7:0] out [0:7][0:7]
);
    
    integer k;
    reg [7:0] i;
    reg [7:0] j;
    assign i = (4 * index) / 8;
    assign j = (4 * index) % 8;
    always @(posedge clock) begin
        if(load) begin
            for(k = 0; k <= 3; k = k + 1)
                out[i][j + k] = in[k];
        end
    end


endmodule