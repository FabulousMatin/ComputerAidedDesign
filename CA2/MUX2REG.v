module MUX2REG #(parameter bits = 2) (
    input clock, reset, enable,
    input A, B,
    input select,

    output reg out
);

    _ACT_S2 #(bits) mux2reg(clock, reset, A, B, out, out, enable, 0, select, 1, out);


endmodule