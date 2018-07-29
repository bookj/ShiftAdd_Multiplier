`timescale 1ns / 1ps

module multiplier_result(
    i_CLK,
    i_RESET,
    i_B,
    i_LOAD_cmd,
    i_SHIFT_cmd,
    i_ADD_cmd,
    i_Add_out,
    i_C_out,
    o_mult_result,
    o_LSB,
    o_ACC_7_4
    );

    input i_CLK, i_RESET;
    input i_ADD_cmd, i_LOAD_cmd, i_SHIFT_cmd;
    input i_C_out;
    input[3:0] i_B, i_Add_out;
    output o_LSB;
    output[3:0] o_ACC_7_4;
    output[7:0] o_mult_result;
    
    reg[8:0] r_ACC;
    reg r_temp_Add_cmd;
    
    always @(posedge i_CLK, negedge i_RESET)
    begin
        if(i_RESET == 1'b0)
        begin
            r_ACC <= 9'd0;              // initialize temporary register
            r_temp_Add_cmd <= 1'b0;
        end
        else
        begin
            if(i_LOAD_cmd == 1'b1)
            begin
                r_ACC[8:4] <= 5'b0_0000;
                r_ACC[3:0] <= i_B;     // load i_B into register
            end
            
            if(i_ADD_cmd == 1'b1)
            begin
                r_temp_Add_cmd <= 1'b1;
            end
            
            if(i_SHIFT_cmd == 1'b1)
            begin
                if(r_temp_Add_cmd == 1'b1)
                begin
                    // store adder output while shifting register right 1 bit
                    r_temp_Add_cmd <= 1'b0;
                    r_ACC <= {1'b0, i_C_out, i_Add_out, r_ACC[3:1]};
                end
                else
                begin
                    // no add - simply shift right 1 bit
                    r_ACC <= {1'b0, r_ACC[8:1]};
                end 
            end 
        end
    end
    
    assign o_ACC_7_4 = r_ACC[7:4];
    assign o_LSB = r_ACC[0];
    assign o_mult_result = r_ACC[7:0];
   
endmodule
