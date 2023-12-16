`timescale 1ns/1ns

module TB ();
    
    reg a, b, cin;
    wire s, cout;
    Adder add(a, b, cin, s, cout);

    always begin
        #10
        a = $random;
        b = $random;
        cin = $random;
    end 
endmodule