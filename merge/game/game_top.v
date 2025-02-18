module game_top (
    input wire clk,
    input wire rst,
    input wire en, // start_game
    input wire [3:0] jstkPos, // up, down, left, right
    input wire jstkPress, // pressed
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    output wire finish_game,
    output wire [15:0] ram_data
);

    wire [39:0] Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8;


    GameManager GameManager_inst(
        .clk(clk),
        .rst(rst),
        .en(en),
        .jstkPos(jstkPos),
        .jstkPress(jstkPress),
        .Row1(Row1),
        .Row2(Row2),
        .Row3(Row3),
        .Row4(Row4),
        .Row5(Row5),
        .Row6(Row6),
        .Row7(Row7),
        .Row8(Row8),
        .finished(finish_game)
    );

    grid grid_inst(
        .clk(clk),
        .rst(rst),
        .Row1(Row1),
        .Row2(Row2),
        .Row3(Row3),
        .Row4(Row4),
        .Row5(Row5),
        .Row6(Row6),
        .Row7(Row7),
        .Row8(Row8),
        .ram_addr_x(ram_addr_x),
        .ram_addr_y(ram_addr_y),
        .ram_data(ram_data)
    );
    
endmodule