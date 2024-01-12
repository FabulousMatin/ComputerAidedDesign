module Controller #(parameter neurons) (
    input clock, reset,
    input [7:0] x, y, z, M, 

    output reg load_buffer_L1, load_buffer_L2, sum_reset, sum_en, write_outmem, write_ofm, writeOut, read, done,
    output reg load_kernel_L1 [0 : neurons - 1],
    output reg load_kernel_L2 [0 : neurons - 1],
    output reg [1:0] memory_offset,
    output reg [1:0] counter_kernel,
    output reg [5:0] counter_buffer,
    output reg [3:0] counter_sum,
    output reg [7:0] address,
    output reg [3:0] i, j
);

    reg [3:0] pstate, nstate;
    parameter [3:0] INIT = 0, L1_LOAD_KERNEL = 1, L1_LOAD_BUFFER = 2, L1_PE = 3,
    L1_WRITE = 4, L1_HANDLE_INDEX = 5, L2_INIT = 6, L2_LOAD_KERNEL = 7,
    L2_LOAD_BUFFER = 8, L2_PE = 9, L2_WRITE = 10,
    L2_HANDLE_INDEX = 11, DONE = 12;

    reg carryKernel, carrySum, carryBuffer;
    reg counterKernelEn, counterSumEn, counterBufEn;    
    reg [neurons - 1 : 0] counter_neurons;

    // address generator
    always @(posedge clock) begin
        {carrySum, counter_sum} = (counterSumEn == 1) ? (counter_sum + 1) : counter_sum;
        {carryKernel, counter_kernel} = (counterKernelEn == 1) ? (counter_kernel + 1) : counter_kernel;
        {carryBuffer, counter_buffer} = (counterBufEn == 1) ? (counter_buffer + 1) : counter_buffer;
        counter_neurons = counter_neurons + carryKernel;

        if(pstate == L1_HANDLE_INDEX) begin
            if(j == 12) begin
                j = 0;
                if(i == 12) 
                    nstate = L2_INIT;
                else begin
                    nstate = L1_PE;
                    i = i + 1;
                end
            end
            else begin
                j = j + 1;
                nstate = L1_PE;
            end
        end
        else if(pstate == L2_HANDLE_INDEX) begin
            if(j == 9) begin
                j = 0;
                if(i == 9) 
                    nstate = DONE;
                else begin
                    nstate = L2_PE;
                    i = i + 1;
                end
            end
            else begin
                j = j + 1;
                nstate = L2_PE;
            end
        end
    end

    always @(posedge clock, pstate) begin
        case (pstate)
            INIT: nstate = L1_LOAD_KERNEL;
            L1_LOAD_KERNEL: nstate = (counter_neurons == neurons) ? L1_LOAD_BUFFER : L1_LOAD_KERNEL;
            L1_LOAD_BUFFER: nstate = (carryBuffer) ? L1_PE : L1_LOAD_BUFFER;
            L1_PE: nstate = (carrySum) ? L1_WRITE : L1_PE;
            L1_WRITE: nstate = L1_HANDLE_INDEX;
            L1_HANDLE_INDEX : begin
                
            end
            L2_INIT: nstate = L2_LOAD_KERNEL;
            L2_LOAD_KERNEL: nstate = (counter_neurons == neurons) ? L2_LOAD_BUFFER : L2_LOAD_KERNEL;
            L2_LOAD_BUFFER: nstate = (counter_buffer == 43) ? L2_PE : L2_LOAD_BUFFER;
            L2_PE: nstate = (carrySum) ? L2_WRITE : L2_PE;
            L2_WRITE: nstate = L2_HANDLE_INDEX;
            L2_HANDLE_INDEX : begin
                
            end
            DONE: nstate = DONE;
            default: nstate = INIT;
        endcase
    end
    integer nn;
    always @(posedge clock, pstate) begin
        for (nn = 0; nn < neurons; nn = nn + 1) begin
            load_kernel_L1[nn] = 0;
            load_kernel_L2[nn] = 0;
        end
        {load_buffer_L1, load_buffer_L2, sum_reset, sum_en, write_outmem, write_ofm, writeOut} = 8'b0;
        {counterKernelEn, counterSumEn, counterBufEn} = 3'b0;
        read = 0;
        address = 8'bz;
        memory_offset = 2'bz;

        case (pstate)
            INIT: begin
                {i, j} = 8'b0;
                counter_kernel = 0;
                counter_buffer = 0;
                counter_sum = 0;
                counter_neurons = 0;
                read = 1;
            end
            L1_LOAD_KERNEL: begin
                address = y + counter_kernel + 4 * counter_neurons;
                load_kernel_L1[counter_neurons] = 1;
                counterKernelEn = 1;
            end
            L1_LOAD_BUFFER: begin
                address = x + counter_buffer;
                counterBufEn = 1;
                load_buffer_L1 = 1;
                sum_reset = 1;
            end
            L1_PE: begin
                sum_en = 1;
                counterSumEn = 1;
            end
            L1_WRITE: begin
                address = (13 * i + 4 * z + j) / 4;
                memory_offset = (13 * i + 4 * z + j) % 4;
                write_outmem = 1;
            end
            L1_HANDLE_INDEX: begin
                sum_reset = 1;
            end
            L2_INIT: begin
                writeOut = 1;
                {i, j} = 8'b0;
                counter_kernel = 0;
                counter_buffer = 0;
                counter_sum = 0;
                counter_neurons = 0;
            end
            L2_LOAD_KERNEL: begin
                address = M + counter_kernel + 4 * counter_neurons;
                load_kernel_L2[counter_neurons] = 1;
                counterKernelEn = 1;
            end
            L2_LOAD_BUFFER: begin
                address = z + counter_buffer;
                counterBufEn = 1;
                load_buffer_L2 = 1;
                sum_reset = 1;
            end
            L2_PE: begin
                sum_en = 1;
                counterSumEn = 1;
            end
            L2_WRITE: begin
                address = (10 * i + j) / 4;
                memory_offset = (10 * i + j) % 4;
                write_ofm = 1;
            end
            L2_HANDLE_INDEX: begin
                sum_reset = 1;
            end
            DONE: begin
                done = 1;
                writeOut = 1;
            end
            default: begin
                
            end
        endcase
    end

  

    always @(posedge clock, posedge reset) begin
        if(reset)
            pstate = INIT;
        else
            pstate = nstate;
    end

endmodule