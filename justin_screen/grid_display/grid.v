module grid (
    input wire clk,
    input wire rst,
    input [7:0] ram_addr_x,
    input [7:0] ram_addr_y,

    // from GM
    input [39:0] Row1,
    input [39:0] Row2,
    input [39:0] Row3,
    input [39:0] Row4,
    input [39:0] Row5,
    input [39:0] Row6,
    input [39:0] Row7,
    input [39:0] Row8,

    output reg [15:0] ram_data
);

// screen: 128*160
// grid: 16*16

// ============================================================================== 
// 							    wire, reg, parameter
// ==============================================================================

// diferrent color grids
parameter [15:0] bubbleR = 16'hfaac;
parameter [15:0] bubbleG = 16'h8760;
parameter [15:0] bubbleB = 16'h351f;
parameter [15:0] playerR = 16'hfcc0;

// display table
reg [15:0] grid_table [63:0];

// grid index
reg [5:0] grid_x, grid_y, grid_index;

// Row(img idx) to Grid(RGB data)
reg [6:0] idx_i, idx_j;
reg [4:0] one_data;
reg [39:0] concate_row [7:0];

// ==============================================================================
// 							    Row data tranlation
// ==============================================================================

always @(*) begin
    concate_row[0] = Row1;
    concate_row[1] = Row2;
    concate_row[2] = Row3;
    concate_row[3] = Row4;
    concate_row[4] = Row5;
    concate_row[5] = Row6;
    concate_row[6] = Row7;
    concate_row[7] = Row8;
end

always @(*) begin
    for(idx_i = 0; idx_i <= 7; idx_i = idx_i + 1) begin
        for(idx_j = 0; idx_j <= 39; idx_j = idx_j + 5) begin
            one_data = concate_row[idx_i][idx_j +: 5];
            case(one_data)
                16: grid_table[idx_j / 5 + idx_i*8] = bubbleR;
                17: grid_table[idx_j / 5 + idx_i*8] = bubbleG;
                18: grid_table[idx_j / 5 + idx_i*8] = bubbleB;
                default: grid_table[idx_j / 5 + idx_i*8] = 16'h0000;
            endcase
        end
    end
end

// ============================================================================== 
// 							    grid display
// ==============================================================================

always @(*) begin
    grid_x = ram_addr_x / 16;
    grid_y = (ram_addr_y - 16) / 16;
    grid_index = grid_x * 8 + grid_y;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        ram_data <= 16'b0;
    end else begin
        if (ram_addr_x >= 0 && ram_addr_x < 128 && 
            ram_addr_y >= 16 && ram_addr_y < 144) begin
                ram_data <= grid_table[grid_index];
                // TODO: handle img display: player, score, bullet
        end else begin
            ram_data <= 16'b0;
        end
    end
end

endmodule