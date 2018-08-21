`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:13:59 04/07/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input [3:0] ALUControl, //4-bit select from control
	input [31:0] outMuxRegA, outMuxRegB, 
	output reg [31:0] ALUOut, //R1
	output reg zero
    );

	always @(ALUControl, outMuxRegA, outMuxRegB, zero)
		begin
			if(outMuxRegA == outMuxRegB) begin
				zero <= 1;end
			else begin
				zero <= 0;end
			
			case (ALUControl)
			4'b0000: ALUOut <= outMuxRegA; //mov
			4'b0001: ALUOut <= ~outMuxRegA; //not
			4'b0010: ALUOut <= outMuxRegA + outMuxRegB; //add
			4'b0011: ALUOut <= outMuxRegA - outMuxRegB; //sub
			4'b0100: ALUOut <= outMuxRegA | outMuxRegB; //or
			4'b0101: ALUOut <= outMuxRegA & outMuxRegB; //and
			4'b0110: ALUOut <= outMuxRegA ^ outMuxRegB; //xor
			4'b0111: begin //slt, R2<R3--R1=1, else R1=0
							ALUOut <= ($signed(outMuxRegA) < $signed(outMuxRegB)) ? 1 : 0;
						end
			default: ALUOut <= 0;
			endcase
		end

endmodule
