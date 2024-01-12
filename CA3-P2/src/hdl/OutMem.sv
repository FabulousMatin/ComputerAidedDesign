module OutMem #(parameter n_th) (
    input clock, write, load, read, writeOut,
    input [7:0] address,
    input [7:0] M,
    input [1:0] offset,
    input [7:0] in,

    output reg [7:0] out [0:3]
);

    reg [31:0] memout [0:127];
    integer i;

    assign out[0] = (load == 1) ? memout[address][31:24] : 8'bz;
    assign out[1] = (load == 1) ? memout[address][23:16] : 8'bz;
    assign out[2] = (load == 1) ? memout[address][15: 8] : 8'bz;
    assign out[3] = (load == 1) ? memout[address][7 : 0] : 8'bz;

    always @(posedge clock) begin
        if(write) begin;
            case (offset)
                0: memout[address][31:24] = in;
                1: memout[address][23:16] = in;
                2: memout[address][15:08] = in;
                3: memout[address][07:00] = in;
                default: memout = memout;
            endcase
        end
        else if(read) begin
            string input_file;
            input_file = $sformatf("file/filter%1d_L2.txt", n_th);
            $readmemh(input_file, memout, M, M + 15);
        end
        else if(writeOut) begin
            string output_file;
            output_file = $sformatf("file/output%1d_L1.txt", n_th);
            $writememh(output_file, memout);
        end
    end
endmodule