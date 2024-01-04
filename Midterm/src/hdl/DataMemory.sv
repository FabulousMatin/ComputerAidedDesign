module DataMemory (
    input clock, load, write,
    input [7:0] address,
    input [1:0] offset,
    input [7:0] in,

    output reg [7:0] out [0:3]
);

    reg [31:0] data [0:127];

    integer  i;
    initial begin
        $readmemh("file/input1.txt", data);
    end

    
    assign out[0] = data[address][31:24];
    assign out[1] = data[address][23:16];
    assign out[2] = data[address][15:8];
    assign out[3] = data[address][7:0];

    always @(posedge clock) begin
        if(write) begin;
            case (offset)
                0: data[address][31:24] = in;
                1: data[address][23:16] = in;
                2: data[address][15:8] = in;
                3: data[address][7:0] = in;
                default: data = data;
            endcase
            
        end
    end
endmodule