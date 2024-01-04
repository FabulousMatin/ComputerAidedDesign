module Sum (
    input clock, reset, enable,
    input [7:0] A,

    output reg [7:0] res
);

    reg[11:0] sum_res;
    always @(posedge clock) begin
        if(reset)
            sum_res = 0;
        else if(enable)
            sum_res = sum_res + A;
    end

    assign res = sum_res[11:4];
endmodule