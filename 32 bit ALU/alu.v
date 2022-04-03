`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

wire [31:0]ans;
wire [31:0]out2in;

wire o,set;
assign {o,set} = (src1[31]+(~src2[31])+out2in[30]);

genvar i;
generate
	for(i=0;i<32;i=i+1) begin: mod
		if(i==0)
			alu_1bit alu(src1[i],src2[i],set,ALU_control[3],ALU_control[2],ALU_control[2],ALU_control[1:0],ans[i],out2in[i]);
		else
			alu_1bit alu(src1[i],src2[i],0,ALU_control[3],ALU_control[2],out2in[i-1],ALU_control[1:0],ans[i],out2in[i]);
	end
endgenerate

always@(*) begin
	if(~rst_n)
	begin 
		result <= 0;
		zero <= 0;
		cout <= 0;
		overflow <= 0;
	end
	else
	begin
		cout <= out2in[31] && (ALU_control[1:0]==2'b10);
		result <= ans;
		
		zero <= ~(|result);
        
		overflow <=  (^out2in[31:30]) && (ALU_control[1:0]==2'b10);
	end
end
endmodule
