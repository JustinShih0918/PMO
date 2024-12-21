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
    output reg [39:0] BubbleRow1,
    output reg [39:0] BubbleRow2,
    output reg [39:0] BubbleRow3,
    output reg [39:0] BubbleRow4,
    output wire bubbleFull
);

// ==============================================================================
// 							    wire and reg
// ==============================================================================
// [Bubble]
parameter [4:0] r_bubble = 16;
parameter [4:0] g_bubble = 17;
parameter [4:0] b_bubble = 18;
parameter [2:0] data_length = 5;
reg [39:0] bubbleGen;
reg [39:0] nextBubbleRow1;
reg [39:0] nextBubbleRow2;
reg [39:0] nextBubbleRow3;
reg [39:0] nextBubbleRow4;
reg [6:0] idx; // iterator to check if bubble gen num is valid

assign bubbleFull = BubbleRow4 != {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };

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
// 							    logic
// ==============================================================================

// [Bubble update]
always @(posedge clk) begin
    if(rst) begin
        BubbleRow1 <= { r_bubble, g_bubble, b_bubble, r_bubble, g_bubble, b_bubble, r_bubble, g_bubble };
        BubbleRow2 <= {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
        BubbleRow3 <= {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
        BubbleRow4 <= {`DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
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

// [Bubble Falling]
always @(posedge dclk) begin
    if(rst) begin
        nextBubbleRow1 = BubbleRow1;
        nextBubbleRow2 = BubbleRow2;
        nextBubbleRow3 = BubbleRow3;
        nextBubbleRow4 = BubbleRow4;
    end
    else begin
        nextBubbleRow1 = bubbleGen;
        nextBubbleRow2 = BubbleRow1;
        nextBubbleRow3 = BubbleRow2;
        nextBubbleRow4 = BubbleRow3;
    end
end

// [Bubble Generation]
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