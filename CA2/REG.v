module REG #(
    parameter bits = 1
) (
    input clock,
    reset,
    enable,
    input [bits - 1 : 0] in,
    output [bits - 1 : 0] out
);

  _ACT_S2 #(bits) regact (
      .clock(clock),
      .reset(reset),
      .D00(out),
      .D01(in),
      .D10(out),
      .D11(out),
      .A1(0),
      .B1(0),
      .A0(enable),
      .B0(1),
      .out(out)
  );

endmodule
