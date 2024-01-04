`timescale 1ns/1ns

module TB();
    reg clock, reset;
    // 5 71 83
    // 2 71 81
    // 4 74 84
    reg [7:0] x = 5, y = 71, z = 83;
    wire done;

    Convolution cv(clock, reset, x, y, z, done);
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