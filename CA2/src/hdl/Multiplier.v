module bitmult (
    input xin, yin, cin, pin,

    output xout, yout, cout, pout 
);
    assign xout = xin;
    assign yout = yin;
    
    wire xy, pxy, cxy, pc;
    AND3 a1(1, xin, yin, xy);
    AND3 a21(1, pin, xy, pxy);
    AND3 a22(1, cin, xy, cxy);
    AND3 a23(1, pin, cin, pc);
    OR3 o1(pxy, cxy, pc, cout);


    wire p_xor_xy;
    XOR2 x1(pin, xy, p_xor_xy);
    XOR2 x2(p_xor_xy, cin, pout);
    
endmodule

module Multiplier #(parameter bits) (
    input [bits - 1 : 0] A,
    input [bits - 1 : 0] B,

    output [2 * bits - 1 : 0] out
);
    wire xv [bits : 0][bits : 0] ;
    wire yv [bits : 0][bits : 0] ;
    wire cv [bits : 0][bits : 0] ;
    wire pv [bits : 0][bits : 0] ;

    genvar i, j;

    generate
        for (i = 0; i < bits; i = i + 1) begin: rowsbitmult
            for (j = 0; j < bits; j = j + 1) begin: colrowsbitmult
                bitmult bm(
                    .xin(xv[i][j]),
                    .yin(yv[i][j]),
                    .cin(cv[i][j]),
                    .pin(pv[i][j + 1]),
                    .xout(xv[i][j + 1]),
                    .yout(yv[i + 1][j]),
                    .cout(cv[i][j + 1]),
                    .pout(pv[i + 1][j])
                );
            end
        end
    endgenerate

    generate
        for (i = 0; i < bits; i = i + 1) begin: side_bus
            assign xv[i][0] = A[i];
            assign cv[i][0] = 1'b0;
            assign pv[0][i + 1] = 1'b0;
            assign pv[i + 1][bits] = cv[i][bits];
            assign yv[0][i] = B[i];
            assign out[i] = pv[i + 1][0];
            assign out[i + bits] = pv[bits][i + 1];
        end
    endgenerate
endmodule