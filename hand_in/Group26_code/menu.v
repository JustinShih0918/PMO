module menu (
    input wire clk,
    input wire rst,
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    input wire right,
    input wire left,
    output wire [1:0] mode,
    output wire [15:0] ram_data
);
    reg [1:0] step;
    assign mode = step;
    menu_mem menu_mem_inst (.step(step), .ram_addr_x(ram_addr_x), .ram_addr_y(ram_addr_y), .ram_data(ram_data)); 
    always @(posedge clk, posedge rst) begin
        if(rst) step <= 3;
        else if(step == 0 && right) step <= 2;
        else if(step == 2 && left) step <= 0;
        else if(right) step <= step - 1;
        else if(left) step <= step + 1;
    end
    
endmodule