module data_transform (
    input [15:0] x_axis_data,
    input [15:0] y_axis_data,
    input [15:0] z_axis_data,
    output [15:0] x_data,
    output [15:0] y_data,
    output [15:0] z_data
);

    assign x_data = (x_axis_data[15] == 1'b1) ? ((~(x_axis_data))+1'b1) : x_axis_data;
    assign y_data = (y_axis_data[15] == 1'b1) ? ((~(y_axis_data))+1'b1) : y_axis_data;
    assign z_data = (z_axis_data[15] == 1'b1) ? ((~(z_axis_data))+1'b1) : z_axis_data;
    
endmodule