module RegX (
    input clock, read, 
    output reg [4:0] out [3:0]
);

    reg [4:0] to_save [3:0];

    always @(posedge clock) begin
        if(read)
            $readmemb("files/x.txt", to_save);
    end

    assign out = to_save;
endmodule