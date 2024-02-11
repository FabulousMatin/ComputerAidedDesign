module ProcessUnit (
    input clock, load_mult, load_sum,
    input [4:0] x[3:0],
    input [4:0] w[3:0],

    output s,
    output [4:0] out
);

    wire [9:0] mult_res_0, mult_res_1, mult_res_2, mult_res_3;
    wire sign_mult_0, sign_mult_1, sign_mult_2, sign_mult_3;
    wire [9:0] mult_res_0_in, mult_res_1_in, mult_res_2_in, mult_res_3_in;
    wire [9:0] mult_res_0_out, mult_res_1_out, mult_res_2_out, mult_res_3_out;

    wire [4:0] x_abs[3:0];
    wire [4:0] w_abs[3:0];
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin: abser
            Abs #(5) absoluteX(x[i], x[i][4], x_abs[i]);
            Abs #(5) absoluteW(w[i], w[i][4], w_abs[i]);
        end
    endgenerate

    Multiplier #(5) fpm0(x_abs[0], w_abs[0], mult_res_0);
    Multiplier #(5) fpm1(x_abs[1], w_abs[1], mult_res_1);
    Multiplier #(5) fpm2(x_abs[2], w_abs[2], mult_res_2);
    Multiplier #(5) fpm3(x_abs[3], w_abs[3], mult_res_3);

    XOR2 xr0(x[0][4], w[0][4], sign_mult_0);
    XOR2 xr1(x[1][4], w[1][4], sign_mult_1);
    XOR2 xr2(x[2][4], w[2][4], sign_mult_2);
    XOR2 xr3(x[3][4], w[3][4], sign_mult_3);

    Abs #(10) mult_correct0(mult_res_0, sign_mult_0, mult_res_0_in);
    Abs #(10) mult_correct1(mult_res_1, sign_mult_1, mult_res_1_in);
    Abs #(10) mult_correct2(mult_res_2, sign_mult_2, mult_res_2_in);
    Abs #(10) mult_correct3(mult_res_3, sign_mult_3, mult_res_3_in);


    REG #(10) mult_reg0(clock, 1'b0, load_mult, mult_res_0_in, mult_res_0_out);
    REG #(10) mult_reg1(clock, 1'b0, load_mult, mult_res_1_in, mult_res_1_out);
    REG #(10) mult_reg2(clock, 1'b0, load_mult, mult_res_2_in, mult_res_2_out);
    REG #(10) mult_reg3(clock, 1'b0, load_mult, mult_res_3_in, mult_res_3_out);


    wire [11:0] sum_res_1, sum_res_2;
    wire [12:0] sum_res_in;
    wire [11:0] sum_res_out;

    Adder #(11) fpa0({mult_res_0_out[9], mult_res_0_out}, {mult_res_1_out[9], mult_res_1_out}, 1'b0, sum_res_1);
    Adder #(11) fpa1({mult_res_2_out[9], mult_res_2_out}, {mult_res_3_out[9], mult_res_3_out}, 1'b0, sum_res_2);
    Adder #(12) fpa2({sum_res_1[10], sum_res_1[10:0]}, {sum_res_2[10], sum_res_2[10:0]}, 1'b0, sum_res_in);

    REG #(12) sum_reg(clock, 1'b0, load_sum, sum_res_in[11:0], sum_res_out);

    MUX2 #(5) mux_out({sum_res_out[11], sum_res_out[6], sum_res_out[5:3]}, 5'b0, sum_res_out[11], out);
    OR6 is_zero(out[0], out[1], out[2], out[3], out[4], 0, s);

endmodule