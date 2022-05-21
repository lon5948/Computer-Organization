`timescale 1ns/1ps

module Decoder(
    input [32-1:0]  instr_i,
    input branch_i,
    output reg         Branch,
    output reg         ALUSrc,
    output reg         RegWrite,
    output reg [2-1:0] ALUOp,
    output reg         MemRead,
    output reg         MemWrite,
    output reg         MemtoReg,
    output reg         Jump
);

//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;


assign RegWrite = (instr_i[5:2] == 4'b1000)? 0:1 ; // store and branch should be 0
assign Branch = ((instr_i[6:0]==7'b1100011) and branch_i)? 1:0;// only branch
assign Jump = instr_i[2];  // jal or jalr 
assign MemtoReg = (instr_i[6:0]==7'b0000011)? 1:0; // only load
assign MemRead = (instr_i[6:0]==7'b0000011)? 1:0; // only load
assign MemWrite =  (instr_i[6:0]==7'b0100011)? 1:0; // only store
assign ALUSrc = (instr_i[6:5]==2'b00||instr_i[6:4]==3'b010)? 1:0; // addi, load, store
// lw,sw:00,branch:01,r-type:10,addi:11
assign ALUOp =  (instr_i[6:5]==2'b11)? 2'b01 : (instr_i[5:4]==2'b11)? 2'b10 : (instr_i[4]==1'b1)? 2'b11 : 2'b00;


endmodule







