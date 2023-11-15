module ProcessUnit (
    input clock, load_mult, load_sum,
    input [31:0] x[3:0],
    input [31:0] w[3:0],

    output s,
    output [31:0] out
);
    reg [31:0] mult_res[3:0];
    reg [31:0] sum_res;

    wire [31:0] y_mult_1, y_mult_2, y_mult_3, y_mult_4;
    wire [31:0] y_sum_1, y_sum_2, y_sum;

    assign y_mult_1 = x[0] * w[0];
    assign y_mult_2 = x[1] * w[1];
    assign y_mult_3 = x[2] * w[2];
    assign y_mult_4 = x[3] * w[3];

    assign y_sum_1 = mult_res[0] + mult_res[1];
    assign y_sum_2 = mult_res[2] + mult_res[3];
    assign y_sum = y_sum_1 + y_sum_2;

    always @(clock) begin
        if(load_mult) begin
            mult_res[0] = y_mult_1;
            mult_res[1] = y_mult_2;
            mult_res[2] = y_mult_3;
            mult_res[3] = y_mult_4;
        end
        else if(load_sum)
            sum_res = y_sum;
    end 
    
    assign out = (y_sum > 0) ? y_sum : 0;
    assign s = (out == 32'b0) ? 1 : 0;
endmodule