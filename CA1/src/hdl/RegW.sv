module RegW (
    input clock, read,
    
    output reg [31:0] w0 [3:0],
    output reg [31:0] w1 [3:0],
    output reg [31:0] w2 [3:0],
    output reg [31:0] w3 [3:0]
);

reg [31:0] w [0:3][3:0];
assign w0 = {w[0]};
assign w1 = {w[1]};
assign w2 = {w[2]};
assign w3 = {w[3]};

always @(clock) begin
    if(read)
        $readmemh("w.txt", w);
end
    
endmodule