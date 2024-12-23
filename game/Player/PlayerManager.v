`define DARK 5'd31
/* TODO
 * 1. cooperate player moving and shooting logic
 * 2. player's different color bullet (use random color generator)
 * 3. output the shooted bullet's position: 0 ~ 8, according to player's position
*/

module PlayerManager(
    input clk,
    input dclk,
    input rst,
    input en,
    input [3:0] jstkPos,
    output reg [39:0] PlayerRow,
    output reg [2:0] player_pos,
    
    // for debugging
    output reg [8:0] pos_led
);

// ==============================================================================
// 							    wire and reg
// ==============================================================================
parameter [4:0] r_player = 10;
parameter [4:0] g_player = 11;
parameter [4:0] b_player = 12;
parameter [2:0] data_length = 5;

reg [39:0] nextPlayerRow;
reg [2:0] next_player_pos;
wire right, left;

assign left = jstkPos[2];
assign right = jstkPos[3];

reg[6:0] idx;

// ==============================================================================
// 							    logic
// ==============================================================================

// [Player Row update]
always @(posedge clk) begin
    if(rst) begin
        PlayerRow <= { `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
    end
    else begin
        PlayerRow <= nextPlayerRow;
    end
end

always @(*) begin
    //nextPlayerRow = { `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK, `DARK };
    //nextPlayerRow[player_pos*data_length +: data_length] = r_player; // TODO: player color
    for(idx = 0; idx <= 39; idx = idx + 5) begin
        if(idx == (player_pos*data_length))
            nextPlayerRow[idx +: data_length] = r_player;
        else
            nextPlayerRow[idx +: data_length] = `DARK;
    end
end

// [Player position]
always @(posedge clk) begin
    if(rst) begin
        player_pos <= 1;
    end
    else begin 
        player_pos <= next_player_pos;
    end
end

always @(*) begin
    next_player_pos = player_pos;
    if(left) begin
        if(player_pos < 7)
            next_player_pos = player_pos + 1;
    end
    else if(right) begin
        if(player_pos > 0)
            next_player_pos = player_pos - 1;
    end
end

// [for debugging]
always @(*) begin
    pos_led = 8'b00000000;
    pos_led[player_pos] = 1;
    pos_led[8] = 0;
end

endmodule