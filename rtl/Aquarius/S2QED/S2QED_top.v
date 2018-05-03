module black_box(
    // WISHBONE external bus signal
        CYC_O, STB_O, ACK_I,
        ADR_O, DAT_I, DAT_O,
        WE_O, SEL_O,
        TAG0_I,
    // Exception
        EVENT_REQ_I,
        EVENT_ACK_O, 
        EVENT_INFO_I,
    // SLEPP
        SLP_O
        );

    input CYC_O;         // cycle input
    input STB_O;         // strobe
    output  ACK_I;         // external memory ready
    input [31:0] ADR_O;  // external address
    output  [31:0] DAT_I;  // external data read bus
    input [31:0] DAT_O;  // external data write bus
    input WE_O;          // external write/read
    input [3:0] SEL_O;   // external valid data position
    output  TAG0_I;        // external fetch space width (IF_WIDTH)
    // Hardware Exception Event
    output  [2:0] EVENT_REQ_I;   // Hardware Exception Event Request
    input EVENT_ACK_O;         // Hardware Exception Event Acknowledge
    output  [11:0] EVENT_INFO_I; // Hardware Exception Event Information
    // SLEEP
    input SLP_O;         // SLEEP input
 
endmodule

module S2QED_top(CLK, RST);
    input CLK, RST;

    wire CYC_O;         // cycle output
    wire STB_O;         // strobe
    wire ACK_I;         // external memory ready
    wire [31:0] ADR_O;  // external address
    wire [31:0] DAT_I;  // external data read bus
    wire [31:0] DAT_O;  // external data write bus
    wire WE_O;          // external write/read
    wire [3:0] SEL_O;   // external valid data position
    wire TAG0_I;        // external fetch space width (IF_WIDTH)
    // Hardware Exception Event
    wire [2:0] EVENT_REQ_I;   // Hardware Exception Event Request
    wire EVENT_ACK_O;         // Hardware Exception Event Acknowledge
    wire [11:0] EVENT_INFO_I; // Hardware Exception Event Information
    // SlEEP
    wire SLP_O;         // SLEEP output

    black_box bb(
    // WISHBONE external bus signal
        CYC_O, STB_O, ACK_I,
        ADR_O, DAT_I, DAT_O,
        WE_O, SEL_O,
        TAG0_I,
    // Exception
        EVENT_REQ_I,
        EVENT_ACK_O, 
        EVENT_INFO_I,
    // SLEPP
        SLP_O
        );
 
    cpu cpu0(
    // system signal
        CLK, RST,
    // WISHBONE external bus signal
        CYC_O, STB_O, ACK_I,
        ADR_O, DAT_I, DAT_O,
        WE_O, SEL_O,
        TAG0_I,
    // Exception
        EVENT_REQ_I,
        EVENT_ACK_O, 
        EVENT_INFO_I,
    // SLEPP
        SLP_O
        );

    cpu cpu1(
    // system signal
        CLK, RST,
    // WISHBONE external bus signal
        CYC_O, STB_O, ACK_I,
        ADR_O, DAT_I, DAT_O,
        WE_O, SEL_O,
        TAG0_I,
    // Exception
        EVENT_REQ_I,
        EVENT_ACK_O, 
        EVENT_INFO_I,
    // SLEPP
        SLP_O
        );

endmodule




//module black_box(CLK_SRC, RST_n,
//                 LCDRS, LCDRW, LCDE,
//	         LCDDBO, LCDDBI,
//                 KEYYO, KEYXI,
//                 RXD, TXD, CTS, RTS);
//
//    output  CLK_SRC; // non stop clock
//    output  RST_n;
//    input LCDRS;
//    input LCDRW;
//    input LCDE;
//    input [7:0] LCDDBO;
//    output  [7:0] LCDDBI;
//    input [4:0] KEYYO;
//    output  [4:0] KEYXI;
//    output  RXD;
//    input TXD;
//    output  CTS;
//    input RTS;
//endmodule
//
//
//module S2QED_top();
//  
//    wire CLK_SRC; // non stop clock
//    wire RST_n;
//    wire LCDRS;
//    wire LCDRW;
//    wire LCDE;
//    wire [7:0] LCDDBO;
//    wire [7:0] LCDDBI;
//    wire [4:0] KEYYO;
//    wire [4:0] KEYXI;
//    wire RXD;
//    wire TXD;
//    wire CTS;
//    wire RTS;
// 
//    black_box bb_inst(
//      CLK_SRC, RST_n,
//      LCDRS, LCDRW, LCDE,
//	  LCDDBO, LCDDBI,
//	  KEYYO, KEYXI,
//      RXD, TXD, CTS, RTS
//    );
//
//    top top_inst_0(
//      CLK_SRC, RST_n,
//      LCDRS, LCDRW, LCDE,
//	  LCDDBO, LCDDBI,
//	  KEYYO, KEYXI,
//      RXD, TXD, CTS, RTS
//    );
//
//    top top_inst_1(
//      CLK_SRC, RST_n,
//      LCDRS, LCDRW, LCDE,
//	  LCDDBO, LCDDBI,
//	  KEYYO, KEYXI,
//      RXD, TXD, CTS, RTS
//    );
//
//endmodule
