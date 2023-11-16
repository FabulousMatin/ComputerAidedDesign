module ProcessUnit (
    input clock, load_mult, load_sum,
    input [31:0] x[3:0],
    input [31:0] w[3:0],

    output s,
    output [31:0] out
);
    reg [31:0] mult_res[3:0];
    reg [31:0] sum_res;

    wire [31:0] y_mult_0, y_mult_1, y_mult_2, y_mult_3;
    wire [31:0] y_sum_1, y_sum_2, y_sum;

    wire ofm0, ofm1, ofm2, ofm3;// overflow mult
    wire ufm0, ufm1, ufm2, ufm3;// underflow mult
    wire exm0, exm1, exm2, exm3;// exception mult
    FPMultiplication fpm0(x[0], w[0], ofm0, ufm0, exm0, y_mult_0);
    FPMultiplication fpm1(x[1], w[1], ofm1, ufm1, exm1, y_mult_1);
    FPMultiplication fpm2(x[2], w[2], ofm2, ufm2, exm2, y_mult_2);
    FPMultiplication fpm3(x[3], w[3], ofm3, ufm3, exm3, y_mult_3);

    wire ofa0, ofa1, ofa2;// overflow add
    wire ufa0, ufa1, ufa2;// underflow add
    wire exa0, exa1, exa2;// exception add
    FPAddition fpa0(mult_res[0], mult_res[1], ofa0, ufa0, exa0, y_sum_1);
    FPAddition fpa1(mult_res[2], mult_res[3], ofa1, ufa1, exa1, y_sum_2);
    FPAddition fpa2(y_sum_1, y_sum_2, ofa2, ufa2, exa2, y_sum);

    always @(clock) begin
        if(load_mult) begin
            mult_res[0] = y_mult_0;
            mult_res[1] = y_mult_1;
            mult_res[2] = y_mult_2;
            mult_res[3] = y_mult_3;
        end
        else if(load_sum)
            sum_res = y_sum;
    end 
    
    assign out = (sum_res[31] == 0) ? sum_res : 32'b0;
    assign s = (out == 32'b0) ? 0 : 1;
endmodule