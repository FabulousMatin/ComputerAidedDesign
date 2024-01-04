`timescale 1ns/1ns

module TB();


    reg clock = 0, reset;
    wire [4:0] max;
    wire done;
    MaxSet ms(clock,reset,done,max);
    always begin
        #5 clock = ~clock;
    end

    initial begin
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #400 $stop;
    end
    
endmodule