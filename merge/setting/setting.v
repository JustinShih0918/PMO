module setting (
    input wire clk,
    input wire rst,
    input wire start,
    input wire pressed,
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    output reg cnt_mode,
    output wire [15:0] ram_data
);

    setting_mem setting_mem_inst(
        .clk(clk),
        .rst(rst),
        .cnt_mode(cnt_mode),
        .ram_addr_x(ram_addr_x),
        .ram_addr_y(ram_addr_y),
        .ram_data(ram_data)
    );

    always @(posedge clk) begin
        if(rst) cnt_mode <= 0;
        else if(pressed && start) cnt_mode <= ~cnt_mode;
    end

    
endmodule