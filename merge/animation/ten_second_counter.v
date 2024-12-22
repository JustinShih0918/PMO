module ten_second_counter (
    input wire clk,
    input wire rst,
    input wire en,
    output wire done
);
    wire [4:0] cnt;
    
    always @(*) begin
        if(rst) done <= 0;
        else if(cnt == 4'b1010) done <= 1;
        else done <= 0;
    end

    always @(posedge clk, posedge rst) begin
        if(rst) cnt <= 0;
        else if(en) cnt <= cnt + 1;
    end
    
endmodule