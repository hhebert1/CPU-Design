`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:51 04/07/2016 
// Design Name: 
// Module Name:    BtoALU_mux 
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
module BtoALU_mux(
	input [1:0] ALUSrcB,
	input [31:0] outRegB, PCIncrement, signExtendImm, zeroExtendImm,
	output [31:0] ALUinputB
    );
	 
	 reg [31:0] ALUinputBReg;
	 assign ALUinputB = ALUinputBReg;
	 always @(ALUSrcB, outRegB, PCIncrement, signExtendImm, zeroExtendImm)
	 case (ALUSrcB)
		2'b00: ALUinputBReg <= outRegB;
		2'b01: ALUinputBReg <= PCIncrement;
		2'b10: ALUinputBReg <= signExtendImm;
		2'b11: ALUinputBReg <= zeroExtendImm;
		default: ALUinputBReg <= 32'b0;
	 endcase


endmodule
