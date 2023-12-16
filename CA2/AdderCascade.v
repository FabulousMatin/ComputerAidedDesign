module AdderCascade #(parameter bits) (
    input [bits - 1 : 0] A,
    input [bits - 1 : 0] B,
    input carry_in,

    output [bits : 0] out
);
    wire [bits : 0] carry;
    assign carry[0] = carry_in;
    assign out[bits] = carry[bits];

    genvar i;
    generate
        for (i = 0; i < bits ; i = i + 1) begin: adders
            Adder adr(A[i],B[i],carry[i],out[i],carry[i+1]);
        end
    endgenerate
endmodule