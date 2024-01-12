module DataMemory (
    input clock, load,
    input [7:0] address,
 
    output reg [7:0] out [0:3]
);

    reg [31:0] datamem [0:127];

    integer  i;
    initial begin
        $readmemh("file/input.txt", datamem);
    end
    
    assign out[0] = (load == 1) ? datamem[address][31:24] : 8'bz;
    assign out[1] = (load == 1) ? datamem[address][23:16] : 8'bz;
    assign out[2] = (load == 1) ? datamem[address][15: 8] : 8'bz;
    assign out[3] = (load == 1) ? datamem[address][7 : 0] : 8'bz;
    
endmodule