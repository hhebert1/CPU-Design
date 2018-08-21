`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:00:43 04/07/2016 
// Design Name: 
// Module Name:    InstructionRegister 
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
module InstructionRegister(
	input [31:0] instrData,
	input IRWrite, clk, reset,
	output [31:0] outInstr
   );
	 
	reg [31:0] outInstrReg;
	
	assign outInstr = outInstrReg;
	
	always@(posedge clk)
		begin
			if (reset)
				begin
					outInstrReg <= 32'b0;
				end
			else if(IRWrite)
				begin
					outInstrReg <= instrData;
				end
			else
				begin
					outInstrReg <= outInstr;
				end
		end

endmodule
