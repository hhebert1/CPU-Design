`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:12:32 04/07/2016 
// Design Name: 
// Module Name:    pc_mux 
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
module PCMux(
	input [1:0] PCSource,
	input [31:0] ALUResult, ALUOutReg, JumpAddr,
	output [31:0] PCMuxOut
    );
	 
	reg [31:0] PCMuxOutReg;
	assign PCMuxOut = PCMuxOutReg;
	always @(PCSource, ALUResult, ALUOutReg, JumpAddr)
	case (PCSource)
		2'b00: PCMuxOutReg <= ALUResult;
		2'b01: PCMuxOutReg <= ALUOutReg;
		2'b10: PCMuxOutReg <= JumpAddr;
		default: PCMuxOutReg <= 32'b0;
	endcase


endmodule
