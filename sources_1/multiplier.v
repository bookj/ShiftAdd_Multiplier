`timescale 1ns / 1ps

module multiplier(
    i_A,
    i_B,
    i_CLK,
    i_RESET,
    i_START,
    o_Y,
    o_DONE
    );

    input[3:0] i_A, i_B;
    input i_CLK, i_RESET, i_START;
    output[7:0] o_Y;
    output o_DONE;
    
    wire w_ADD_cmd;
    wire [3:0] w_Add_out;
    wire w_C_out;
    wire w_LOAD_cmd;
    wire w_LSB;
    wire [3:0] RA, RB;
    wire SHIFT_cmd;
    
    adder inst1(
        .RA(RA),
        .RB(RB),
        .C_out(w_C_out),
        .Add_out(w_Add_out)
        );
        
    controller inst2(
        .i_RESET(i_RESET),
        .i_CLK(i_CLK),
        .i_START(i_START),
        .i_LSB(w_LSB),
        .o_ADD_cmd(w_ADD_cmd),
        .o_SHIFT_cmd(SHIFT_cmd),
        .o_LOAD_cmd(w_LOAD_cmd),
        .o_DONE(o_DONE)
        );
        
    multiplicand inst3(
        .i_RESET(i_RESET),
        .i_A(i_A),
        .i_LOAD_cmd(w_LOAD_cmd),
        .r_A(RA)
        );
    
    multiplier_result inst4(
        .i_RESET(i_RESET),
        .i_CLK(i_CLK),
        .i_B(i_B),
        .i_LOAD_cmd(w_LOAD_cmd),
        .i_SHIFT_cmd(SHIFT_cmd),
        .i_ADD_cmd(w_ADD_cmd),
        .i_Add_out(w_Add_out),
        .i_C_out(w_C_out),
        .o_mult_result(o_Y),
        .o_LSB(w_LSB),
        .o_ACC_7_4(RB)
        );
        
endmodule
