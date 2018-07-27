`timescale 1ns / 1ps

module multiplier_tb();
    
    reg[3:0] r_A_tb, r_B_tb;
    reg r_CLK_tb, r_RESET_tb, r_START_tb;
    wire w_DONE_tb;
    wire[7:0] w_Y_tb;
    
    multiplier m1(
        .i_A(r_A_tb),
        .i_B(r_B_tb),
        .i_CLK(r_CLK_tb),
        .i_RESET(r_RESET_tb),
        .o_Y(w_Y_tb),
        .i_START(r_START_tb),
        .o_DONE(w_DONE_tb)
        );
        
    initial
    begin
        #0  r_CLK_tb = 0;
            r_RESET_tb = 0;
            r_A_tb = 11;
            r_B_tb = 14;
            r_START_tb = 0;
        #50 r_RESET_tb = 1;
        #50 r_START_tb = 1;       // request the multiplier to start
    end
    
//    initial
//    begin
//        #390 r_RESET_tb = 0;
//    end
    
    always
        #10 r_CLK_tb = ~r_CLK_tb;
    
endmodule
