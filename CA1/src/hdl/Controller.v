module Controller (
    input clock, reset, s,
    output reg read, load_y, select_y, mult, sum, done
);
    
    parameter [2:0] READ = 0, INIT = 1, MULT = 2, SUM = 3, LOAD = 4, DONE = 5;
    reg [2:0] pstate, nstate;


    always @(pstate) begin
        case (pstate)
            READ: nstate = INIT;
            INIT: nstate = MULT;
            MULT: nstate = SUM;
            SUM: nstate = LOAD;
            LOAD:begin
                if(s)
                    nstate = DONE;
                else
                    nstate = MULT;
            end
            DONE: nstate = DONE;
            default: nstate = READ;
        endcase
    end

    always @(pstate) begin
        {read, load_y, mult, sum, done, select_y} = 6'b0;
        case (pstate)
            READ: read = 1;
            INIT: begin
                load_y = 1;
                select_y = 0;
            end
            MULT: mult = 1;
            SUM: sum = 1;
            LOAD: begin
                load_y = 1;
                select_y = 1;
            end 
            DONE: done = 1'b1;
            default: {read, load_y, mult, sum, done, select_y} = 6'b0;
        endcase
    end

    always @(posedge clock, posedge reset) begin
        if(reset)
            pstate = READ;
        else
            pstate = nstate;
    end

endmodule
