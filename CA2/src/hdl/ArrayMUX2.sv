module ArrayMUX2 #(parameter bits) (
    input [bits - 1 : 0] data_in1[3:0],
    input [bits - 1 : 0] data_in2[3:0],
    input select,
    output [bits - 1 : 0] data_out[3:0]
);

    MUX2 #(bits) mx0(data_in1[0], data_in2[0], select, data_out[0]);
    MUX2 #(bits) mx1(data_in1[1], data_in2[1], select, data_out[1]);
    MUX2 #(bits) mx2(data_in1[2], data_in2[2], select, data_out[2]);
    MUX2 #(bits) mx3(data_in1[3], data_in2[3], select, data_out[3]);
endmodule