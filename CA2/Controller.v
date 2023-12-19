module Controller (
    input  clk,
    input  reset,
    input  s,
    input  state_enable,
    output select_y,
    output mult,
    output read,
    output load_y,
    output sum
);
  //   wire [2:0] state_reg_in;
  //   wire [2:0] state_reg_out;
  wire [5:0] state_eq_one_hot;
  wire [2:0] ps_mux_out;
  wire [2:0] revert_mux_out;
  wire [2:0] _zero;
  wire [2:0] _one;
  wire [2:0] _two;
  wire [2:0] _three;
  wire [2:0] _four;
  wire [2:0] _five;
  assign _zero  = 3'b000;
  assign _one   = 3'b001;
  assign _two   = 3'b010;
  assign _three = 3'b011;
  assign _four  = 3'b100;
  assign _five  = 3'b101;

  REG state_reg (
      .clock(clk),
      .reset(reset),
      .enable(state_enable),
      .in(ps_mux_out),
      .out(state_reg_out)
  );
  MUX2 revert_mux2 (
      .A(two),
      .B(five),
      .select(s),
      .out(revert_mux_out)
  );
  OneHotMux6 one_hot_6 (
      .i_0(_one),
      .i_1(_two),
      .i_2(_three),
      .i_3(_four),
      .i_4(revert_mux_out),
      .i_5(_five),
      .sel(state_eq_one_hot),
      .out(ps_mux_out)
  );
  Comparator3Bit comp_0 (
      state_reg_out,
      _zero,
      state_eq_one_hot[5]
  );
  Comparator3Bit comp_1 (
      state_reg_out,
      _one,
      state_eq_one_hot[4]
  );
  Comparator3Bit comp_2 (
      state_reg_out,
      _two,
      state_eq_one_hot[3]
  );
  Comparator3Bit comp_3 (
      state_reg_out,
      _three,
      state_eq_one_hot[2]
  );
  Comparator3Bit comp_4 (
      state_reg_out,
      _four,
      state_eq_one_hot[1]
  );
  Comparator3Bit comp_5 (
      state_reg_out,
      _five,
      state_eq_one_hot[0]
  );
  MUX2 done_mux (
      .A     (0),
      .B     (1),
      .select(state_eq_one_hot[0]),
      .out   (read)
  );
  MUX2 select_y_mux (
      .A     (0),
      .B     (1),
      .select(state_eq_one_hot[1]),
      .out   (select_y)
  );
  MUX2 sum_mux (
      .A     (0),
      .B     (1),
      .select(state_eq_one_hot[2]),
      .out   (sum)
  );
  MUX2 multi_mux (
      .A     (0),
      .B     (1),
      .select(state_eq_one_hot[3]),
      .out   (mult)
  );
  MUX2 read_mux (
      .A     (0),
      .B     (1),
      .select(state_eq_one_hot[5]),
      .out   (read)
  );
  wire load_y_sel_mux_sel;
  OR3 load_y_sel_or (
      .A  (state_eq_one_hot[4]),
      .B  (state_eq_one_hot[1]),
      .C  (0),
      .out(load_y_sel_mux_sel)
  );
  MUX2 load_y_mux (
      .A     (0),
      .B     (1),
      .select(load_y_sel_mux_sel),
      .out   (load_y)
  );

endmodule
