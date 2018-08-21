`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:54:00 04/07/2016 
// Design Name: 
// Module Name:    ALUOutRegister 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a module that acts as the register for the output of the ALU in our CPU
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegisterALUOut(
	input [31:0] inALUOut,
	input reset, clk,
	output [31:0] outALUOut
    );
	 
	reg [31:0] registerALUOut;
	
	assign outALUOut = registerALUOut;
	
	always@(posedge clk)
		begin
			if (reset)
				begin
					registerALUOut <= 32'b0;
				end
			else
				begin
					registerALUOut <= inALUOut;
				end
		end

endmodule
