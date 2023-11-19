module ProcessUnit (
    input clock, load_mult, load_sum,
    input [31:0] x[3:0],
    input [31:0] w[3:0],

    output s,
    output [31:0] out
);
    reg [31:0] mult_reg[3:0];
    reg [31:0] sum_reg;

    wire [31:0] mult_res_0, mult_res_1, mult_res_2, mult_res_3;
    wire [31:0] sum_res_1, sum_res_2, sum_res;

    FPMultiplication fpm0(x[0], w[0], mult_res_0);
    FPMultiplication fpm1(x[1], w[1], mult_res_1);
    FPMultiplication fpm2(x[2], w[2], mult_res_2);
    FPMultiplication fpm3(x[3], w[3], mult_res_3);

    FPAddition fpa0(mult_reg[0], mult_reg[1], sum_res_1);
    FPAddition fpa1(mult_reg[2], mult_reg[3], sum_res_2);
    FPAddition fpa2(sum_res_1, sum_res_2, sum_res);

    always @(clock) begin
        if(load_mult) begin
            mult_reg[0] = mult_res_0;
            mult_reg[1] = mult_res_1;
            mult_reg[2] = mult_res_2;
            mult_reg[3] = mult_res_3;
        end
        else if(load_sum)
            sum_reg = sum_res;
    end 
    
    assign out = (sum_reg[31] == 0) ? sum_reg : 32'b0;
    assign s = (out == 32'b0) ? 0 : 1;
endmodule