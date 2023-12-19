module _ACT_S2 #(
    parameter bits = 2
) (
    input clock,
    reset,
    input [bits - 1 : 0] D00,
    input [bits - 1 : 0] D01,
    input [bits - 1 : 0] D10,
    input [bits - 1 : 0] D11,
    input A1,
    B1,
    A0,
    B0,
    output [bits - 1 : 0] out
);
  wire S0, S1;
  wire [bits - 1 : 0] D;
  reg  [bits - 1 : 0] _out;
  assign S0 = (A0 & B0);
  assign S1 = (A1 | B1);

  assign D = (S0 == 0 & S1 == 0) ? D00 :
               (S0 == 0 & S1 == 1) ? D01 :
               (S0 == 1 & S1 == 0) ? D10 :
               (S0 == 1 & S1 == 1) ? D11 : 'bz;

  always @(posedge clock) begin
    if (reset) _out = 0;
    else _out = D;
  end
  assign out = _out;
endmodule
