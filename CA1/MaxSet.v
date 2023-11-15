module MaxSet (
    input clock, reset,
    output done,
    output [31:0] max 
);
    wire [31:0] w1 [3:0];
    wire [31:0] w2 [3:0];
    wire [31:0] w3 [3:0];
    wire [31:0] w4 [3:0];
    wire [31:0] x [3:0];
    wire [31:0] y_out [3:0];
    wire [31:0] y_in [3:0];
    wire [31:0] p_out [3:0];
    wire read, select_y, load_y, load_mult, load_sum, s1, s2, s3, s4;

    RegW rw(clock, read, w1, w2, w3, w4);
    RegX rx(clock, read, x);
    RegY ry(clock, read, y_in, y_out);
    MUX2 sy(x, p_out, select_y, y_in);
    ProcessUnit pu1(clock, load_mult, load_sum, x, w1, s1, p_out[0]);
    ProcessUnit pu2(clock, load_mult, load_sum, x, w2, s2, p_out[1]);
    ProcessUnit pu3(clock, load_mult, load_sum, x, w3, s3, p_out[2]);
    ProcessUnit pu4(clock, load_mult, load_sum, x, w4, s4, p_out[3]);
    MUX4 so(x[0], x[1], x[2], x[3], {s4,s3,s2,s1}, max);

    assign s = (s1 & ~s2 & ~s3 & ~s4) | (~s1 & s2 & ~s3 & ~s4) | (~s1 & ~s2 & s3 & ~s4) | (~s1 & ~s2 & ~s3 & s4);
    Controller cntrl(clock, reset, s, read, load_y, select_y, load_mult, load_sum, done);
endmodule