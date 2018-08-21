`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:44:51 04/07/2016 
// Design Name: 
// Module Name:    RegisterA 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a module that is the register for A before the alu
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegisterA(
	input [31:0] inA,
	input reset, clk,
	output [31:0] outA
    );
	 
	reg [31:0] registerA;
	
	assign outA = registerA;
	
	always@(posedge clk)
		begin
			if (reset)
				begin
					registerA <= 32'b0;
				end
			else
				begin
					registerA <= inA;
				end
		end

endmodule
