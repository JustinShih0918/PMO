`timescale 1ns / 1ps
`define DARK 5'd31
`define R_PLAYER 5'd10
`define G_PLAYER 5'd11
`define B_PLAYER 5'd12
`define R_BULLET 5'd13
`define G_BULLET 5'd14
`define B_BULLET 5'd15

/* TODO:
 * 1. control the game flow: init, game, finish
 * 2. handle all input and output signals (this will be top module)
 * 3. cooperate modules: Player manager, Bubble manager, score calculate
 * 4. use a 64 (8*8, each img for 16*16 bits) bit array to represent the informations to show
 *    for this array, storing value represents the idx of img
 *      - 0 ~ 9: num'0' ~ num'9'
 *      - 10 ~ 12: player color1 ~ color3
 *      - 13 ~ 15: bullet color1 ~ color3
 *      - 16 ~ 18: bubble color1 ~ color3
 *      - remaining(19 ~ 31): dark
*/

module GameManager(
    input clk,
    input rst,
    input en, // for enter game or restart
    input [3:0] jstkPos, // up, down, left, right
    input jstkPress,

    output [39:0] Row1, // score
    output [39:0] Row2, // bubbles row 1
    output [39:0] Row3, // bubbles row 2
    output [39:0] Row4, // bubbles row 3
    output [39:0] Row5, // bubbles row 4
    output [39:0] Row6, // enpty area
    output [39:0] Row7, // empty area
    output [39:0] Row8,  // player

    // for debugging
    output [15:0] led
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

// [dclk]
wire dclk;

// ==============================================================================
// 							    module instance
// ==============================================================================

// [Bubble]
BubbleManager BubbleManager_inst (
    .clk(clk),
    .dclk(dclk),
    .rst(rst),
    .en(en),
    .BubbleRow1(Row2),
    .BubbleRow2(Row3),
    .BubbleRow3(Row4),
    .BubbleRow4(Row5),
    .bubbleFull(bubbleFull)
);

// [Player]
PlayerManager PlayerManager_inst (
    .clk(clk),
    .dclk(dclk),
    .rst(rst),
    .en(en),
    .jstkPos(jstkPos),
    .jstkPress(jstkPress),
    .PlayerRow(Row8),
    .pos_led(led[8:0])
);

// [Score]

// [dclk]
clock_divider #(.n(25)) clock_divider_inst (.clk(clk), .clk_div(dclk));

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
        default: next_state = state;
    endcase
end

// ==============================================================================
// 							    output: Row1 ~ Row8
// ==============================================================================

// [Row1: score]
// TODO: display score
assign Row1 = {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK};

// [Row2 ~ Row5: bubbles]

// [Row6 ~ Row7: empty area]
assign Row6 = {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK};
assign Row7 = {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK};

// [Row8: player]
    
endmodule
