module OFM #(parameter n_th) (
    input clock, write, writeOut,
    input [7:0] address,
    input [1:0] offset,
    input [7:0] in
);
    reg [31:0] ofm [0:127];

    always @(posedge clock) begin
        if(write) begin;
            case (offset)
                0: ofm[address][31:24] = in;
                1: ofm[address][23:16] = in;
                2: ofm[address][15: 8] = in;
                3: ofm[address][7 : 0] = in;
                default: ofm = ofm;
            endcase
        end
        if(writeOut) begin
            string output_file;
            output_file = $sformatf("file/output%1d_L2.txt", n_th);
            $writememh(output_file, ofm);
        end
    end
endmodule