module potato (
    input wire clk,
    input wire rst,
    input wire start,
    input wire up, 
    input wire down, 
    input wire left, 
    input wire right,
    input wire pressed,
    input wire mode,
    input wire [7:0] ram_addr_x,
    input wire [7:0] ram_addr_y,
    output wire finish,
    output wire [15:0] ram_data
);

    reg [4:0] minute2, minute1, second2, second1;
    reg [4:0] select;//5 for counting ,4 for confire, 3 for minute2, 2 for minute1, 1 for second2, 0 for second1
    reg countdown_finish;
    reg countup_timeout;
    parameter CONFIGURE = 0;
    parameter COUNTDOWN = 1;
    parameter COUNTUP = 2;
    assign finish = (mode == 1'b0) ? countdown_finish : countup_timeout;

    potato_mem potato_mem_inst(
        .clk(clk),
        .rst(rst),
        .select(select),
        .minute2(minute2),
        .minute1(minute1),
        .second2(second2),
        .second1(second1),
        .ram_addr_x(ram_addr_x),
        .ram_addr_y(ram_addr_y),
        .ram_data(ram_data)
    );

    reg [1:0] state, next_state;
    always @(posedge clk) begin
        if(rst) state <= CONFIGURE;
        else state <= next_state;
    end

    always @(*) begin
        case (state)
            CONFIGURE: begin
                if(mode == 1'b1 && pressed) next_state <= COUNTUP;
                else if(mode == 1'b0 && pressed && select == 4) next_state <= COUNTDOWN;
                else next_state <= CONFIGURE;  
            end 
            COUNTDOWN: begin
                if(countdown_finish) next_state <= CONFIGURE;
                else next_state <= COUNTDOWN;
            end
            COUNTUP: begin
                if(countup_timeout) next_state <= CONFIGURE;
                else next_state <= COUNTUP;
            end
            default: next_state <= state;
        endcase
    end

    reg [4:0] minute2_cnt, minute1_cnt, second2_cnt, second1_cnt;
    always @(posedge clk) begin
        if(rst) select <= 0;
        else if(state == CONFIGURE && start) begin
            if(left && select == 4) select <= 0;
            else if(right && select == 0) select <= 4;
            else if(left) select <= select + 1;
            else if(right) select <= select - 1;
        end
    end

    always @(posedge clk) begin
        minute1 <= minute1;
        minute2 <= minute2;
        second1 <= second1;
        second2 <= second2;
        if(rst) begin
            minute1 <= 0;
            minute2 <= 0;
            second1 <= 0;
            second2 <= 0;
        end
        else if(state == CONFIGURE && mode == 1'b0) begin
            if(select == 0) begin
                if(up && second1 < 9) second1 <= second1 + 1;
                else if(down && second1 > 0) second1 <= second1 - 1;
                else if(up && second1 == 9) begin
                    second1 <= 0;
                    second2 <= second2 + 1;
                    if(second2 == 5) begin
                        second2 <= 0;
                        minute1 <= minute1 + 1;
                        if(minute1 == 9) begin
                            minute1 <= 0;
                            minute2 <= minute2 + 1;
                        end
                    end
                end
            end
            else if(select == 1) begin
                if(up && second2 < 5) second2 <= second2 + 1;
                else if(down && second2 > 0) second2 <= second2 - 1;
                else if(up && second2 == 5) begin
                    second2 <= 0;
                    minute1 <= minute1 + 1;
                    if(minute1 == 9) begin
                        minute1 <= 0;
                        minute2 <= minute2 + 1;
                    end
                end
            end
            else if(select == 2) begin
                if(up && minute1 < 9) minute1 <= minute1 + 1;
                else if(down && minute1 > 0) minute1 <= minute1 - 1;
                else if(up && minute1 == 9) begin
                    minute1 <= 0;
                    minute2 <= minute2 + 1;
                end
            end
            else if(select == 3) begin
                if(up && minute2 < 5) minute2 <= minute2 + 1;
                else if(down && minute2 > 0) minute2 <= minute2 - 1;
            end
        end
        else if(state == CONFIGURE && mode == 1) begin
            minute1 <= 0;
            minute2 <= 0;
            second1 <= 0;
            second2 <= 0;
        end
        else if(state == COUNTDOWN) begin
            minute1 <= minute1_cnt;
            minute2 <= minute2_cnt;
            second1 <= second1_cnt;
            second2 <= second2_cnt;
        end
        else if(state == COUNTUP) begin
            minute1 <= minute1_cnt;
            minute2 <= minute2_cnt;
            second1 <= second1_cnt;
            second2 <= second2_cnt;
        end
        else begin
            minute1 <= minute1;
            minute2 <= minute2;
            second1 <= second1;
            second2 <= second2;
        end
    end

    wire clk_27;
    reg prev_dclk;
    wire dclk;
    clock_divider #(.n(27)) clk_div_inst(.clk(clk), .clk_div(clk_27));
    always @(posedge clk) begin
        if(rst) begin
            prev_dclk <= 1'b0;
        end
        else begin
            prev_dclk <= clk_27;
        end
    end
    assign dclk = clk_27 & ~prev_dclk;

    always @(posedge clk) begin
        if(rst) begin
            minute2_cnt <= minute2;
            minute1_cnt <= minute1;
            second2_cnt <= second2;
            second1_cnt <= second1;
            countdown_finish <= 0;
            countup_timeout <= 0;
        end
        else if(state == CONFIGURE) begin
            minute2_cnt <= minute2;
            minute1_cnt <= minute1;
            second2_cnt <= second2;
            second1_cnt <= second1;
            countdown_finish <= 0;
            countup_timeout <= 0;
        end
        else if(state == COUNTDOWN) begin
            if(minute2_cnt == 0 && minute1_cnt == 0 && second2_cnt == 0 && second1_cnt == 0) begin
                countdown_finish <= 1;
                minute2_cnt <= 0;
                minute1_cnt <= 0;
                second2_cnt <= 0;
                second1_cnt <= 0;
            end
            else if(dclk) begin
                if(second1_cnt == 0) begin
                    second1_cnt <= 9;
                    if(second2_cnt == 0) begin
                        second2_cnt <= 5;
                        if(minute1_cnt == 0) begin
                            minute1_cnt <= 9;
                            if(minute2_cnt == 0) begin
                                minute2_cnt <= 5;
                            end
                            else minute2_cnt <= minute2_cnt - 1;
                        end
                        else minute1_cnt <= minute1_cnt - 1;
                    end
                    else second2_cnt <= second2_cnt - 1;
                end
                else second1_cnt <= second1_cnt - 1;
            end
        end
        else if(state == COUNTUP) begin
            if(second2 == 1 && second1 == 5) begin
                countup_timeout <= 1;
                minute2_cnt <= 0;
                minute1_cnt <= 0;
                second2_cnt <= 0;
                second1_cnt <= 0;
            end
            else if(dclk && start) begin
               if(second1_cnt == 9) begin
                    second1_cnt <= 0;
                    if(second2_cnt == 5) begin
                        second2_cnt <= 0;
                        if(minute1_cnt == 9) begin
                            minute1_cnt <= 0;
                            if(minute2_cnt == 5) begin
                                minute2_cnt <= 0;
                            end
                            else minute2_cnt <= minute2_cnt + 1;
                        end
                        else minute1_cnt <= minute1_cnt + 1;
                    end
                    else second2_cnt <= second2_cnt + 1;
                end
                else second1_cnt <= second1_cnt + 1; 
            end
        end
    end


    
endmodule