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
    output reg         Jump,
    output reg         Flush
);

//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;

assign opcode = instr_i[6:0];
always@(*)begin
    RegWrite <= (opcode[5:2] == 4'b1000)? 0:1 ; // store and branch should be 0
    Branch <= ((opcode[6:0]==7'b1100011) && branch_i)? 1:0;// only branch
    Jump <= opcode[2];  // jal or jalr 
    MemtoReg <= (opcode[6:0]==7'b0000011)? 1:0; // only load
    MemRead <= (opcode[6:0]==7'b0000011)? 1:0; // only load
    MemWrite <=  (opcode[6:0]==7'b0100011)? 1:0; // only store
    ALUSrc <= (opcode[6:5]==2'b00||opcode[6:4]==3'b010)? 1:0; // addi, load, store
    // lw,sw:00,branch:01,r-type:10,addi:11
    ALUOp <=  (opcode[6:5]==2'b11)? 2'b01 : (opcode[5:4]==2'b11)? 2'b10 : (opcode[4]==1'b1)? 2'b11 : 2'b00;
    Flush <= Branch || Jump;
end
endmodule







