`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:17:11 03/28/2016 
// Design Name: 
// Module Name:    control 
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
module control(Op, PCWriteCond, PCWrite, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcA, ALUSrcB, RegWrite, RegDst,reset,clk);

	input [5:0] Op;
	output reg PCWriteCond;
	output reg PCWrite;
	output reg MemRead;
	output reg MemWrite;
	output reg [1:0] MemtoReg;
	output reg IRWrite;
	output reg [1:0]PCSource;
	output reg [3:0] ALUOp; //4 LSB of opcode fed to ALU selection
	output reg [1:0] ALUSrcB; //input to mux
	output reg ALUSrcA;
	output reg RegWrite;
	output reg RegDst;
	
	input reset;
	input clk;

    reg [3:0] state;
	 reg [3:0] next_state;

    parameter S0=4'b0000;//instruction fetch
    parameter S1=4'b0001;//instruction decode
    parameter S2=4'b0010; 
    parameter S3=4'b0011;
    parameter S4=4'b0100;
    parameter S5=4'b0101;
    parameter S6=4'b0110;
    parameter S7=4'b0111;
    parameter S8=4'b1000;
    parameter S9=4'b1001;
    parameter S10=4'b1010;
	 parameter S11=4'b1011;

	initial
	begin
		state=S0;
		next_state=S0;
		PCWrite=0;
	   PCWriteCond=0;
		MemRead=0;
	   MemWrite=0;
	   IRWrite=0;
	   MemtoReg=2'b00;
	   PCSource=2'b00;
	   ALUOp=4'b0000;
	   ALUSrcA=0;
	   ALUSrcB=2'b01;
	   RegWrite=0;
	   RegDst=0;
	end
		

    always @(posedge clk)
	 state=next_state;
	 
    always @(state or reset or Op)
	 begin

    	if(reset)
			next_state=S0;

    	else begin
    		case(state)

    		//S0->S1
    		S0: begin
    		
	    		PCWriteCond=0;
				PCWrite=1;
				MemRead=1;
				MemWrite=0;
				MemtoReg=2'b00;
				IRWrite=1;
				PCSource= 2'b00;
				ALUOp=4'b0010;
				ALUSrcB=2'b01;
				ALUSrcA=0;
				RegWrite=0;
				RegDst=0;

	    		next_state=S1;
	    	end

	    	//S1->?
	    	S1: begin
			
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=2'b10;
					ALUSrcA=0;
					RegWrite=0;
					RegDst=1;

	    		//case statement for opcode
	    		case(Op)
					6'b000000: next_state=S0;//noop
					6'b010000: next_state=S2;//r-type
					6'b010001: next_state=S2;
					6'b010001: next_state=S2;
					6'b010011: next_state=S2;
					6'b010100: next_state=S2;
					6'b010101: next_state=S2;
					6'b010110: next_state=S2;
					6'b010111: next_state=S2;
					6'b000001: next_state=S6;//jump
					6'b100001: next_state=S5;//bne
					6'b110010: next_state=S3;//i-type
					6'b110011: next_state=S3;
					6'b110100: next_state=S3;
					6'b110101: next_state=S3;
					6'b110110: next_state=S3;
					6'b110111: next_state=S3;
					6'b111001: next_state=S4;//li
					6'b111011: next_state=S4;//lwi
					6'b111100: next_state=S4;//swi
				endcase
				
				end//S1
			//R-type
			S2: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=Op[3:0];
					ALUSrcB=2'b00;
					ALUSrcA=1;
					RegWrite=0;
					RegDst=0;

			    	next_state=S7;
			    end
				 
			//I-Type
			S3: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=Op[3:0];
					
					if((Op[3:0]==4'b0010) ||(Op[3:0]==4'b0011) || (Op[3:0]==4'b0111)) begin
					ALUSrcB=2'b10;//sign extended immediate
					end
					else begin
					ALUSrcB=2'b11;//zero extended immediate
					end
					
					ALUSrcA=1;
					RegWrite=0;
					RegDst=1;

					next_state=S7;
				 end
				 
			//SWI/LWI
			S4: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=2'b10;
					ALUSrcA=0;
					RegWrite=0;
					RegDst=0;

			    if(Op==6'b111011) begin //LWI
					next_state=S8;
				 end
				 else if (Op==6'b111001) begin //Li
					next_state=S10;
				 end
				 else begin//SWI
					next_state=S9;
				 end
				end
			//bne
			S5: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b01;
					ALUOp=4'b0010;
					ALUSrcB=2'b10;
					ALUSrcA=0;
					RegWrite=0;
					RegDst=0;

			    	next_state=S11;
			    end
			/*S5: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b01;
					ALUOp=4'b0011;
					ALUSrcB=2'b00;
					ALUSrcA=1;
					RegWrite=0;
					RegDst=0;

			    	next_state=S11;
			 end*/
			//bne completion
			S11: begin
					PCWriteCond=1;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b01;
					ALUOp=4'b0011;
					ALUSrcB=2'b00;
					ALUSrcA=1;
					RegWrite=0;
					RegDst=0;

			    	next_state=S0;
			    end
			//jump
			S6: begin
					PCWriteCond=0;
					PCWrite=1;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b10;
					ALUOp=4'b0010;
					ALUSrcB=2'b10;
					ALUSrcA=0;
					RegWrite=0;
					RegDst=0;

			    	next_state=S0;
			    end
				 
			//alu completion	 
			S7: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=Op[3:0];
					ALUSrcB=2'b00;
					ALUSrcA=1;
					RegWrite=1;
					RegDst=1;

			    	next_state=S0;
			    end
			//LWI completion
			S8: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b01;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=2'b10;
					ALUSrcA=0;
					RegWrite=1;
					RegDst=0;
					//add mux for LI??
			    	next_state=S0;
			    end
			//SWI completion
			S9: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=1;
					MemtoReg=2'b00;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=2'b10;
					ALUSrcA=0;
					RegWrite=0;
					RegDst=0;

			    	next_state=S0;
			    end
			//LI completion
			S10: begin
					PCWriteCond=0;
					PCWrite=0;
					MemRead=1;
					MemWrite=0;
					MemtoReg=2'b10;
					IRWrite=0;
					PCSource= 2'b00;
					ALUOp=4'b0010;
					ALUSrcB=2'b10;
					ALUSrcA=0;
					RegWrite=1;
					RegDst=0;
					//add mux for LI??
			    	next_state=S0;
			    end
			endcase
		end
		end

endmodule
