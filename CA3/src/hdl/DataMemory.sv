module DataMemory #(parameter nkernel) (
    input clock, write, writeOut,
    input [7:0] address,
    input [1:0] offset,
    input [7:0] in [0 : nkernel - 1],

    output reg [7:0] out [0:3]
);

    reg [31:0] data [0:127];
    reg [31:0] memout [0 : nkernel - 1][0:127];

    integer i, j;
    initial begin
        $readmemh("file/input.txt", data);
        for (i = 0; i < nkernel; i = i + 1) begin
            for (j = 0; j < 128; j = j + 1) begin
                memout[i][j] = 32'b0;
            end
        end
    end

    
    assign out[0] = data[address][31:24];
    assign out[1] = data[address][23:16];
    assign out[2] = data[address][15:8];
    assign out[3] = data[address][7:0];

    always @(posedge clock) begin
        if(write) begin;
            for (i = 0; i < nkernel; i = i + 1) begin
                case (offset)
                    0: memout[i][address][31:24] = in[i];
                    1: memout[i][address][23:16] = in[i];
                    2: memout[i][address][15:8] = in[i];
                    3: memout[i][address][7:0] = in[i];
                    default: memout = memout;
                endcase
            end
        end
        if(writeOut) begin
            string output_file;
            for (i = 0; i < nkernel; i = i + 1) begin
                output_file = $sformatf("file/output%1d.txt", i + 1);
                $writememh(output_file, memout[i]);
            end
        end
    end
endmodule