module MaxSet (
    input clock, reset,
    output done,
    output [31:0] max 
);
    wire [31:0] w0 [3:0];
    wire [31:0] w1 [3:0];
    wire [31:0] w2 [3:0];
    wire [31:0] w3 [3:0];
    wire [31:0] x_in [3:0];
    wire [31:0] y_out [3:0];
    wire [31:0] y_in [3:0];
    wire [31:0] p_out [3:0];
    wire read, select_y, load_y, load_mult, load_sum, s0, s1, s2, s3;

    RegW rw(clock, read, w0, w1, w2, w3);
    RegX rx(clock, read, x_in);
    MUX2 sy(x_in, p_out, select_y, y_in);
    RegY ry(clock, load_y, y_in, y_out);
    ProcessUnit pu0(clock, load_mult, load_sum, y_out, w0, s0, p_out[0]);
    ProcessUnit pu1(clock, load_mult, load_sum, y_out, w1, s1, p_out[1]);
    ProcessUnit pu2(clock, load_mult, load_sum, y_out, w2, s2, p_out[2]);
    ProcessUnit pu3(clock, load_mult, load_sum, y_out, w3, s3, p_out[3]);
    MUX4 so(x_in[0], x_in[1], x_in[2], x_in[3], {s0,s1,s2,s3}, max);

    assign s = (s0 & ~s1 & ~s2 & ~s3) | (~s0 & s1 & ~s2 & ~s3) | (~s0 & ~s1 & s2 & ~s3) | (~s0 & ~s1 & ~s2 & s3);
    Controller cntrl(clock, reset, s, read, load_y, select_y, load_mult, load_sum, done);
endmodule