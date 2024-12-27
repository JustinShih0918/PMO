`timescale 1ns / 1ps
`define DARK 5'd31

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
    output reg finished
);

// ============================================================================== 
// 							    wire and reg
// ==============================================================================
// [Bubble]

// [Player]
wire [2:0] player_pos;

// [Score]

// [dclk]
wire dclk;

// [game counter]
reg [5:0] game_counter, next_game_counter;

// ==============================================================================
// 							    module instance
// ==============================================================================

// [Bubble]
BubbleManager BubbleManager_inst (
    .clk(clk),
    .dclk(dclk),
    .rst(rst),
    .en(en),
    .jstkPress(jstkPress),
    .shoot_pos(player_pos),
    .BubbleRow1(Row2),
    .BubbleRow2(Row3),
    .BubbleRow3(Row4),
    .BubbleRow4(Row5)
);

// [Player]
PlayerManager PlayerManager_inst (
    .clk(clk),
    .dclk(dclk),
    .rst(rst),
    .en(en),
    .jstkPos(jstkPos),
    .PlayerRow(Row8),
    .player_pos(player_pos)
);

// [Score]

// [dclk]
clock_divider #(.n(28)) clock_divider_inst (.clk(clk), .clk_div(dclk));

// ==============================================================================
// 							    finished
// ==============================================================================

always @(posedge clk) begin
    if(rst) begin
        game_counter <= 0;
        finished <= 0;
    end else begin
        if(game_counter >= 15) begin
            game_counter <= 0;
            finished <= 1;
        end else begin
            game_counter <= next_game_counter;
            finished <= 0;
        end
    end
end

always @(posedge dclk) begin
    if(rst) begin
        next_game_counter <= 0;
    end else begin
        next_game_counter <= game_counter + 1;
    end
end

// ==============================================================================
// 							    output: Row1 ~ Row8
// ==============================================================================

assign Row1 = {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK};
assign Row6 = {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK};
assign Row7 = {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK};

    
endmodule
