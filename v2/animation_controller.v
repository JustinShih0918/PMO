module animation_controller (
    input wire clk,
    input wire rst,
    input wire go,
    input wire [7:0] ram_addr,
    output wire [131:0] ram_data,
);

    parameter LCD_H = 162;
    parameter LCD_W = 132;

    parameter IDLE = 0;
    parameter SMILE = 1;

    reg [1:0] state, next_state;
    always @(posedge clk) begin
        if(rst) state <= IDLE;
        else state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if(go) next_state <= SMILE;
                else next_state <= IDLE;
            end 
            SMILE: begin
                if(go) next_state <= IDLE;
                else next_state <= SMILE;
            end
            default: next_state <= state;
        endcase
    end


    
endmodule