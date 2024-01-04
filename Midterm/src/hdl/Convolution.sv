module Convolution (
    input clock, reset,
    input [7:0] x, y, z,

    output done
);
    wire load_filter, load_window, load_buffer, sum_reset, sum_en, write;
    wire [7:0] address;
    wire [2:0] k, q;
    wire [3:0] i, j;
    wire [7:0] filter_out [0:3][0:3];
    wire [7:0] buffer4_in [0:3][0:3];
    wire [7:0] buffer4_out [0:3][0:3];
    wire [7:0] buffer8 [0:7][0:7];
    wire [7:0] mult_res;
    wire [7:0] conv_res;
    wire [1:0] counter_filter;
    wire [3:0] counter_buffer;
    wire [7:0] read_data [0:3];
    wire [1:0] memory_offset;
    wire [3:0] counter_sum;
    wire [7:0] pixel;
    wire [7:0] filter_pixel;
    wire [2:0] sum_i, sum_j;


    Controller cntrl(
        clock, reset, 
        x, y, z,
        load_filter, load_window, load_buffer, sum_reset, sum_en, write, done,
        memory_offset,
        counter_filter,
        counter_buffer,
        counter_sum,
        address,
        k, q,
        i, j
    );

    assign sum_i = counter_sum / 4;
    assign sum_j = counter_sum % 4;
    
    Filter fltr(clock, load_filter, counter_filter, read_data, filter_out);

    DataMemory dm(clock, (load_filter | load_window), write, address, memory_offset, conv_res, read_data);

    Buffer4 bf4(clock, load_buffer, buffer4_in, buffer4_out);

    Mux16 mxPic(buffer4_out, sum_i, sum_j, pixel);

    Mux16 mxFilter(filter_out, sum_i, sum_j, filter_pixel);

    Mux64 mx64to16(buffer8, k, q, buffer4_in);

    Buffer8 bf8(clock, load_window, counter_buffer, read_data, buffer8);

    Mult mlt(pixel, filter_pixel, mult_res);

    Sum sm(clock, sum_reset, sum_en, mult_res, conv_res);

endmodule