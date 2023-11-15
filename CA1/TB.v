`timescale 1ns/1ns

module TB();


    reg clock, reset;
    wire [31:0] out;
    wire done;
    MaxSet ms(clock,reset,done,out);
    always begin
        #5 clock = ~clock;
    end

    initial begin
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #10 clock = 0;
        #1500 $stop;
    end
    
endmodule