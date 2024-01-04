module OneHotMux4 (
    input  [4:0] i_0,
    input  [4:0] i_1,
    input  [4:0] i_2,
    input  [4:0] i_3,
    input  [3:0] sel,

    output [4:0] out
);
    wire [4:0] m_0, m_1, m_2, m_3;

    MUX2 #(5) mux_0 (
        .A(5'b0),
        .B(i_0),
        .select(sel[3]),
        .out(m_0)
    );

    MUX2 #(5) mux_1 (
        .A(5'b0),
        .B(i_1),
        .select(sel[2]),
        .out(m_1)
    );

    MUX2 #(5) mux_2 (
        .A(5'b0),
        .B(i_2),
        .select(sel[1]),
        .out(m_2)
    );

    MUX2 #(5) mux_3 (
        .A(5'b0),
        .B(i_3),
        .select(sel[0]),
        .out(m_3)
    );

    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin: ors
            OR6 o6s(m_0[i], m_1[i], m_2[i], m_3[i], 0, 0, out[i]);
        end
    endgenerate

endmodule


