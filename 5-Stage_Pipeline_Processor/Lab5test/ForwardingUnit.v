`timescale 1ns/1ps
module ForwardingUnit (
    input [5-1:0] IDEXE_RS1,
    input [5-1:0] IDEXE_RS2,
    input [5-1:0] EXEMEM_RD,
    input [5-1:0] MEMWB_RD,
    input         EXEMEM_RegWrite,
    input         MEMWB_RegWrite,
    output reg [2-1:0] ForwardA,
    output reg [2-1:0] ForwardB
);

always@(*) begin
    // Forward A
    /*
    EXEMEM_RegWrite==1'b1 or MEMWB_RegWrite==1'b1 -> need write back
    EXEMEM_RD!=0 or MEMWB_RD!=0 -> not nop
    IDEXE_RS1==EXEMEM_RD or IDEXE_RS1==MEMWB_RD -> data dependency occur
    */
    if((EXEMEM_RegWrite==1'b1) && (EXEMEM_RD!=0) && (IDEXE_RS1==EXEMEM_RD)) begin
        ForwardA = 2'b10; // ALUSrc1 = ALUResult
    end
    else if((MEMWB_RegWrite==1'b1) && (MEMWB_RD!=0) && (IDEXE_RS1==MEMWB_RD)) begin
        ForwardA = 2'b01; // ALUSrc1 = MUXMemtoReg_o
    end
    else begin
        ForwardA = 2'b00; // other -> ALUSrc1 = RTdata or Imm (chosen by ALUSrc) 
    end
    
    // Forward B
    if((EXEMEM_RegWrite==1'b1) && (EXEMEM_RD!=0) && (IDEXE_RS2==EXEMEM_RD)) begin
        ForwardB = 2'b10; // ALUSrc2 = ALUResult
    end
    else if((MEMWB_RegWrite==1'b1) && (MEMWB_RD!=0) && (IDEXE_RS2==MEMWB_RD)) begin
        ForwardB = 2'b01; // ALUSrc1 = MUXMemtoReg_o
    end
    else begin
        ForwardB = 2'b00; // other -> ALUSrc1 = RTdata or Imm (chosen by ALUSrc) 
    end
end
endmodule

