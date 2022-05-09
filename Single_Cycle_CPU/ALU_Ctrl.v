
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output      [4-1:0] ALU_Ctrl_o
);
wire [2:0] func3;
assign func3 = instr[2:0];

always@(*) begin
	case(ALUOp)
		2'b00: ALU_Ctrl_o <= 4'b0010;  // ld and sd
		2'b01: ALU_Ctrl_o <= 4'b0110; // beq
		2'b10: // R-type
			case(instr)
				4'b0000: ALU_Ctrl_o <= 4'b0010; // add 
				4'b1000: ALU_Ctrl_o <= 4'b0110; // sub
				4'b0111: ALU_Ctrl_o <= 4'b0000; // and
				4'b0110: ALU_Ctrl_o <= 4'b0001; // or
				4'b0010: ALU_Ctrl_o <= 4'b0111; // slt
			endcase
        2'b11: ALU_Ctrl_o <= 4'b0010; // addi
	endcase
end

endmodule

