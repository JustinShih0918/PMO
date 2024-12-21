`timescale 1ns / 1ps

module random_num_t;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [1:0] Num;

    // Instantiate the Unit Under Test (UUT)
    randomNum test0 (
        .dclk(clk), 
        .rst(rst), 
        .Num(Num)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;

        // Wait 100 ns for global rst to finish
        #100;
                
        // Add stimulus here
        rst = 1;
        #10;
        rst = 0;
    end
    
    always #5 clk = ~clk; // Generate clock with period of 10 ns

endmodule