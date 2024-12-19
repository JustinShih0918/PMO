module idle (
    input wire clk,
    input wire rst,
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    output wire [15:0] ram_data
);
    reg [3:0] step;
    wire clk_23;
    clock_divider #(.n(23)) clock_divider_inst (.clk(clk), .clk_div(clk_23));
    idle_mem idle_mem_inst (.step(step), .ram_addr_x(ram_addr_x), .ram_addr_y(ram_addr_y), .ram_data(ram_data));
    always @(posedge clk) begin
        if(rst || step > 0) step <= 0;
        else step <= step + 1;   
    end
endmodule