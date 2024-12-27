
/* TODO
 * 1. random number generator: generate img index that is between 0-2
*/

module randomNum(
    input clk,
    input rst,
    output reg [1:0] Num
);

reg [7:0] LFSR;

always @(posedge clk) begin
    if (rst) begin
        LFSR <= 8'o1;
        Num <= 0;
    end else begin
        LFSR[0] <= ~(LFSR[3] ^ LFSR[4] ^ LFSR[5] ^ LFSR[7]);
        LFSR[7:1] <= LFSR[6:0];
        Num <= LFSR % 8'd3;
    end
end

endmodule