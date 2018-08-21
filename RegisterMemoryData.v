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
// Description: This is a module that is the register the output of the memory data unit
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegisterMemoryData(
	input [31:0] inMemoryData,
	input reset, clk,
	output [31:0] outMemoryData
    );
	 
	reg [31:0] registerMemoryData;
	
	assign outMemoryData = registerMemoryData;
	
	always@(posedge clk)
		begin
			if (reset)
				begin
					registerMemoryData <= 32'b0;
				end
			else
				begin
					registerMemoryData <= inMemoryData;
				end
		end

endmodule
