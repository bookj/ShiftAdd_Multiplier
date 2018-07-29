`timescale 1ns / 1ps

module multiplicand(
    i_RESET,
    i_A,
    i_LOAD_cmd,
    r_A    
    );

    input i_RESET, i_LOAD_cmd;
    input[3:0] i_A;
    output reg [3:0] r_A;   
        
    always @(posedge i_LOAD_cmd, negedge i_RESET)
    begin
        if(i_RESET == 1'b0)
            r_A <= 4'b0000;     // clear register
        else
            r_A <= i_A;         // load register   
    end
        
endmodule
