module setting_mem (
    input wire clk,
    input wire rst,
    input wire cnt_mode,
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    output reg [15:0] ram_data
);

    wire [15:0] data_plus;
    wire [15:0] data_minus;
    wire [11:0] pixel_addr;
    blk_mem_gen_4 blk_mem_gen_4_inst(
        .clka(clk),
        .wea(1'b0),
        .addra(pixel_addr),
        .dina(16'h0000),
        .douta(data_plus)
    );

    blk_mem_gen_5 blk_mem_gen_5_inst(
        .clka(clk),
        .wea(1'b0),
        .addra(pixel_addr),
        .dina(16'h0000),
        .douta(data_minus)
    );

    parameter IMG_WIDTH = 44;
    parameter IMG_HEIGHT = 54;
    assign pixel_addr = ((ram_addr_x/3) % IMG_WIDTH + (ram_addr_y/3) * IMG_WIDTH) % (IMG_HEIGHT * IMG_WIDTH);

    always @(*) begin
        if(cnt_mode == 1'b0) ram_data <= data_minus;
        else ram_data <= data_plus;
    end
endmodule