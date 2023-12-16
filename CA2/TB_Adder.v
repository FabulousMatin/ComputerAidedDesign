`timescale 1ns/1ns

module TB ();
    
    reg [9:0] a, b;
    reg cin;
    wire [10:0] s;
    AdderCascade #(10) adrcsc(a, b, cin, s);

    always begin
        #10
        a = $random;
        b = $random;
        cin = $random;
    end 
endmodule