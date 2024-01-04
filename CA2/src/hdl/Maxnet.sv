module MaxSet (
    input clock, reset,
    output done,
    output [4:0] max 
);
    wire [4:0] w0 [3:0];
    wire [4:0] w1 [3:0];
    wire [4:0] w2 [3:0];
    wire [4:0] w3 [3:0];
    wire [4:0] x_in [3:0];
    wire [4:0] y_out [3:0];
    wire [4:0] y_in [3:0];
    wire [4:0] p_out [3:0];
    wire read, select_y, load_y, load_mult, load_sum, s0, s1, s2, s3;

    // assign s = (s0 & ~s1 & ~s2 & ~s3) | (~s0 & s1 & ~s2 & ~s3) | (~s0 & ~s1 & s2 & ~s3) | (~s0 & ~s1 & ~s2 & s3);

    wire not_s0, not_s1, not_s2, not_s3;
    NOT #(1) not0(s0, not_s0);
    NOT #(1) not1(s1, not_s1);
    NOT #(1) not2(s2, not_s2);
    NOT #(1) not3(s3, not_s3);
    wire sx0, sx1, sx2, sx3;
    AND6 a0(s0, not_s1, not_s2, not_s3, 1, 1, sx0);
    AND6 a1(not_s0, s1, not_s2, not_s3, 1, 1, sx1);
    AND6 a2(not_s0, not_s1, s2, not_s3, 1, 1, sx2);
    AND6 a3(not_s0, not_s1, not_s2, s3, 1, 1, sx3);
    OR6 o6(sx0, sx1, sx2, sx3, 0, 0, s);


    
    Controller cntrl(clock, reset, s, read, load_y, select_y, load_mult, load_sum, done);


    RegX rx(clock, read, x_in);
    RegW rw(clock, read, w0, w1, w2, w3);
    ArrayMUX2 #(5) sy(x_in, p_out, select_y, y_in);
    RegY ry(clock, load_y, y_in, y_out);
    ProcessUnit pu0(clock, load_mult, load_sum, y_out, w0, s0, p_out[0]);
    ProcessUnit pu1(clock, load_mult, load_sum, y_out, w1, s1, p_out[1]);
    ProcessUnit pu2(clock, load_mult, load_sum, y_out, w2, s2, p_out[2]);
    ProcessUnit pu3(clock, load_mult, load_sum, y_out, w3, s3, p_out[3]);

    OneHotMux4 so(x_in[0], x_in[1], x_in[2], x_in[3], {s0,s1,s2,s3}, max);

endmodule