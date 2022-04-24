`timescale 1ns/1ps

module alu_1bit(
	input				src1,       //   1 bit source 1  (input)
	input				src2,       //   1 bit source 2  (input)
	input				less,       //   1 bit less      (input)
	input 				Ainvert,    //   1 bit A_invert  (input)
	input				Binvert,    //   1 bit B_invert  (input)
	input 				cin,        //   1 bit carry in  (input)
	input 	    [2-1:0] operation,  //   2 bit operation (input)
	output reg          result,     //   1 bit result    (output)
	output reg          cout        //   1 bit carry out (output)
	);

wire a,b;
MUX2to1 M1(src1,~src1,Ainvert,a);
MUX2to1 M2(src2,~src2,Binvert,b);

wire ab_and,ab_or;
wire [1:0]add;
assign ab_and = a & b;
assign ab_or = a | b;
assign add = a + b + cin;

wire ans;
MUX4to1 Mr(ab_and,ab_or,add[0],less,operation,ans);

always@(*) begin
	
	result <= ans;
	case(operation[1])
		1'b0: cout <= 0;
		1'b1: cout <= add[1];
	endcase
end
endmodule
