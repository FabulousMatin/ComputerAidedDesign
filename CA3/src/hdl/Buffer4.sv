module Buffer4 (
    input clock, load,
    input [7:0] in [0:3][0:3],

    output reg [7:0] out [0:3][0:3]
);
    
    
    always @(posedge clock) begin
        if(load) begin
            out = in;
        end
    end

endmodule