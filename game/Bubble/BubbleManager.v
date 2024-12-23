`define DARK 5'd31
/* TODO
 * 1. store all existsing bubbles: different color, being pop or not, with 8*4 2D array
 * 2. cooperate falling, generating, popping logic
 * 3. receive the fired bullet's position, pop the according bubbles and caculate the score
*/

module BubbleManager(
    input clk,
    input dclk,
    input rst,
    input en,
    input jstkPress,
    input [2:0] shoot_pos,
    output reg [39:0] BubbleRow1,
    output reg [39:0] BubbleRow2,
    output reg [39:0] BubbleRow3,
    output reg [39:0] BubbleRow4,
    output reg [6:0] popCnt
);

// ==============================================================================
// 							    wire and reg
// ==============================================================================
parameter [2:0] data_length = 5;

// [state]
parameter POPPING = 0;
parameter FALLING = 1;

reg [1:0] state, next_state;
reg [39:0] fallingRow1, fallingRow2, fallingRow3, fallingRow4;

// [dclk]
reg prev_dclk;
wire dclk_edge;

// [Bubble]
parameter [4:0] r_bubble = 16;
parameter [4:0] g_bubble = 17;
parameter [4:0] b_bubble = 18;

reg [39:0] bubbleGen;
reg [39:0] nextBubbleRow1, nextBubbleRow2, nextBubbleRow3, nextBubbleRow4;
reg [6:0] idx, idx_i, idx_j; // iterator to check if bubble gen num is valid
reg [39:0] popRow1, popRow2, popRow3, popRow4;
reg [4:0] targetColor;

reg [6:0] next_popCnt;

// [RandomNum]
reg enabler;
reg [4:0] randomBubble;

wire [1:0] randomNum;

// ==============================================================================
// 							    module instance
// ==============================================================================
// [RandomNum]
randomNum randomNum_inst (
    .clk(clk),
    .rst(rst),
    .Num(randomNum)
);

// ==============================================================================
// 							    dclk edge
// ==============================================================================

always @(posedge clk) begin
    if(rst) begin
        prev_dclk <= 1'b0;
    end
    else begin
        prev_dclk <= dclk;
    end
end

assign dclk_edge = (dclk && !prev_dclk);

// ==============================================================================
//                                 FSM
// ==============================================================================

always @(posedge clk) begin
    if(rst) begin
        state <= FALLING;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        POPPING: 
            next_state = FALLING;
        FALLING: begin
            if(jstkPress) next_state = POPPING;
            else next_state = FALLING;
        end
        default: 
            next_state = FALLING;
    endcase
end

// ==============================================================================
// 							    Bubble Row Update
// ==============================================================================

always @(posedge clk) begin
    if(rst) begin
        BubbleRow1 <= { b_bubble, b_bubble, g_bubble, g_bubble, g_bubble, g_bubble, r_bubble, r_bubble };
        BubbleRow2 <= { `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
        BubbleRow3 <= { `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
        BubbleRow4 <= { `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
    end
    else begin
        if(en) begin
            BubbleRow1 <= nextBubbleRow1;
            BubbleRow2 <= nextBubbleRow2;
            BubbleRow3 <= nextBubbleRow3;
            BubbleRow4 <= nextBubbleRow4;
        end
        else begin
            BubbleRow1 <= BubbleRow1;
            BubbleRow2 <= BubbleRow2;
            BubbleRow3 <= BubbleRow3;
            BubbleRow4 <= BubbleRow4;
        end
    end
end

// ==============================================================================
// 							    row update logic
// ==============================================================================

always @(*) begin
    case(state)
        POPPING: begin
            nextBubbleRow1 = popRow1;
            nextBubbleRow2 = popRow2;
            nextBubbleRow3 = popRow3;
            nextBubbleRow4 = popRow4;
        end
        FALLING: begin
            if(dclk_edge) begin
                nextBubbleRow1 = fallingRow1;
                nextBubbleRow2 = fallingRow2;
                nextBubbleRow3 = fallingRow3;
                nextBubbleRow4 = fallingRow4;
            end
            else begin
                nextBubbleRow1 = BubbleRow1;
                nextBubbleRow2 = BubbleRow2;
                nextBubbleRow3 = BubbleRow3;
                nextBubbleRow4 = BubbleRow4;
            end
        end
        default: begin
            nextBubbleRow1 = BubbleRow1;
            nextBubbleRow2 = BubbleRow2;
            nextBubbleRow3 = BubbleRow3;
            nextBubbleRow4 = BubbleRow4;
        end
    endcase
end

// ==============================================================================
// 							    Bubble Falling
// ==============================================================================

always @(posedge clk) begin
    if(rst) begin
        fallingRow1 <= BubbleRow1;
        fallingRow2 <= BubbleRow2;
        fallingRow3 <= BubbleRow3;
        fallingRow4 <= BubbleRow4;
    end
    else begin
        fallingRow1 <= bubbleGen;
        fallingRow2 <= BubbleRow1;
        fallingRow3 <= BubbleRow2;
        fallingRow4 <= BubbleRow3;
    end
end

// ==============================================================================
// 							    Bubble Pop
// ==============================================================================
// [score counter]
always @(posedge clk) begin
    if(rst) begin
        popCnt <= 7'd0;
    end
    else begin
        popCnt <= next_popCnt;
    end
end

always @(*) begin
    idx_j = shoot_pos * data_length;
    targetColor = BubbleRow4[idx_j +: data_length];
end

always @(*) begin
    popRow1 = BubbleRow1;
    popRow2 = BubbleRow2;
    popRow3 = BubbleRow3;
end

always @(*) begin
    next_popCnt = popCnt;
    for(idx_i = 0; idx_i <= 39; idx_i = idx_i + 5) begin
        if(BubbleRow4[idx_i +: data_length] == targetColor) begin
            popRow4[idx_i +: data_length] = `DARK;
            if (popCnt < 127) next_popCnt = popCnt + 1;
            else next_popCnt = popCnt;
        end
        else begin
            popRow4[idx_i +: data_length] = BubbleRow4[idx_i +: data_length];
        end
    end
end

// testing version
/*always @(*) begin
    for(idx = 0; idx <= 39; idx = idx + 5) begin
        if(idx == shoot_pos*data_length) begin
            popRow1[idx +: data_length] = `DARK;
            popRow2[idx +: data_length] = `DARK;
            popRow3[idx +: data_length] = `DARK;
            popRow4[idx +: data_length] = `DARK;
        end
        else begin
            popRow1[idx +: data_length] = BubbleRow1[idx +: data_length];
            popRow2[idx +: data_length] = BubbleRow2[idx +: data_length];
            popRow3[idx +: data_length] = BubbleRow3[idx +: data_length];
            popRow4[idx +: data_length] = BubbleRow4[idx +: data_length];
        end
    end
end*/

// ==============================================================================
// 							    Bubble Generation
// ==============================================================================
// fake random
always @(*) begin
    bubbleGen = {BubbleRow1[29:20], BubbleRow1[39:30], BubbleRow1[9:0], BubbleRow1[19:10]};
    bubbleGen[randomNum * data_length +: data_length] = 16 + randomNum;
    bubbleGen[(randomNum * data_length * 2) +: data_length] = 16 + randomNum;
    bubbleGen[(randomNum * data_length * 3) +: data_length] = 16 + randomNum;
    bubbleGen[(35 - randomNum * data_length) +: data_length] = 16 + randomNum;

    // ensure all data is valid
    for(idx = 0; idx <= 39; idx = idx + 5) begin
        if(bubbleGen[idx +: data_length] < 16) bubbleGen[idx +: data_length] = 5'd16;
        else if(bubbleGen[idx +: data_length] > 18) bubbleGen[idx +: data_length] = 5'd18;
        else bubbleGen[idx] = bubbleGen[idx];
    end
end

endmodule