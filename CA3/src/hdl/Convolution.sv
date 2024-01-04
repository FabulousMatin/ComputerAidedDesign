module Convolution #(parameter nkernel) (
    input clock, reset,
    input [7:0] x, y, z,

    output done
);
    wire [7:0] filter_out [0 : nkernel - 1][0:3][0:3];
    wire load_filter [0 : nkernel - 1];
    wire [7:0] filter_pixel [0 : nkernel - 1];
    wire [7:0] mult_res [0 : nkernel - 1];
    wire [7:0] conv_res [0 : nkernel - 1];


    wire load_window, load_buffer, sum_reset, sum_en, write, writeOut;
    wire [7:0] address;
    wire [2:0] k, q;
    wire [3:0] i, j;
    wire [7:0] buffer4_in [0:3][0:3];
    wire [7:0] buffer4_out [0:3][0:3];
    wire [7:0] buffer8 [0:7][0:7];
    wire [1:0] counter_filter;
    wire [3:0] counter_buffer;
    wire [7:0] read_data [0:3];
    wire [1:0] memory_offset;
    wire [3:0] counter_sum;
    wire [7:0] pixel;
    wire [2:0] sum_i, sum_j;

//load filter
    Controller #(nkernel) cntrl(
        clock, reset, 
        x, y, z,
        load_window, load_buffer, sum_reset, sum_en, write, done, writeOut,
        load_filter,
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

    genvar n;
    generate
        for (n = 0; n < nkernel; n = n + 1) begin: kernels
            Filter fltr(clock, load_filter[n], counter_filter, read_data, filter_out[n]);
        end
    endgenerate

    DataMemory #(nkernel) dm(clock, write, writeOut, address, memory_offset, conv_res, read_data);

    Buffer4 bf4(clock, load_buffer, buffer4_in, buffer4_out);

    Mux16 mxPic(buffer4_out, sum_i, sum_j, pixel);

    generate
        for (n = 0; n < nkernel; n = n + 1) begin: mx16s
            Mux16 mxFilter(filter_out[n], sum_i, sum_j, filter_pixel[n]);
        end
    endgenerate
    

    Mux64 mx64to16(buffer8, k, q, buffer4_in);

    Buffer8 bf8(clock, load_window, counter_buffer, read_data, buffer8);

    generate
        for (n = 0; n < nkernel; n = n + 1) begin: mults
            Mult mlt(pixel, filter_pixel[n], mult_res[n]);
        end
    endgenerate
    
    generate
        for (n = 0; n < nkernel; n = n + 1) begin: sums
            Sum sm(clock, sum_reset, sum_en, mult_res[n], conv_res[n]);
        end
    endgenerate
    

endmodule