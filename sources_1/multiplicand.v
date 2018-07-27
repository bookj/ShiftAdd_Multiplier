`timescale 1ns / 1ps

module multiplicand(
    input i_RESET,
    input[3:0] i_A,
    input i_LOAD_cmd,
    output[3:0] r_A    
    );
    
    reg[3:0] r_A;
        
    always @(posedge i_LOAD_cmd, negedge i_RESET)
    begin
        if(i_RESET == 1'b0)
            r_A <= 4'b0000; // clear register
        else
            r_A <= i_A;     // load register   
    end
        
endmodule
