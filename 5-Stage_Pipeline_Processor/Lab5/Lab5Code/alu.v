`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input        [32-1:0]   src1,          // 32 bits source 1          (input)
    input        [32-1:0]   src2,          // 32 bits source 2          (input)
    input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg   [32-1:0]   result,        // 32 bits result            (output)
    output reg              zero           // 1 bit when the output is 0, zero must be set (output)
);

always@(*) begin
	if(~rst_n)
	begin 
		result <= 0;
        zero <= 0;
	end
	else
	begin
		case(ALU_control)
			4'b0010: // add
                result <= src1 + src2;
            4'b0110: // sub
                result <= src1 - src2;
            4'b0000: // and
                result <= src1 & src2;
            4'b0001: // or
                result <= src1 | src2;
            4'b0111: // slt
                begin
                    result[31:1] <= 0;
                    result[0] <= (src1 < src2);
                end
		endcase
        zero <= ~(|result);
	end
end
endmodule
