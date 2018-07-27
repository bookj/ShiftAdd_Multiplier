`timescale 1ns / 1ps

module adder(
    input[3:0] RA,
    input[3:0] RB,
    output C_out,
    output[3:0] Add_out
    );
    
    assign {C_out, Add_out} = RA + RB;
    
endmodule
