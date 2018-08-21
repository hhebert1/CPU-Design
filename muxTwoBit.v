`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:53:47 04/07/2016 
// Design Name: 
// Module Name:    muxTwoBit 
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
module muxTwoBit(
	input [31:0] input0, input1,
	input controlSelect,
	output [31:0] muxOut
    );

assign muxOut = (controlSelect) ? input1 : input0;

endmodule
