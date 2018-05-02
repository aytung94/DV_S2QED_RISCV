//======================================================
// Aquarius Project
//    SuperH-2 ISA Compatible RISC CPU
//------------------------------------------------------
// Module      : Test Bench
//------------------------------------------------------
// File        : test.v
// Library     : none
// Description : Test Bench for Aquarius.
// Simulator   : Icarus Verilog (Cygwin)
// Synthesizer : Xilinx XST (Windows XP)
// Author      : Thorn Aitch
//------------------------------------------------------
// Revision Number : 1
// Date of Change  : 15th April 2002
// Creator         : Thorn Aitch
// Description     : Initial Design
//------------------------------------------------------
// Revision Number : 2
// Date of Change  : 6th July 2002
// Modifier        : Thorn Aitch
// Description     : Make CPU layer				   
//------------------------------------------------------
// Revision Number : 3
// Date of Change  : 15th August 2002
// Modifier        : Thorn Aitch
// Description     : Separated from Top Layer
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

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

`include "defines.v"
				
//******************************
// Test Bench
//******************************
module test(
    );

    reg CLK;
    reg RST_n;

//------------------
// Internal Signals
//------------------

    reg [31:0] COUNT;  //virtual signal for display
    reg [ 7:0] INDEX;  //virtual index for display
    reg [ 7:0] LCDDBI; //input port
    reg RXD, CTS;      //uart input signals
    reg [ 4:0] KEYXI;  //key input

//********
// Modules
//********
    top TOP(
        .CLK_SRC(CLK), .RST_n(RST_n),
	   .LCDDBI(LCDDBI), .KEYXI(KEYXI),
	   .RXD(RXD), .CTS(CTS)
    );

//----------------
// virtual counter
//----------------
    always @(posedge CLK) begin
        if (~RST_n)
            COUNT <= 32'h00000000;
        else
            COUNT <= COUNT + 1'b1;
    end

//-----------------
//  CLOCK generator
//-----------------
    initial begin
        CLK <= 1'b1;
    end
    always #(`HALF_CYCLE) begin
        CLK <= ~CLK;
    end

//-----------------
// simulation tasks
//-----------------
    task RESET;
        begin
            RST_n <= 1'b0;
        #(`CYCLE);		 
            RST_n <= 1'b1;
        end
    endtask

//--------------
// Input Pattern
//--------------                                                         PL
    initial begin
        RESET;
        LCDDBI <= 8'h00;
        RXD <= 1'b1;
	    CTS <= 1'b0;
    #(`CYCLE*100);
        RXD <= 1'b0; //start bit
    #(`CYCLE*24);
        RXD <= 1'b1; //D0
    #(`CYCLE*24);
        RXD <= 1'b0; //D1
    #(`CYCLE*24);
        RXD <= 1'b1; //D2
    #(`CYCLE*24);
        RXD <= 1'b0; //D3
    #(`CYCLE*24);
        RXD <= 1'b1; //D4
    #(`CYCLE*24);
        RXD <= 1'b0; //D5
    #(`CYCLE*24);
        RXD <= 1'b1; //D6
    #(`CYCLE*24);
        RXD <= 1'b0; //D7
    #(`CYCLE*24);
        RXD <= 1'b1; //stop bit
    end

//-----------
// SLEEP test
//-----------
    initial begin
        KEYXI[4] <= 1'b1;
    #(`CYCLE*100);
        KEYXI[4] <= 1'b0;
    #(`CYCLE);
        KEYXI[4] <= 1'b1;
    end

//************************
// Write Simulation Result
//************************
    integer result;  //write file
    initial
        result = $fopen("test_result.txt");
    initial begin
        $fdisplay(result, "                                                                                                WB_MAC_BUSY/EX_MAC_BUSY/MAC_BUSY/MAC_STALL");
        $fdisplay(result, "             STB                                                              DISPATCH       REG_FWD_X&Y");
        $fdisplay(result, "            CYC IFWD                                                        INSTR_SEQ       NEXT_ID_STALL");
        $fdisplay(result, "          RESn WE                                                      INSTR_STATE         ID_STALL");
        $fdisplay(result, "         CLK  ACK                                                    SLOT                 IF_STALL");
        $fdisplay(result, "---------------------------------------------------------------------");
    end

    always begin
        #(`STROBE);
	   
        if (COUNT[2:0] == 3'b000)
        $fdisplay(result, "COUNT#   CR CSAWI SEL- ADR----  DATI---- DATO---- PC------ EVR EVI A|S-INST-Q-D-IFDR-IR-- PIPE- ---- CNST-MQT SR------ GBR----- VBR----- PR------ MACH---- MACL---- XBUS---- YBUS---- ZBUS---- WBUS---- MAAD---- MADW---- MADR---- R0------ R1------ R2------ R3------ R4------ R5------ R6------ R7------ R8------ R9------ R10----- R11----- R12----- R13----- R14----- R15----- ");
         $fdisplay(result, 
            "%8h %b%b %b%b%b%b%b %4b %8h %8h %8h %8h %3b %3h %b|%b %4h %h %b %4h %4h %b%b%b%b%b %b%b%b%b %4h %b%b%b %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h %8h",
            //  |    |          |                              |S  INSTQ  D  IFDRIR  PIPE                CNSTM Q T  SR  GBR VBR PR  MACHMACLX   Y   Z   W   AD  DW  DR  R0  R1  R2  R3  R4  R5  R6  R7  R8  R9  R10 R11 R12 R13 R14 R15  
            COUNT, CLK ,RST_n,
            TOP.CYC,           // external bus cycle to be kept
            TOP.STB,           // external bus strobe
            TOP.ACK,           // external device acknowledge
            TOP.WE,            // external write/read
            TOP.IF_WIDTH,      // IF_WIDTH : external fetch space width
            TOP.SEL,           // external data valid position
            TOP.ADR,           // external address
            TOP.DATI,          // external data read bus
            TOP.DATO,          // external data write bus
            TOP.CPU.DATAPATH.PC,
            TOP.EVENT_REQ,
            TOP.EVENT_INFO,
            TOP.EVENT_ACK,

            TOP.CPU.DECODE.SLOT,
            TOP.CPU.DECODE.INSTR_STATE,
            TOP.CPU.DECODE.INSTR_SEQ,   
            TOP.CPU.DECODE.DISPATCH,
            TOP.CPU.DECODE.IF_DR,
            TOP.CPU.DECODE.IR,
            TOP.CPU.DECODE.IF_STALL,
            TOP.CPU.DECODE.ID_STALL,
            TOP.CPU.DECODE.NEXT_ID_STALL,
            TOP.CPU.DECODE.REG_FWD_X,
            TOP.CPU.DECODE.REG_FWD_Y,
            TOP.CPU.DECODE.WB_MAC_BUSY,          
            TOP.CPU.DECODE.EX_MAC_BUSY,
            TOP.CPU.DECODE.MAC_BUSY,
            TOP.CPU.DECODE.MAC_STALL,
            TOP.CPU.DECODE.CONST_IFDR,
            TOP.CPU.DATAPATH.SR[9], //M
            TOP.CPU.DATAPATH.SR[8], //Q
            TOP.CPU.DATAPATH.SR[0], //T
            {22'h000000, TOP.CPU.DATAPATH.SR},       
            TOP.CPU.DATAPATH.GBR,
            TOP.CPU.DATAPATH.VBR,  
            TOP.CPU.DATAPATH.PR,
            TOP.CPU.DATAPATH.MACH,
            TOP.CPU.DATAPATH.MACL,
            TOP.CPU.DATAPATH.XBUS,
            TOP.CPU.DATAPATH.YBUS,
            TOP.CPU.DATAPATH.ZBUS,
            TOP.CPU.DATAPATH.WBUS,
            TOP.CPU.DATAPATH.MA_AD,
            TOP.CPU.DATAPATH.MA_DW,
            TOP.CPU.DATAPATH.MA_DR,
            TOP.CPU.DATAPATH.REGISTER.REG[0], 
            TOP.CPU.DATAPATH.REGISTER.REG[1], 
            TOP.CPU.DATAPATH.REGISTER.REG[2], 
            TOP.CPU.DATAPATH.REGISTER.REG[3], 
            TOP.CPU.DATAPATH.REGISTER.REG[4], 
            TOP.CPU.DATAPATH.REGISTER.REG[5], 
            TOP.CPU.DATAPATH.REGISTER.REG[6], 
            TOP.CPU.DATAPATH.REGISTER.REG[7], 
            TOP.CPU.DATAPATH.REGISTER.REG[8], 
            TOP.CPU.DATAPATH.REGISTER.REG[9], 
            TOP.CPU.DATAPATH.REGISTER.REG[10], 
            TOP.CPU.DATAPATH.REGISTER.REG[11], 
            TOP.CPU.DATAPATH.REGISTER.REG[12], 
            TOP.CPU.DATAPATH.REGISTER.REG[13], 
            TOP.CPU.DATAPATH.REGISTER.REG[14], 
            TOP.CPU.DATAPATH.REGISTER.REG[15]
        );
        #(`CYCLE-`STROBE);
    end

//--------------------------
// Simulation Stop Condition
//--------------------------
    always @(COUNT) begin
        if (COUNT == 32'h00002800)
            begin
                $fclose(result);
                $stop;
            end
    end

//======================================================
  endmodule
//======================================================
