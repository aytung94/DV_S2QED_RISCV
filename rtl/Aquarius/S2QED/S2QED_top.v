
module black_box(CLK_SRC, RST_n,
                 LCDRS, LCDRW, LCDE,
	         LCDDBO, LCDDBI,
                 KEYYO, KEYXI,
                 RXD, TXD, CTS, RTS);

    output  CLK_SRC; // non stop clock
    output  RST_n;
    input LCDRS;
    input LCDRW;
    input LCDE;
    input [7:0] LCDDBO;
    output  [7:0] LCDDBI;
    input [4:0] KEYYO;
    output  [4:0] KEYXI;
    output  RXD;
    input TXD;
    output  CTS;
    input RTS;
endmodule


module S2QED_top();
  
    wire CLK_SRC; // non stop clock
    wire RST_n;
    wire LCDRS;
    wire LCDRW;
    wire LCDE;
    wire [7:0] LCDDBO;
    wire [7:0] LCDDBI;
    wire [4:0] KEYYO;
    wire [4:0] KEYXI;
    wire RXD;
    wire TXD;
    wire CTS;
    wire RTS;
 
    black_box bb_inst(
      CLK_SRC, RST_n,
      LCDRS, LCDRW, LCDE,
	  LCDDBO, LCDDBI,
	  KEYYO, KEYXI,
      RXD, TXD, CTS, RTS
    );

    top top_inst_0(
      CLK_SRC, RST_n,
      LCDRS, LCDRW, LCDE,
	  LCDDBO, LCDDBI,
	  KEYYO, KEYXI,
      RXD, TXD, CTS, RTS
    );

    top top_inst_1(
      CLK_SRC, RST_n,
      LCDRS, LCDRW, LCDE,
	  LCDDBO, LCDDBI,
	  KEYYO, KEYXI,
      RXD, TXD, CTS, RTS
    );

endmodule
