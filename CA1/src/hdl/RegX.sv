module RegX (
    input clock, read, 
    output reg [31:0] out [3:0]
);

always @(clock) begin
    if(read)
        $readmemh("file/x.txt", out);
end
    
endmodule