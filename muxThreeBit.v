`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:37 04/20/2016 
// Design Name: 
// Module Name:    muxThreeBit 
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
module muxThreeBit(
	input [31:0] input0, input1, input2,
	input [1:0] controlSelect,
	output [31:0] muxOut
    );
	 
	reg [31:0] MuxOutReg;
	assign muxOut = MuxOutReg;
	always @(controlSelect, input0, input1, input2)
	case (controlSelect)
		2'b00: MuxOutReg <= input0;
		2'b01: MuxOutReg <= input1;
		2'b10: MuxOutReg <= input2;
		default: MuxOutReg <= 32'b0;
	endcase

endmodule
