`timescale 1ns/1ps

module Shift_Left_1(
    input  		[32-1:0] data_i,
    output reg  [32-1:0] data_o
    );
assign data_o = {data_i[30:0],0};

endmodule
