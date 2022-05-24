`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
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
				4'b0110: ALU_Ctrl_o<= 4'b0001; // or
				4'b0100: ALU_Ctrl_o <= 4'b0101; //xor
				4'b0010: ALU_Ctrl_o<= 4'b0111; // slt
				4'b0001: ALU_Ctrl_o <= 4'b0100; //sll
				4'b1101: ALU_Ctrl_o <= 4'b1000; //sra
			endcase
        2'b11: 
			case(func3)
				3'b000: ALU_Ctrl_o <= 4'b0010; //addi
				3'b010: ALU_Ctrl_o <= 4'b0111; //slti
				3'b001: ALU_Ctrl_o <= 4'b0100; //slli
				3'b101: ALU_Ctrl_o <= 4'b1001; //srli
			endcase
	endcase
end

endmodule
