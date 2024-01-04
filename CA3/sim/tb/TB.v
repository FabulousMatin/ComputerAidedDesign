`timescale 1ns/1ns

module TB();
    reg clock, reset;
    reg [7:0] x = 16, y = 0, z = 0;
    wire done;

    Convolution #(4) cv(clock, reset, x, y, z, done);
    always begin
        #5 clock = ~clock;
    end

    initial begin
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        #10 clock = 0;
        #45000 $stop;
    end
    
endmodule