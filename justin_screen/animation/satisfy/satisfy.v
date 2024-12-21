module satisfy (
    input wire clk,
    input wire rst,
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    output wire [15:0] ram_data
);
    reg [3:0] step;
    wire clk_24;
    clock_divider #(.n(24)) clock_divider_inst (.clk(clk), .clk_div(clk_24));
    satisfy_mem satisfy_mem_inst (.step(step), .ram_addr_x(ram_addr_x), .ram_addr_y(ram_addr_y), .ram_data(ram_data));
    always @(posedge clk_24, posedge rst) begin
        if(rst || step > 15) step <= 0;
        else step <= step + 1;   
    end
endmodule