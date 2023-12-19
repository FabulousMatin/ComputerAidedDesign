module Comparator3Bit (
    input [2:0] _A,
    input [2:0] _B,
    output out
);
  wire E_0, E_1, E_2;
  wire _E_0, _E_1, _E_2;
  wire __B_0, __B_1, __B_2;

  NOT not_b_1 (
      _B[0],
      __B_0
  );
  NOT not_b_2 (
      _B[1],
      __B_1
  );
  NOT not_b_3 (
      _B[2],
      __B_2
  );

  XOR2 XOR_1 (
      _A[0],
      __B_0,
      E_0
  );
  XOR2 XOR_2 (
      _A[1],
      __B_1,
      E_1
  );
  XOR2 XOR_3 (
      _A[2],
      __B_2,
      E_2
  );

  AND3 and3_output (
      E_0,
      E_1,
      E_2,
      out
  );


endmodule
