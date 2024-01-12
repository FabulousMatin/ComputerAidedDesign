module Sum #(parameter neurons) (
    input clock, reset, enable,
    input [7:0] A [0 : neurons - 1],

    output reg [7:0] res
);

    reg[13:0] sum_res;
    integer i;
    always @(posedge clock) begin
        if(reset)
            sum_res = 0;
        else if(enable) begin
            for(i = 0; i < neurons; i = i + 1) begin
                sum_res = sum_res + A[i];
            end 
        end
    end

    assign res = sum_res[11 : 4];


endmodule