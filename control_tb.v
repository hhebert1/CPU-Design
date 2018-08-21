`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:11:31 04/17/2016
// Design Name:   control
// Module Name:   /ad/eng/users/h/h/hhebert1/Desktop/Final_Project/control_tb.v
// Project Name:  Final_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module control_tb;

	// Inputs
	reg [5:0] Op;
	reg reset;
	reg clk;

	// Outputs
	wire PCWriteCond;
	wire PCWrite;
	wire MemRead;
	wire MemWrite;
	wire MemtoReg;
	wire IRWrite;
	wire [1:0] PCSource;
	wire [3:0] ALUOp;
	wire ALUSrcA;
	wire [1:0] ALUSrcB;
	wire RegWrite;
	wire RegDst;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.Op(Op), 
		.PCWriteCond(PCWriteCond), 
		.PCWrite(PCWrite), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.MemtoReg(MemtoReg), 
		.IRWrite(IRWrite), 
		.PCSource(PCSource), 
		.ALUOp(ALUOp), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 
		.RegWrite(RegWrite), 
		.RegDst(RegDst), 
		.reset(reset), 
		.clk(clk)
	);
	always 
	#5 clk=~clk;
	initial begin
		// Initialize Inputs
		Op = 0;
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// R-TYPE
		Op <= 6'b010000; //MOV		0 1 2 6
		#55;
		Op <= 6'b010001; //NOT		0 1 2 6
		#40;
		Op <= 6'b010010; //ADD		0 1 2 6
		#40;
		Op <= 6'b010011; //SUB		0 1 2 6
		#40;
		Op <= 6'b010100; //OR		0 1 2 6
		#40;
		Op <= 6'b010101; //AND		0 1 2 6
		#40;
		Op <= 6'b010110; //XOR		0 1 2 6
		#40;
		Op <= 6'b010111; //SLT		0 1 2 6
		
		
		// JUMP
		Op <= 6'b000001; // J		0 1 14 12
		#30;
		// BRANCH
		Op <= 6'b100000; //BEQ		0 1 14 11
		#30;
		// I-type
		Op <= 6'b110010; // ADDI	0 1 3 6
		#40; 
		Op <= 6'b110011; // SUBI	0 1 3 6
		#40;
		Op <= 6'b110100; // ORI		0 1 4 6
		#40;
		Op <= 6'b110101; // ANDI	0 1 4 6
		#40;
		Op <= 6'b110110; // XORI	0 1 4 6
		#40;
		Op <= 6'b110111; // SLTI	0 1 3 6
		#40;
		Op <= 6'b111001; // LI		0 1 14 9
		#40;
		Op <= 6'b111010; // LUI		0 1 14 10
		#40;
		Op <= 6'b111011; // LWI		0 1 5 7
		#40;
		Op <= 6'b111100; // SWI		0 1 14 8
		#40;
		reset <= 1;
		#20;
		reset <= 0;
		Op <= 6'b000000; // NOP		0 1
        
		// Add stimulus here

	end
      
endmodule

