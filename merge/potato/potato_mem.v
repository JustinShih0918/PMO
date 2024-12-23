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
    wire [15:0] tmp_data;
    blk_mem_gen_0 blk_mem_gen_0_inst (
        .clka(clk),
        .wea(1'b0),
        .addra(pixel_addr),
        .dina(16'h0000),
        .douta(tmp_data)
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
            pixel_addr <= 16'h0000;
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
            if(select == 0) ram_data <= (tmp_data >= 16'h0800) ? 16'hffff : tmp_data;
            else ram_data <= tmp_data; 
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 43 && ram_addr_y < 75) begin
            if(select == 1) ram_data <= (tmp_data >= 16'h0800) ? 16'hffff : tmp_data;
            else ram_data <= tmp_data;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 75 && ram_addr_y < 87) begin
            if(select == 4) ram_data <= 16'hffff;
            else ram_data <= 16'h0000;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 87 && ram_addr_y < 119) begin
            if(select == 2) ram_data <= (tmp_data >= 16'h0800) ? 16'hffff : tmp_data;
            else ram_data <= tmp_data;
        end
        else if(ram_addr_x > 11 && ram_addr_x < 121 && ram_addr_y > 119 && ram_addr_y < 151) begin
            if(select == 3) ram_data <= (tmp_data >= 16'h0800) ? 16'hffff : tmp_data;
            else ram_data <= tmp_data;
        end
        else ram_data <= ram_data;
    end

endmodule