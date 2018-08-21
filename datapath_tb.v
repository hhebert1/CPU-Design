`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:30:48 04/07/2016
// Design Name:   Datapath
// Module Name:   /ad/eng/users/a/z/azulad7/Desktop/juniorSpring/EC413/project/CPU/datapath_tb.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module datapath_tb;

	// Inputs
	reg clk;
	reg reset;
	reg PCWriteCond;
	reg PCWrite;
	reg MemRead;
	reg MemWrite;
	reg MemtoReg;
	reg IRWrite;
	reg [1:0] PCSource;
	reg [3:0] ALUOp;
	reg [1:0] ALUSrcB;
	reg ALUSrcA;
	reg RegWrite;
	reg RegDst;

	// Outputs
	wire [5:0] outData;

	// Instantiate the Unit Under Test (UUT)
	Datapath uut (
		.outData(outData), 
		.clk(clk), 
		.reset(reset), 
		.PCWriteCond(PCWriteCond), 
		.PCWrite(PCWrite), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.MemtoReg(MemtoReg), 
		.IRWrite(IRWrite), 
		.PCSource(PCSource), 
		.ALUOp(ALUOp), 
		.ALUSrcB(ALUSrcB), 
		.ALUSrcA(ALUSrcA), 
		.RegWrite(RegWrite), 
		.RegDst(RegDst)
	);
	
	always 
	#10 clk=~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		PCWriteCond = 0;
		PCWrite = 0;
		MemRead = 0;
		MemWrite = 0;
		MemtoReg = 0;
		IRWrite = 0;
		PCSource = 0;
		ALUOp = 0;
		ALUSrcB = 0;
		ALUSrcA = 0;
		RegWrite = 0;
		RegDst = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
        reset=0;
		// Add stimulus here
		//state 0
	    		PCWriteCond=0;
				PCWrite=1;
				MemRead=1;
				MemWrite=0;
				MemtoReg=0;
				IRWrite=1;
				PCSource= 2'b00;
				ALUOp=4'b0010;
				ALUSrcB=3'b001;
				ALUSrcA=0;
				RegWrite=0;
				RegDst=0;
				
		#20
		
		//state 1
					
					PCWriteCond=0;
					PCWrite=1;
					MemRead=1;
					MemWrite=0;
					MemtoReg=0;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=3'b010;
					ALUSrcA=0;
					RegWrite=0;
					RegDst=1;
					
		#20
		//state 2
					PCWriteCond=0;
					PCWrite=1;
					MemRead=1;
					MemWrite=0;
					MemtoReg=0;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=3'b000;
					ALUSrcA=1;
					RegWrite=0;
					RegDst=0;
		#20 
		//state 7 
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=0;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=3'b000;
					ALUSrcA=1;
					RegWrite=1;
					RegDst=1;
		#20
		//state 0
		
	    		PCWrite=1;
	    		PCWriteCond=0;
				MemRead=1;
	    		MemWrite=0;
	    		IRWrite=1;
	    		MemtoReg=0;
	    		PCSource=2'b00;
	    		ALUOp=4'b0000;
	    		ALUSrcA=0;
	    		ALUSrcB=2'b01;
	    		RegWrite=0;
	    		RegDst=0;

	end
      
endmodule

