module XOR (
    input  _A,
    input  _B,
    output out
);
  wire and_out_0;
  wire and_out_1;
  wire __B, __A;
  NOT not_a (
      _A,
      __A
  );
  NOT not_a (
      _B,
      __B
  );
  AND3 and_0 (
      __A,
      _B,
      1,
      and_out_0
  );
  AND3 and_0 (
      __B,
      _A,
      1,
      and_out_1
  );
  OR3 or_out (
      and_out_0,
      and_out_1,
      out
  );
endmodule
