module RegY (
    input clock, load,
    input [4:0] in [3:0],

    output [4:0] out [3:0]
);


    REG #(5) y0(clock, 1'b0, load, in[0], out[0]);
    REG #(5) y1(clock, 1'b0, load, in[1], out[1]);
    REG #(5) y2(clock, 1'b0, load, in[2], out[2]);
    REG #(5) y3(clock, 1'b0, load, in[3], out[3]);

endmodule