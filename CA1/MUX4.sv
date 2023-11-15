module MUX4 (
    input [31:0] data_in1, data_in2, data_in3, data_in4,
    input [3:0] select,
    output reg [31:0] data_out
);
    always @(*) begin
        case (select)
            4'b1000: data_out = data_in1;
            4'b0100: data_out = data_in2;
            4'b0010: data_out = data_in3;
            4'b0001: data_out = data_in4;
            default: data_out = 32'bz;
        endcase
    end
endmodule