module potato_mem (
    input wire clk,
    input wire rst,
    input wire [4:0] select,
    input wire [4:0] minute2, minute1, second2, second1,
    input [7:0] ram_addr_x,
    input [7:0] ram_addr_y,
    output reg [15:0] ram_data
);


    reg [15:0] pixel_addr;
    wire [15:0] white_data;
    blk_mem_gen_0 blk_mem_gen_0_inst ( // white
        .clka(clk),
        .wea(1'b0),
        .addra(pixel_addr),
        .dina(16'h0000),
        .douta(white_data)
    );

    wire [15:0] green_data;
    blk_mem_gen_1 blk_mem_gen_1_inst ( // green
        .clka(clk),
        .wea(1'b0),
        .addra(pixel_addr),
        .dina(16'h0000),
        .douta(green_data)
    );

    wire [15:0] green_colon;
    wire [15:0] white_colon;
    blk_mem_gen_2 blk_mem_gen_2_inst ( // green_colon
        .clka(clk),
        .wea(1'b0),
        .addra(pixel_addr),
        .dina(16'h0000),
        .douta(green_colon)
    );

    blk_mem_gen_3 blk_mem_gen_3_inst ( // white_colon
        .clka(clk),
        .wea(1'b0),
        .addra(pixel_addr),
        .dina(16'h0000),
        .douta(white_colon)
    );

    always @(*) begin
        if((ram_addr_x >= 0 && ram_addr_x <= 132 && ram_addr_y >= 0 && ram_addr_y <= 11)
            || (ram_addr_x >= 0 && ram_addr_x <= 132 && ram_addr_y >= 151 && ram_addr_y <= 162)
            || (ram_addr_x >= 0 && ram_addr_x <= 11 && ram_addr_y >= 0 && ram_addr_y <= 162)
            || (ram_addr_x >= 121 && ram_addr_x <= 132 && ram_addr_y >= 0 && ram_addr_y <= 162)) pixel_addr <= 16'h0000;
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 11 && ram_addr_y < 43) begin
            pixel_addr <= (ram_addr_x-11)/2 + (ram_addr_y-11)/2 * 55 + second1 * 880;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 43 && ram_addr_y < 75) begin
            pixel_addr <= (ram_addr_x-11)/2 + (ram_addr_y-43)/2 * 55 + second2 * 880;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 75 && ram_addr_y < 87) begin
            pixel_addr <= (ram_addr_x-11)/2 + (ram_addr_y-75)/2 * 55;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 87 && ram_addr_y < 119) begin
            pixel_addr <= (ram_addr_x-11)/2 + (ram_addr_y-87)/2 * 55 + minute1 * 880;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 119 && ram_addr_y < 151) begin
            pixel_addr <= (ram_addr_x-11)/2 + (ram_addr_y-119)/2 * 55 + minute2 * 880;
        end
        else pixel_addr <= pixel_addr;
    end

    always @(*) begin
        if((ram_addr_x >= 0 && ram_addr_x <= 132 && ram_addr_y >= 0 && ram_addr_y <= 11)
            || (ram_addr_x >= 0 && ram_addr_x <= 132 && ram_addr_y >= 151 && ram_addr_y <= 162)
            || (ram_addr_x >= 0 && ram_addr_x <= 11 && ram_addr_y >= 0 && ram_addr_y <= 162)
            || (ram_addr_x >= 121 && ram_addr_x <= 132 && ram_addr_y >= 0 && ram_addr_y <= 162)) ram_data <= 16'h0000;
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 11 && ram_addr_y < 43) begin
            if(select == 0) ram_data <= green_data;
            else ram_data <= white_data;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 43 && ram_addr_y < 75) begin
            if(select == 1) ram_data <= green_data;
            else ram_data <= white_data;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 75 && ram_addr_y < 87) begin
            if(select == 4) ram_data <= green_colon;
            else ram_data <= white_colon;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 87 && ram_addr_y < 119) begin
            if(select == 2) ram_data <= green_data;
            else ram_data <= white_data;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 119 && ram_addr_y < 151) begin
            if(select == 3) ram_data <= green_data;
            else ram_data <= white_data;
        end
        else ram_data <= ram_data;
    end

endmodule