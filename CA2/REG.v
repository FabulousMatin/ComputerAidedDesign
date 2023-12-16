module REG #(parameter bits = 1) (
    input clock, reset, enable,
    input [bits - 1 : 0] in,

    output reg [bits - 1 : 0] out
);
    
    _ACT_S2 #(bits) regact(clock, reset, out, in, 0, 0, 0, 0, enable, 1, out);

endmodule