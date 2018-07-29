`timescale 1ns / 1ps

module controller(
    i_CLK,
    i_RESET,
    i_START,
    i_LSB,
    o_ADD_cmd,
    o_SHIFT_cmd,
    o_LOAD_cmd,
    o_DONE
    );

    input i_CLK, i_RESET, i_START, i_LSB;
    output o_ADD_cmd, o_SHIFT_cmd, o_LOAD_cmd, o_DONE;
    
    reg [1:0] temp_count;
    reg [2:0] state;
    
    parameter   IDLE    = 3'b000,
                INIT    = 3'b001,
                TEST    = 3'b010,
                ADD     = 3'b011,
                SHIFT   = 3'b100;
                
    always @(posedge i_CLK or negedge i_RESET)
    begin
        if(i_RESET == 1'b0)
        begin
            state <= IDLE;
            temp_count <= 2'b00;
        end
        else
        begin
            case(state)
                IDLE:
                begin
                    if(i_START == 1'b1)
                        state <= INIT;
                    else
                        state <= IDLE;
                end
                INIT:
                begin
                    state <= TEST;
                end
                TEST:
                begin
                    if(i_LSB == 1'b0)
                        state <= SHIFT;
                    else
                        state <= ADD;
                end
                ADD:
                begin
                    state <= SHIFT;
                end
                SHIFT:
                begin
                    if(temp_count == 2'b11)     // verify if finished
                    begin
                        temp_count <= 2'b00;    // re-initialize counter
                        state <= IDLE;          // ready for next multiply
                    end
                    else
                    begin
                        temp_count <= temp_count + 1;   // increment counter
                        state <= TEST;
                    end
                end
            endcase
        end
    end
    
    assign o_DONE = (state == IDLE) ? 1'b1 : 1'b0;
    assign o_ADD_cmd = (state == ADD) ? 1'b1 : 1'b0;
    assign o_SHIFT_cmd = (state == SHIFT) ? 1'b1 : 1'b0;
    assign o_LOAD_cmd = (state == INIT) ? 1'b1 : 1'b0;
    
endmodule
