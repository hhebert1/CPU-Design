`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:50:51 04/07/2016 
// Design Name: 
// Module Name:    CPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU(
	input reset, clk
    );

wire IRwrite,MemWrite,RegWrite,PCwrite,PCwritecond,RegDst,ALUsrcA,MemRead;//added branch signal
wire [3:0] ALUop;
wire [1:0] PCsource;
wire [1:0] ALUsrcB;
wire [1:0] MemtoReg;
wire [5:0] opcode;

control total_controller(.Op(opcode), .PCWriteCond(PCwritecond), .PCWrite(PCwrite), .MemRead(MemRead), .MemWrite(MemWrite), .MemtoReg(MemtoReg),
								 .IRWrite(IRwrite), .PCSource(PCsource), .ALUOp(ALUop), .ALUSrcA(ALUsrcA), .ALUSrcB(ALUsrcB),.RegWrite(RegWrite),
								 .RegDst(RegDst), .reset(reset), .clk(clk));
								 
Datapath total_datapath(.outData(opcode), .clk(clk), .reset(reset), .PCWriteCond(PCwritecond), .PCWrite(PCwrite), .MemRead(MemRead),
								.MemWrite(MemWrite), .MemtoReg(MemtoReg), .IRWrite(IRwrite),.ALUSrcA(ALUsrcA), .RegWrite(RegWrite),
								.RegDst(RegDst), .ALUOp(ALUop), .ALUSrcB(ALUsrcB), .PCSource(PCsource));

endmodule

