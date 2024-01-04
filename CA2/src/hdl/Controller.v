module Controller (
    input  clock, reset, s,
    output read, load_y, select_y, mult, sum, done
);
    wire [2:0] pstate;
    wire [2:0] nstate;
    wire [5:0] state_eq_one_hot;
    wire [2:0] revert_mux_out;
    
    parameter [2:0] ZERO  = 3'b000;
    parameter [2:0] ONE   = 3'b001;
    parameter [2:0] TWO   = 3'b010;
    parameter [2:0] THREE = 3'b011;
    parameter [2:0] FOUR  = 3'b100;
    parameter [2:0] FIVE  = 3'b101;

    REG #(3) state_reg (
        .clock(clock),
        .reset(reset),
        .enable(1),
        .in(nstate),
        .out(pstate)
    );
    MUX2 #(3) revert_mux2 (
        .A(TWO),
        .B(FIVE),
        .select(s),
        .out(revert_mux_out)
    );
    OneHotMux6 one_hot_6 (
        .i_0(ONE),
        .i_1(TWO),
        .i_2(THREE),
        .i_3(FOUR),
        .i_4(revert_mux_out),
        .i_5(FIVE),
        .sel(state_eq_one_hot),
        .out(nstate)
    );
    Comparator3Bit comp_0 (
        pstate,
        ZERO,
        state_eq_one_hot[0]
    );
    Comparator3Bit comp_1 (
        pstate,
        ONE,
        state_eq_one_hot[1]
    );
    Comparator3Bit comp_2 (
        pstate,
        TWO,
        state_eq_one_hot[2]
    );
    Comparator3Bit comp_3 (
        pstate,
        THREE,
        state_eq_one_hot[3]
    );
    Comparator3Bit comp_4 (
        pstate,
        FOUR,
        state_eq_one_hot[4]
    );
    Comparator3Bit comp_5 (
        pstate,
        FIVE,
        state_eq_one_hot[5]
    );
    MUX2 #(1) done_mux (
        .A     (0),
        .B     (1),
        .select(state_eq_one_hot[5]),
        .out   (done)
    );
    MUX2 #(1) select_y_mux (
        .A     (0),
        .B     (1),
        .select(state_eq_one_hot[4]),
        .out   (select_y)
    );
    MUX2 #(1) sum_mux (
        .A     (0),
        .B     (1),
        .select(state_eq_one_hot[3]),
        .out   (sum)
    );
    MUX2 #(1) multi_mux (
        .A     (0),
        .B     (1),
        .select(state_eq_one_hot[2]),
        .out   (mult)
    );
    MUX2 #(1) read_mux (
        .A     (0),
        .B     (1),
        .select(state_eq_one_hot[0]),
        .out   (read)
    );

    wire load_y_sel_mux_sel;
    OR3 load_y_sel_or (
        .A  (state_eq_one_hot[1]),
        .B  (state_eq_one_hot[4]),
        .C  (0),
        .out(load_y_sel_mux_sel)
    );
    MUX2 #(1) load_y_mux (
        .A     (0),
        .B     (1),
        .select(load_y_sel_mux_sel),
        .out   (load_y)
    );
endmodule
