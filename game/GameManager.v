`timescale 1ns / 1ps

/* TODO:
 * 1. control the game flow: init, game, finish
 * 2. handle all input and output signals (this will be top module)
 * 3. cooperate modules: Player manager, Bubble manager, score calculate
 * 4. use a 64 (8*8, each img for 10*10 bits) bit array to represent the informations to show
 *    for this array, storing value represents the idx of img
 *      - 0 ~ 9: num'0' ~ num'9'
 *      - 10 ~ 12: player color1 ~ color3
 *      - 13 ~ 15: bullet color1 ~ color3
 *      - 16 ~ 18: bubble color1 ~ color3
 *      - remaining(19 ~ 32): dark
*/

module GameManager(
    input clk,
    input rst,
    input en, // for enter game or restart
    input [3:0] jstkPos, // up, down, left, right
    input jstkPress,
    output display // don't know how to handle the screen diplay for now
);

// ============================================================================== 
// 							    wire and reg
// ==============================================================================

// [Main: state]
reg [1:0] state, next_state;
parameter INIT = 0;
parameter GAME = 1;
parameter FINISH = 2;

// [Bubble]
wire bubbleFull;

// [Player]

// [Score]
wire scoreAchieve;
wire result = ((!bubbleFull) && (scoreAchieve));

// ==============================================================================
// 							    state update
// ==============================================================================

always @(posedge clk) begin
    if(rst) begin
        state <= INIT;
    end
    else begin
        state <= next_state;
    end
end

// ==============================================================================
// 							    state transition
// ==============================================================================

always @(*) begin
    next_state = state;
    case(state)
        INIT: begin
            if(en) next_state = GAME;
        end
        GAME: begin
            if(bubbleFull || scoreAchieve) next_state = FINISH;
        end
        FINISH: begin
            if(en) next_state = INIT;
        end
    endcase
end
    
endmodule
