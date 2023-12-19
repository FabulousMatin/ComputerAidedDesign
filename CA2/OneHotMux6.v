module OneHotMux6 (
    input  [2:0] i_0,
    input  [2:0] i_1,
    input  [2:0] i_2,
    input  [2:0] i_3,
    input  [2:0] i_4,
    input  [2:0] i_5,
    input  [5:0] sel,
    output [2:0] out
);
  wire [2:0] m_0, m_1, m_2, m_3, m_4, m_5;
  MUX2 #(
      .bits(3)
  ) mux_0 (
      .A(0),
      .B(i_0),
      .select(sel[0]),
      .out(m_0)
  );
  MUX2 #(
      .bits(3)
  ) mux_1 (
      .A(0),
      .B(i_1),
      .select(sel[1]),
      .out(m_1)
  );
  MUX2 #(
      .bits(3)
  ) mux_2 (
      .A(0),
      .B(i_2),
      .select(sel[2]),
      .out(m_2)
  );
  MUX2 #(
      .bits(3)
  ) mux_3 (
      .A(0),
      .B(i_3),
      .select(sel[3]),
      .out(m_3)
  );
  MUX2 #(
      .bits(3)
  ) mux_4 (
      .A(0),
      .B(i_4),
      .select(sel[4]),
      .out(m_4)
  );
  MUX2 #(
      .bits(3)
  ) mux_5 (
      .A(0),
      .B(i_5),
      .select(sel[5]),
      .out(m_5)
  );
  OR6 or_6_0 (
      m_0[0],
      m_1[0],
      m_2[0],
      m_3[0],
      m_4[0],
      m_5[0],
      out[0]
  );

  OR6 or_6_1 (
      m_0[1],
      m_1[1],
      m_2[1],
      m_3[1],
      m_4[1],
      m_5[1],
      out[1]
  );
  OR6 or_6_2 (
      m_0[2],
      m_1[2],
      m_2[2],
      m_3[2],
      m_4[2],
      m_5[2],
      out[2]
  );

endmodule
