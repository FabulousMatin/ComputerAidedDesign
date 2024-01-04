module NOT #(parameter bits) ( 
    input [bits - 1 : 0] A ,
    output [bits - 1 : 0] out
);
    genvar i;
    generate
        for (i = 0; i < bits; i = i + 1) begin: bit_not
            _ACT_C1 _NOT(1, 1, 1, 0, 0, 0, A[i], 0, out[i]);
        end
    endgenerate

endmodule
