module Controller (
    input clock, reset,
    input [7:0] x, y, z,

    output reg read_filter, read_window, load_buffer, sum_reset, sum_en, write, done,
    output reg [1:0] memory_offset,
    output reg [1:0] counter_filter,
    output reg [3:0] counter_buffer,
    output reg [3:0] counter_sum,
    output reg [7:0] address,
    output reg [2:0] k, q,
    output reg [3:0] i, j 
);

    reg [2:0] pstate, nstate;
    parameter [2:0] INIT = 0, READ_FILTER = 1, READ_WINDOW = 2,
    LOAD_BUFFER = 3, MULT_SUM = 4, WRITE = 5, HANDLE_INDEX = 6, DONE = 7;

    reg fcount, bcount, scount;    
    reg carry_cf, carry_cb, carry_cs;

    // address generator
    always @(posedge clock) begin
        {carry_cs, counter_sum} = (scount == 1) ? (counter_sum + 1) : counter_sum;
        {carry_cf, counter_filter} = (fcount == 1) ? (counter_filter + 1) : counter_filter;
        {carry_cb, counter_buffer} = (bcount == 1) ? (counter_buffer + 1) : counter_buffer;

        if(pstate == HANDLE_INDEX) begin
            q = q + 1;
            if(q == 5) begin
                q = 0;
                k = k + 1;
                if(k == 5) begin
                    k = 0;
                    j = j + 4;
                    if(j == 12) begin
                        j = 0;
                        i = i + 4;
                        if(i == 12)
                            nstate = DONE;
                        else
                            nstate = READ_WINDOW;
                    end
                    else
                        nstate = READ_WINDOW;
                end
                else
                    nstate = LOAD_BUFFER;
            end  
            else
                nstate = LOAD_BUFFER;
        end
    end

    always @(posedge clock, pstate) begin
        case (pstate)
            INIT: nstate = READ_FILTER;
            READ_FILTER: nstate = (carry_cf) ? READ_WINDOW : READ_FILTER;
            READ_WINDOW: nstate = (carry_cb) ? LOAD_BUFFER : READ_WINDOW;
            LOAD_BUFFER: nstate = MULT_SUM;
            MULT_SUM: nstate = (carry_cs) ? WRITE : MULT_SUM;
            WRITE: nstate = HANDLE_INDEX;
            HANDLE_INDEX:begin
                
            end
            DONE: nstate = DONE;
            default: nstate = INIT;
        endcase
    end

    always @(posedge clock, pstate) begin
        {read_filter, read_window, load_buffer, sum_reset, sum_en, write, fcount, bcount, scount} = 9'b0;
        address = 8'bz;

        case (pstate)
            INIT: begin
                {k, q} = 6'b0;
                {i, j} = 8'b0;
                counter_filter = 0;
                counter_buffer = 0;
                counter_sum = 0;
            end
            READ_FILTER: begin
                address = y + counter_filter;
                read_filter = 1;
                fcount = 1;
            end
            READ_WINDOW: begin
                address = x + (16 * i + j) / 4 +  4 * ((counter_buffer) / 2) + (counter_buffer % 2);
                read_window = 1;
                bcount = 1; 
            end
            LOAD_BUFFER: begin
                load_buffer = 1;
                sum_reset = 1;
            end
            MULT_SUM: begin
                sum_en = 1;
                scount = 1;
            end

            WRITE: begin
                address = ((13 * (i + k)) + (j + q) + (4 * z)) / 4;
                memory_offset = ((13 * (i + k)) + (j + q) + (4 * z)) % 4;
                write = 1;
            end
            HANDLE_INDEX: begin
                
            end 
            DONE: begin
                done = 1;
            end
            default: nstate = INIT;
        endcase
    end

  

    always @(posedge clock, posedge reset) begin
        if(reset)
            pstate = INIT;
        else
            pstate = nstate;
    end

endmodule