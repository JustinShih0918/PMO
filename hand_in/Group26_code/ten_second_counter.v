module ten_second_counter (
    input wire clk,
    input wire rst,
    input wire en,
    output reg done
);
    reg [4:0] cnt;
    
    always @(*) begin
        if(rst || !en) done <= 0;
        else if(cnt == 4'b1010) done <= 1;
        else done <= 0;
    end

    always @(posedge clk, posedge rst, negedge en) begin
        if(rst || !en) cnt <= 0;
        else if(en) cnt <= cnt + 1;
    end
    
endmodule