module Convolution #(parameter neurons) (
    input clock, reset,
    input [7:0] x, y, z, M,

    output done
);
    genvar i;

    ////////////////////////////////////////// wires //////////////////////////////////////////:
    wire [7:0] memory_out_L1 [0:3];
    wire [7:0] memory_out_L2 [0 : neurons - 1][0:3];
    wire [7:0] buffer16_out_L1 [0:15][0:15];
    wire [7:0] buffer4_out_L1 [0:3][0:3];
    wire [7:0] buffer13_out_L2 [0 : neurons - 1][0:12][0:12];
    wire [7:0] buffer4_out_L2 [0 : neurons - 1][0:3][0:3];
    wire [7:0] kernel_out_L1 [0 : neurons - 1][0:3][0:3];
    wire [7:0] kernel_out_L2 [0 : neurons - 1][0 : neurons - 1][0:3][0:3];
    wire [7:0] pe_out_L1 [0 : neurons - 1];
    wire [7:0] pe_out_L2 [0 : neurons - 1];
    wire [3:0] i_buffer, j_buffer;
    wire [1:0] i_sum, j_sum;

    wire load_buffer_L1, load_buffer_L2, sum_reset, sum_en, write_outmem, write_ofm, writeOut, read;
    wire load_kernel_L1 [0 : neurons - 1];
    wire load_kernel_L2 [0 : neurons - 1];
    wire [1:0] memory_offset;
    wire [1:0] counter_kernel;
    wire [5:0] counter_buffer;
    wire [3:0] counter_sum;
    wire [7:0] address;

    assign i_sum = counter_sum / 4;
    assign j_sum = counter_sum % 4;

    ////////////////////////////////////////// controller //////////////////////////////////////////:
    Controller #(neurons) cntrlr(
        clock, reset,
        x, y, z, M, 

        load_buffer_L1, load_buffer_L2, sum_reset, sum_en, write_outmem, write_ofm, writeOut, read, done,
        load_kernel_L1,
        load_kernel_L2,
        memory_offset,
        counter_kernel,
        counter_buffer,
        counter_sum,
        address,
        i_buffer, j_buffer
    );

    ////////////////////////////////////////// data memory //////////////////////////////////////////:
    DataMemory datamem(
        clock, 1'b1, 
        address, 
        memory_out_L1
    );

    ////////////////////////////////////////// layer 1 //////////////////////////////////////////:
    // buffer
    Buffer16 l1bfr16(
        clock, load_buffer_L1, 
        counter_buffer, 
        memory_out_L1, 
        buffer16_out_L1
    );
    
    Mux256 mx256(
        buffer16_out_L1,
        i_buffer, j_buffer, 
        buffer4_out_L1
    );

    // kernel:
    generate
        for (i = 0; i < neurons; i = i + 1) begin: L1_kernels
            Kernel #(1) l1_krnl(
                clock, 
                {load_kernel_L1[i]}, 
                counter_kernel, 
                memory_out_L1, 
                {kernel_out_L1[i]}
            );
        end
    endgenerate

    //PE:
    generate
        for (i = 0; i < neurons; i = i + 1) begin: L1_PEs
            PE #(1) l1_pe(
                clock, sum_reset, sum_en,
                i_sum, j_sum,
                {buffer4_out_L1},
                {kernel_out_L1[i]},
                pe_out_L1[i]
            );
        end
    endgenerate

    // out mem:
    generate
        for (i = 0; i < neurons; i = i + 1) begin: L1_OutMems
            OutMem #(i + 1) l1_outmem(
                clock, write_outmem, 1'b1, read, writeOut,
                address,
                M,
                memory_offset,
                pe_out_L1[i],
                memory_out_L2[i]
            );
        end
    endgenerate



    ////////////////////////////////////////// layer 2 //////////////////////////////////////////:
    // buffer
    generate
        for (i = 0; i < neurons; i = i + 1) begin: L2_Buffers
            Buffer13 l2_bfr(
                clock, load_buffer_L2,
                counter_buffer,
                memory_out_L2[i],
                buffer13_out_L2[i]
            );
        end
    endgenerate

    generate
        for (i = 0; i < neurons; i = i + 1) begin: L2_Muxs
            Mux169 mx169(
                buffer13_out_L2[i],
                i_buffer, j_buffer, 
                buffer4_out_L2[i]
            );
        end
    endgenerate

    // kernel
    generate
        for (i = 0; i < neurons; i = i + 1) begin: L2_kernels
            Kernel #(neurons) l2_krnl(
                clock,
                load_kernel_L2,
                counter_kernel,
                memory_out_L2[i],
                kernel_out_L2[i]
            );
        end
    endgenerate

    //PE:
    generate
        for (i = 0; i < neurons; i = i + 1) begin: L2_PEs
            PE #(neurons) l2_pe(
                clock, sum_reset, sum_en,
                i_sum, j_sum,
                buffer4_out_L2,
                kernel_out_L2[i],
                pe_out_L2[i]
            );
        end
    endgenerate

    // OFM
    generate
        for (i = 0; i < neurons; i = i + 1) begin: L2_OFMs
            OFM #(i + 1) l2_ofm(
                clock, write_ofm, writeOut,
                address,
                memory_offset,
                pe_out_L2[i]
            );
        end
    endgenerate

endmodule