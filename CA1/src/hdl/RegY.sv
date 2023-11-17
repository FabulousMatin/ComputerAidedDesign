module RegY (
    input clock, load,
    input [31:0] in [3:0],

    output reg [31:0] out [3:0]
);

always @(clock) begin
    if(load)
        out = in;
end
    
endmodule