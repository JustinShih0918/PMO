`define DARK 5'd31
/* TODO
 * 1. find all the adjancent bubble that is in the same color
 * 2. pop the according bubbles
*/

module bubblePop(
    input clk,
    input dclk,
    input rst,
    input jstkPress,
    input [2:0] shoot_pos,
    input [39:0] BubbleRow1,
    input [39:0] BubbleRow2,
    input [39:0] BubbleRow3,
    input [39:0] BubbleRow4,
    output reg [39:0] popRow1,
    output reg [39:0] popRow2,
    output reg [39:0] popRow3,
    output reg [39:0] popRow4
);

// ==============================================================================
// 							    wire and reg
// ==============================================================================
parameter [2:0] data_length = 5;
reg [39:0] next_popRow1, next_popRow2, next_popRow3, next_popRow4;
reg [6:0] idx;
reg [4:0] targetColor;

// ==============================================================================
// 							    logic
// ==============================================================================
// testing version
always @(posedge clk) begin
    if(rst) begin
        popRow1 <= BubbleRow1;
        popRow2 <= BubbleRow2;
        popRow3 <= BubbleRow3;
        popRow4 <= BubbleRow4;
    end
    else begin
        popRow1 <= next_popRow1;
        popRow2 <= next_popRow2;
        popRow3 <= next_popRow3;
        popRow4 <= next_popRow4;
    end
end

always @(*) begin
    next_popRow1 = BubbleRow1 << 5;
    next_popRow2 = BubbleRow2 << 5;
    next_popRow3 = BubbleRow3 << 5;
    next_popRow4 = BubbleRow4 << 5;
end

/*always @(*) begin
    if(jstkPress) begin
        for(idx = 0; idx <= 39; idx = idx + 5) begin
            if(idx == shoot_pos*data_length) begin
                next_popRow1[idx +: data_length] = `DARK;
                next_popRow2[idx +: data_length] = `DARK;
                next_popRow3[idx +: data_length] = `DARK;
                next_popRow4[idx +: data_length] = `DARK;
            end
            else begin
                next_popRow1[idx +: data_length] = BubbleRow1[idx +: data_length];
                next_popRow2[idx +: data_length] = BubbleRow2[idx +: data_length];
                next_popRow3[idx +: data_length] = BubbleRow3[idx +: data_length];
                next_popRow4[idx +: data_length] = BubbleRow4[idx +: data_length];
            end
        end
    end
    else begin
        next_popRow1 = BubbleRow1;
        next_popRow2 = BubbleRow2;
        next_popRow3 = BubbleRow3;
        next_popRow4 = BubbleRow4;
    end
end*/

endmodule