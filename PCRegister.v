`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:13 04/07/2016 
// Design Name: 
// Module Name:    PCRegister 
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
module PCRegister(
	input pcSelect, reset, clk,
	input [31:0] inFromPCMux,
	output [31:0] addressOut
    );
	 
	reg [31:0] addressOutReg;
	 
	assign addressOut = addressOutReg;
	
	always@(posedge clk)
		begin
			if (reset)
				begin
					addressOutReg <= 32'b0;
				end
			else if (pcSelect)
				begin
					addressOutReg <= inFromPCMux;
				end
		end


endmodule
