`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:25:45 04/17/2016
// Design Name:   CPU
// Module Name:   /ad/eng/users/h/h/hhebert1/Desktop/Final_Project/CPU_tb.v
// Project Name:  Final_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_tb;

	// Inputs
	reg reset;
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.reset(reset), 
		.clk(clk)
	);
	
	always
	#3 clk= ~clk;

	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset=0;
		// Add stimulus here
	end
      
endmodule

