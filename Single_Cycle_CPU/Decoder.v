
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

<<<<<<< HEAD
assign RegWrite = (instr_i[5:2] == 4'b1000)? 0:1 ; // store and branch should be 0
assign Branch = (instr_i[6:0]==7'b1100011)? 1:0; // only branch
assign Jump = instr_i[2];  // jal or jalr 
assign WriteBack1 = instr_i[2];  // jal or jalr
assign WriteBack0 = (instr_i[6:0]==7'b0000011)? 1:0; // only load
assign MemRead = (instr_i[6:0]==7'b0000011)? 1:0; // only load
assign MemWrite =  (instr_i[6:0]==7'b0100011)? 1:0; // only store
assign ALUSrcA = (instr_i[6:0]==7'b1100111)? 1:0; // only jalr (src1 + immd)
assign ALUSrcB = (instr_i[6:5]==2'b00||instr_i[6:4]==3'b010)? 1:0; // addi, load, store
=======
assign RegWrite = (instr_1[5:2] == 4'b1000)? 0:1 ; // store and branch should be 0
assign Branch = (instr_1[6:0]==7'b1100011)? 1:0; // only branch
assign Jump = instr_1[2];  // jal or jalr 
assign WriteBack1 = instr_1[2];  // jal or jalr
assign WriteBack0 = (instr_1[6:0]==7'b0000011)? 1:0; // only load
assign MemRead = (instr_1[6:0]==7'b0000011)? 1:0; // only load
assign MemWrite =  (instr_1[6:0]==7'b0100011)? 1:0; // only store
assign ALUSrcA = (instr_1[6:0]==7'b1100111)? 1:0; // only jalr (src1 + immd)
assign ALUSrcB = (instr_1[6:5]==2'b00||instr_1[6:4]==3'b010)? 1:0; // addi, load, store
>>>>>>> b2c642783c35acd2d5ea2a87bcefc30fae909357
// lw,sw:00,branch:01,r-type:10,addi:11
assign ALUOp =  (instr_i[6:5]==2'b11)? 2'b01 : (instr_i[5:4]==2'b11)? 2'b10 : (instr_i[4]==1'b1)? 2'b11 : 2'b00;

endmodule

