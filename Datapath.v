`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:14 04/07/2016 
// Design Name: 
// Module Name:    Datapath 
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
module Datapath(
	output [5:0] outData,
	input clk, reset, PCWriteCond, PCWrite, MemRead, MemWrite, IRWrite,
			ALUSrcA, RegWrite, RegDst,
	input [1:0] MemtoReg,
	input [3:0] ALUOp,
	input [1:0] ALUSrcB,
	input [1:0] PCSource
    );
//-----------------------WIRES---------------------------
wire [31:0] pcToInstr, pcMuxOut, instrMemOut, instrOut, zeroExtendImm, memData, outMDataReg, signExtendImm,
				ALUOutRegWire, writeDataWire, regAIn, regBIn, regAOut, regBOut, muxToALUA, muxToALUB,
				ALUResult, jumpAddress, valueOneWire;
wire [25:0] instrJump;
wire [15:0] immediate;
wire [4:0] readRegister2, reg1, reg2, reg3;
wire zeroInvert, zeroLine, pcSelectWire;

assign zeroInvert = ~zeroLine;
assign zeroExtendImm = {{16'b0}, immediate};
assign signExtendImm = $signed(immediate);
assign jumpAddress = {{pcToInstr[15:11]}, instrJump};
assign valueOneWire = 32'b00000000000000000000000000000001;
//write to program counter

assign pcSelectWire = (zeroInvert & PCWriteCond) | PCWrite;

assign instrJump = instrMemOut[25:0];
assign immediate = instrMemOut[15:0];
assign reg1 = instrMemOut[25:21];
assign reg2 = instrMemOut[20:16];
assign reg3 = instrMemOut[15:11];
assign outData = instrMemOut[31:26];

PCRegister pcReg(.pcSelect(pcSelectWire), .reset(reset), .clk(clk), .inFromPCMux(pcMuxOut), .addressOut(pcToInstr));

//instruction memory
IMem instructionMem(.PC(pcToInstr[15:0]), .Instruction(instrOut)); //don't use memRead because it's always reading

//data memory
DMem dataMem(.WriteData(regBOut), .MemData(memData), .Address(immediate), .MemWrite(MemWrite), .Clk(clk));
 
//instruction register
InstructionRegister instrReg(.instrData(instrOut),.IRWrite(IRWrite), .clk(clk), .reset(reset), .outInstr(instrMemOut));

//memory data register
RegisterMemoryData regMemData(.inMemoryData(memData), .reset(reset), .clk(clk), .outMemoryData(outMDataReg));

//multiplexers between instruction register and register file
muxTwoBit_5bits readReg2RegFile(.input0(reg1), .input1(reg3), .controlSelect(RegDst), .muxOut(readRegister2));
muxThreeBit writeDataRegFile(.input0(ALUOutRegWire), .input1(outMDataReg), .input2(zeroExtendImm), .controlSelect(MemtoReg), .muxOut(writeDataWire));

//register file
nbit_register_file registerFile(.write_data(writeDataWire), .read_data_1(regAIn), .read_data_2(regBIn),.read_sel_1(reg2), 
						.read_sel_2(readRegister2), .write_address(reg1), .RegWrite(RegWrite), .clk(clk));

//register file output to registers a and b
RegisterA regAinstance(.inA(regAIn), .reset(reset), .clk(clk), .outA(regAOut));
RegisterB regBinstance(.inB(regBIn), .reset(reset), .clk(clk), .outB(regBOut));

//multiplexers before the ALU
muxTwoBit ALUInA(.input0(pcToInstr), .input1(regAOut), .controlSelect(ALUSrcA), .muxOut(muxToALUA));
BtoALU_mux ALUInB(.ALUSrcB(ALUSrcB), .outRegB(regBOut), .PCIncrement(valueOneWire), .signExtendImm(signExtendImm), 
						.zeroExtendImm(zeroExtendImm), .ALUinputB(muxToALUB));

//ALU 
ALU datapathAlu(.ALUControl(ALUOp), .outMuxRegA(muxToALUA), .outMuxRegB(muxToALUB), .ALUOut(ALUResult), .zero(zeroLine));
RegisterALUOut aluReg(.inALUOut(ALUResult), .reset(reset), .clk(clk), .outALUOut(ALUOutRegWire));

//PC MUX!!
PCMux pcMux(.PCSource(PCSource), .ALUResult(ALUResult), .ALUOutReg(ALUOutRegWire), .JumpAddr(jumpAddress), .PCMuxOut(pcMuxOut));

endmodule