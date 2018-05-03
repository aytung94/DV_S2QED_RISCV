//======================================================
// Aquarius Project
//    SuperH-2 ISA Compatible RISC CPU
//------------------------------------------------------
// Module      : Memory (ROM/RAM) in MCU 
//------------------------------------------------------
// File        : memory.v
// Library     : none
// Description : 16KB Memory Module in MCU
//               lower 8KB has fixed code (rom.v)
// Simulator   : Icarus Verilog (Cygwin)
// Synthesizer : Xilinx XST (Windows XP)
// Author      : Thorn Aitch
//------------------------------------------------------
// Revision Number : 1
// Date of Change  : 15th August 2002
// Creator         : Thorn Aitch
// Description     : Initial Design				  
//------------------------------------------------------
// Revision Number : 2
// Date of Change  : 30th April 2003
// Modifier        : Thorn Aitch
// Description     : Release Version 1.0
//======================================================
// Copyright (C) 2002-2003, Thorn Aitch
//
// Designs can be altered while keeping list of
// modifications "the same as in GNU" No money can
// be earned by selling the designs themselves, but
// anyone can get money by selling the implementation
// of the design, such as ICs based on some cores, 
// boards based on some schematics or Layouts, and
// even GUI interfaces to text mode drivers.
// "The same as GPL SW" Any update to the design
// should be documented and returned to the design. 
// Any derivative work based on the IP should be free
// under OpenIP License. Derivative work means any
// update, change or improvement on the design. 
// Any work based on the design can be either made
// free under OpenIP license or protected by any other
// license. Work based on the design means any work uses
// the OpenIP Licensed core as a building black without
// changing anything on it with any other blocks to
// produce larger design.  There is NO WARRANTY on the
// functionality or performance of the design on the
// real hardware implementation.
// On the other hand, the SuperH-2 ISA (Instruction Set
// Architecture) executed by Aquarius is rigidly
// the property of Renesas Corp. Then you have all 
// responsibility to judge if there are not any 
// infringements to Renesas's rights regarding your 
// Aquarius adoption into your design. 
// By adopting Aquarius, the user assumes all 
// responsibility for its use.
// This project may cause any damages around you, for 
// example, loss of properties, data, money, profits,
// life, or business etc. By adopting this source, 
// the user assumes all responsibility for its use.
//======================================================

`include "timescale.v"
`include "defines.v"

//*************************************************
// Module Definition
//*************************************************
module memory (
               CLK, 
               CE, WE, SEL, 
               ADR, DATI, DATO
           );

//-------------------
// Module I/O Signals
//-------------------
    input CLK;           // clock
    input CE;            // chip enable
    input WE;            // write enable (read = 0, write = 1)
    input [3:0]SEL;      // data valid position
    input [13:0] ADR;    // address
    input [31:0] DATI;   // write data
    output [31:0] DATO;  // read data

//-----------------
// Internal Signals
//-----------------
    reg    [7:0] RAM0HH [0:511];
    reg    [7:0] RAM0HL [0:511];
    reg    [7:0] RAM0LH [0:511];
    reg    [7:0] RAM0LL [0:511];
    reg    [7:0] RAM1HH [0:511];
    reg    [7:0] RAM1HL [0:511];
    reg    [7:0] RAM1LH [0:511];
    reg    [7:0] RAM1LL [0:511];
    reg    [7:0] RAM2HH [0:511];
    reg    [7:0] RAM2HL [0:511];
    reg    [7:0] RAM2LH [0:511];
    reg    [7:0] RAM2LL [0:511];
    reg    [7:0] RAM3HH [0:511];
    reg    [7:0] RAM3HL [0:511];
    reg    [7:0] RAM3LH [0:511];
    reg    [7:0] RAM3LL [0:511];

    wire   [31:0] DATO;
    wire   [31:0] DATOUT0;
    wire   [31:0] DATOUT1;
    wire   [31:0] DATOUT2;
    wire   [31:0] DATOUT3;
    wire   [31:0] DATROM;

    reg    [8:0] ADR_RD;
    reg    [3:0] CERAM;
    reg    CEROM;

//--------------
// ROM Operation
//--------------
    always @(ADR or CE)
    begin
        case ({CE, ADR[13]})
            4'b1_0:  CEROM <= 1'b1;
            default: CEROM <= 1'b0;
        endcase
    end

    rom ROM(
        .CLK(CLK), .CE(CEROM), .WE(WE), .SEL(SEL),
        .ADR(ADR[12:0]), .DATI(DATO), .DATO(DATROM)
    );

//--------------
// RAM Operation
//--------------
    always @(ADR or CE)
    begin
        case ({CE, ADR[13:11]})
            4'b1_100: CERAM <= 4'b0001;
            4'b1_101: CERAM <= 4'b0010;
            4'b1_110: CERAM <= 4'b0100;
            4'b1_111: CERAM <= 4'b1000;
            default: CERAM <= 4'b0000;
        endcase
    end

    always @(negedge CLK) begin
        if (CERAM[0] & WE & SEL[3]) RAM0HH[ADR[10:2]] <= DATI[31:24];
        if (CERAM[0] & WE & SEL[2]) RAM0HL[ADR[10:2]] <= DATI[23:16];
        if (CERAM[0] & WE & SEL[1]) RAM0LH[ADR[10:2]] <= DATI[15: 8];
        if (CERAM[0] & WE & SEL[0]) RAM0LL[ADR[10:2]] <= DATI[ 7: 0];
        if (CERAM[1] & WE & SEL[3]) RAM1HH[ADR[10:2]] <= DATI[31:24];
        if (CERAM[1] & WE & SEL[2]) RAM1HL[ADR[10:2]] <= DATI[23:16];
        if (CERAM[1] & WE & SEL[1]) RAM1LH[ADR[10:2]] <= DATI[15: 8];
        if (CERAM[1] & WE & SEL[0]) RAM1LL[ADR[10:2]] <= DATI[ 7: 0];
        if (CERAM[2] & WE & SEL[3]) RAM2HH[ADR[10:2]] <= DATI[31:24];
        if (CERAM[2] & WE & SEL[2]) RAM2HL[ADR[10:2]] <= DATI[23:16];
        if (CERAM[2] & WE & SEL[1]) RAM2LH[ADR[10:2]] <= DATI[15: 8];
        if (CERAM[2] & WE & SEL[0]) RAM2LL[ADR[10:2]] <= DATI[ 7: 0];
        if (CERAM[3] & WE & SEL[3]) RAM3HH[ADR[10:2]] <= DATI[31:24];
        if (CERAM[3] & WE & SEL[2]) RAM3HL[ADR[10:2]] <= DATI[23:16];
        if (CERAM[3] & WE & SEL[1]) RAM3LH[ADR[10:2]] <= DATI[15: 8];
        if (CERAM[3] & WE & SEL[0]) RAM3LL[ADR[10:2]] <= DATI[ 7: 0];
        ADR_RD <= ADR[10:2];
    end

    assign DATOUT0[31:24] = (CERAM[0]) ? RAM0HH[ADR_RD] : 8'h00;
    assign DATOUT0[23:16] = (CERAM[0]) ? RAM0HL[ADR_RD] : 8'h00;
    assign DATOUT0[15: 8] = (CERAM[0]) ? RAM0LH[ADR_RD] : 8'h00;
    assign DATOUT0[ 7: 0] = (CERAM[0]) ? RAM0LL[ADR_RD] : 8'h00;
    assign DATOUT1[31:24] = (CERAM[1]) ? RAM1HH[ADR_RD] : 8'h00;
    assign DATOUT1[23:16] = (CERAM[1]) ? RAM1HL[ADR_RD] : 8'h00;
    assign DATOUT1[15: 8] = (CERAM[1]) ? RAM1LH[ADR_RD] : 8'h00;
    assign DATOUT1[ 7: 0] = (CERAM[1]) ? RAM1LL[ADR_RD] : 8'h00;
    assign DATOUT2[31:24] = (CERAM[2]) ? RAM2HH[ADR_RD] : 8'h00;
    assign DATOUT2[23:16] = (CERAM[2]) ? RAM2HL[ADR_RD] : 8'h00;
    assign DATOUT2[15: 8] = (CERAM[2]) ? RAM2LH[ADR_RD] : 8'h00;
    assign DATOUT2[ 7: 0] = (CERAM[2]) ? RAM2LL[ADR_RD] : 8'h00;
    assign DATOUT3[31:24] = (CERAM[3]) ? RAM3HH[ADR_RD] : 8'h00;
    assign DATOUT3[23:16] = (CERAM[3]) ? RAM3HL[ADR_RD] : 8'h00;
    assign DATOUT3[15: 8] = (CERAM[3]) ? RAM3LH[ADR_RD] : 8'h00;
    assign DATOUT3[ 7: 0] = (CERAM[3]) ? RAM3LL[ADR_RD] : 8'h00;

    assign DATO = DATOUT0 | DATOUT1 | DATOUT2 | DATOUT3 | DATROM;

//======================================================
  endmodule
//======================================================