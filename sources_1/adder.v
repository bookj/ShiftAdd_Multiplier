`timescale 1ns / 1ps

module adder(
    RA,
    RB,
    C_out,
    Add_out
    );

    input[3:0] RA, RB;
    output C_out;
    output[3:0] Add_out;
    
    assign {C_out, Add_out} = RA + RB;
    
endmodule
