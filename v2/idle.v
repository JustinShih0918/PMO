module idle (
    input wire clk,
    input wire rst,
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    output wire [15:0] ram_data
);
    reg [3:0] step;
    wire clk_25;
    clock_divider #(.n(25)) clock_divider_inst (.clk(clk), .clk_div(clk_25));
    idle_mem idle_mem_inst (.step(step), .ram_addr_x(ram_addr_x), .ram_addr_y(ram_addr_y), .ram_data(ram_data));
    always @(posedge clk_25) begin
        if(rst || step > 15) step <= 0;
        else step <= step + 1;   
    end
endmodule