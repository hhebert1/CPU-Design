`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:44:51 04/07/2016 
// Design Name: 
// Module Name:    RegisterB
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a module that is the register for B before the alu
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegisterB(
	input [31:0] inB,
	input reset, clk,
	output [31:0] outB
    );
	 
	reg [31:0] registerB;
	
	assign outB = registerB;
	
	always@(posedge clk)
		begin
			if (reset)
				begin
					registerB <= 32'b0;
				end
			else
				begin
					registerB <= inB;
				end
		end

endmodule
