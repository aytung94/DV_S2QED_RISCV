//===============================
// Calculate Circular Constant Pi
// (1024 figures)
//-------------------------------
// for VirtexE Evaluation Board
// July.20 2003 Ver.1
//===============================

//======================================================
// Address Map
//======================================================
// address           sz  wt wd device
// 00000000-00001FFF  8K 0  32 ROM (code)
// 00002000-00003DFF  6K 0  32 RAM (data)
// 00003E00-00003FFF 512 0  32 RAM (stack)
//
// 00000000-0000FFFF 64K 0  32 RAM (shadow every 16KB)
// 00010000-0001FFFF 64K 3  32 RAM (shadow every 16KB)
// 00020000-0002FFFF 64K 0  16 RAM (shadow every 16KB)
// 00030000-0003FFFF 64K 3  16 RAM (shadow every 16KB)
// 00040000-ABCCFFFF (shadow RAM)
// ABCD0000-ABCD00FF 256 3  32 PIO (shadow every 4B)
// ABCD0100-ABCD01FF 256 3  32 UART(shadow every 4B)
// ABCD0200-ABCD02FF 256 3  32 SYS (shadow every 8B)
// ABCD0300-FFFBFFFF (shadow RAM)
// FFFC0000-FFFCFFFF 64K 0  32 RAM (shadow every 16KB)
// FFFD0000-FFFDFFFF 64K 3  32 RAM (shadow every 16KB)
// FFFE0000-FFFEFFFF 64K 0  16 RAM (shadow every 16KB)
// FFFF0000-FFFFFFFF 64K 3  16 RAM (shadow every 16KB)
// 
//======================================================
// PORT OUTPUT
//======================================================
// ABCD0000 : reserved
//   31    30    29    28    27    26    25    24
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |     |     |     |     |     |     |     |     |
//  -----------------------------------------------;
// 
// ABCD0001 : KEYYO (Key SCAN Y-axis out)
//   23    22    21    20    19    18    17    16
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |     |     |     | KY4 | KY3 | KY2 | KY1 | KY0 |
//  -----------------------------------------------
// 
// ABCD0002 : LCDCON (LCD Control Signal)
//   15    14    13    12    11    10     9     8
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |     |     |     |     |     |  E  | R/W |  RS |
//  -----------------------------------------------
// 
// ABCD0003 : LCDOUT (Write Data to LCD)
//    7     6     5     4     3     2     1     0
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// | DW7 | DW6 | DW5 | DW4 | DW3 | DW2 | DW1 | DW0 |
//  -----------------------------------------------
// 
//======================================================
// PORT INPUT
//======================================================
// ABCD0000 : reserved
//   31    30    29    28    27    26    25    24
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |     |     |     |     |     |     |     |     |
//  -----------------------------------------------;
// 
// ABCD0001 : KEYXI (Key SCAN X-axis in)
//   23    22    21    20    19    18    17    16
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |     |     |     | KX4 | KX3 | KX2 | KX1 | KX0 |
//  -----------------------------------------------
// 
// ABCD0002 : reserved
//  15    14    13    12    11    10     9     8
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |     |     |     |     |     |     |     |    |
//  -----------------------------------------------
// 
// ABCD0003 : LCDIN (Read Data from LCD)
//    7     6     5     4     3     2     1     0
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// | DR7 | DR6 | DR5 | DR4 | DR3 | DR2 | DR1 | DR0 |
//  -----------------------------------------------
// 
//======================================================
// UART: SASC (www.opencores.com)
// Simple Asynchronous Serial Communication Device
//======================================================
// ABCD0100 : UARTBG0 Baud Rate Generator Div0 (R/W)
//   31    30    29    28    27    26    25    24
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// | B07 | B06 | B05 | B04 | B03 | B02 | B01 | B00 |
//  -----------------------------------------------
// 
// ABCD0101 : UARTBG1 Baud Rate Generator Div1 (R/W)
//   23    22    21    20    19    18    17    16
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// | B17 | B16 | B15 | B14 | B13 | B12 | B11 | B10 |
//  -----------------------------------------------
// 
// ABCD0102 : UARTCON (TXF=full_o, RXE=empty_o) (R only)
//   15    14    13    12    11    10     9      8
//    7     6     5     4     3     2     1      0
//  -----------------------------------------------
// |     |     |     |     |     |     | TXF | RXE |
//  -----------------------------------------------
// 
// ABCD0103 : UARTTXD(W only)/UARTRXD(R only)
//    7     6     5     4     3     2     1     0
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// | TR7 | TR6 | TR5 | TR4 | TR3 | TR2 | TR1 | TR0 |
//  -----------------------------------------------
// 
//======================================================
// System Controller
// Interrupt and Exception Controller
//======================================================
// ABCD0200 : INTCTL Interrupt Control (32bit R/W only)
//   31    30    29    28    27    26    25    24
//  -----------------------------------------------
// |E_NMI|E_IRQ|E_CER|E_DER|E_MRS|     |TMRON|BRKON|
//  -----------------------------------------------
//   23    22    21    20    19    18    17    16
//  -----------------------------------------------
// |ILVL3|ILVL2|ILVL1|ILVL0|IVEC7|IVEC6|IVEC5|IVEC4|
//  ----------------------------------------------- 
//   15    14    13    12    11    10     9     8
//  -----------------------------------------------
// |IVEC3|IVEC2|IVEC1|IVEC0|TMR11|TMR10|TMR09|TMR08|
//  -----------------------------------------------  
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |TMR07|TMR06|TMR05|TMR04|TMR03|TMR02|TMR01|TMR00|
//  ----------------------------------------------- 
//     bit31: E_NMI Emulate NMI Interrupt     (W only)
//     bit30: E_IRQ Emulate IRQ Interrupt     (W only)
//     bit29: E_CER Emulate CPU Address Error (W only)
//     bit28: E_DER Emulate DMA Address Error (W only)
//     bit27: E_MRS Emulate Manual Reset      (W only)                               
//     bit26: reserved
//     bit25: TMRON INTTMR OFF/ON             (0:OFF, 1:ON)
//     bit24: BRKON Address Break(NMI) OFF/ON (0:OFF, 1:ON)
//     bit23: ILVL3 IRQ ILevel 3
//     bit22: ILVL2 IRQ ILevel 2
//     bit21: ILVL1 IRQ ILevel 1
//     bit20: ILVL0 IRQ ILevel 0
//     bit19: IVEC7 IRQ Vector 7
//     bit18: IVEC6 IRQ Vector 6
//     bit17: IVEC5 IRQ Vector 5
//     bit16: IVEC4 IRQ Vector 4
//     bit15: IVEC3 IRQ Vector 3
//     bit14: IVEC2 IRQ Vector 2
//     bit13: IVEC1 IRQ Vector 1
//     bit12: IVEC0 IRQ Vector 0
//     bit11: TMR11 (12 bit interval timer to generate IRQ)
//     ...
//     bit 0: TMR00 (12 bit interval timer to generate IRQ)
// 
// ABCD0204 : BRKADR Break Address (16bit R/W only)
//   15    14    13    12    11    10     9     8
//  -----------------------------------------------
// |ADR15|ADR14|ADR13|ADR12|ADR11|ADR10|ADR09|ADR08|
//  -----------------------------------------------  
//    7     6     5     4     3     2     1     0
//  -----------------------------------------------
// |ADR07|ADR06|ADR05|ADR04|ADR03|ADR02|ADR01|ADR00|
//  ----------------------------------------------- 
//     bit15: ADR15 Break Address15
//     ...
//     bit00: ADR00 Break Address00
// 

#include "common.h"
#define  MAXFIGURE ((1024/4)+2) // should be (N*8)+2 to display correctly

//=================
// Define Functions
//=================
void          lcd_message(unsigned char pos, unsigned char *pstr);
void          lcd_disp(unsigned char chr);
void          lcd_pos(unsigned char pos);
void          lcd_ready(void);
unsigned char lcd_rd(int);
void          lcd_wr(int, unsigned char);
void          lcd_init(void);

void          waitNms(unsigned char n);
unsigned char key_scan();
unsigned char key_wait_on(void);
void          key_wait_off(void);

void          longadd(unsigned short *a, unsigned short *b, unsigned short *c);
void          longsub(unsigned short *a, unsigned short *b, unsigned short *c);
int           longdiv(unsigned short *a, unsigned short b, unsigned short *c);
void          calc_pi(void);
void          disp_oct4(unsigned short x);
void          disp_pi(void);

//-----------------------------------
// Work data for Circular Constant Pi
//-----------------------------------
unsigned short PI[MAXFIGURE];
unsigned short T1[MAXFIGURE];
unsigned short T2[MAXFIGURE];
unsigned short T3[MAXFIGURE];

//=============
// Main Routine
//=============
void main_sh(void)
{
    unsigned char mes[] = "Calculating.....";

    lcd_init();
    lcd_message(0, mes);
    calc_pi();
    disp_pi();
}

//-------------------------------------------------
// Calculate the Circular Constant Pi
//-------------------------------------------------
// (1) Matin's formula
// PI/4 =  4*arctan(1/5) -   arctan(1/239)
// PI   = 16*arctan(1/5) - 4*arctan(1/239)
// Here, arctan(1/p) = 1/p - 1/(3*p^3) + 1/(5*p^5) - 1/(7*p^7) + ...
// Then, 
// PI =  (16*1/5     - 4*1/239)
//     - (16*1/3*5^3 - 4*1/3*239^3)
//     + (16*1/5*5^5 - 4*1/5*239^5)
//     - (16*1/7*5^7 - 4*1/7*239^7)
//     +...
//    =  (1/1)*(16*5/(5*5)^1 - 4*239/(239*239)^1)
//     - (1/3)*(16*5/(5*5)^2 - 4*239/(239*239)^2)
//     + (1/5)*(16*5/(5*5)^3 - 4*239/(239*239)^3)
//     - (1/7)*(16*5/(5*5)^4 - 4*239/(239*239)^4)
//     +...
//-------------------------------------------------
// (2) Define Arrays for Long Figure Number
// Each element has Octal 4 figures. 
//     PI[] : Value to be converged to Pi
//     T1[] : (16*  5)/(  5*  5)^n (n=1...)
//     T2[] : ( 4*239)/(239*239)^n (n=1...)
//     T3[] : (-1)*(n+1)*(1/(2n-1))*(T1[]-T2[])
//-------------------------------------------------
// (3) Example
// n TI[0] TI[1] T2[0] T2[1] T3[0] T3[1] PI[0] PI[1] 
// 0 0080  0000  0956  0000  0000  0000  0000  0000
// 1 0003  2000  0000  0167  0003  1833  0003  1833 (+)
// 2 0000  1280  0000  0000  0000  0426  0003  1407 (-)
// 3 0000  0051  0000  0000  0000  0010  0003  1417 (+)
// 4 0000  0002  0000  0000  0000  0000  0003  1417 (-)
//-------------------------------------------------
void calc_pi(void)
{
    int i;
    int converged;
    //-----------
    // Initialize
    //-----------
    converged = 0;
    for (i=0; i<=MAXFIGURE-1; i++)
    {
        PI[i] = 0;
        T1[i] = 0;
        T2[i] = 0;
        T3[i] = 0;
    }
    T1[0] = 16*5;
    T2[0] = 4*239;

    //-----------------------------
    // repeat until being converged
    //-----------------------------
    i = 1;
    while (converged == 0)
    {
        //-------------
        // Make T1 & T2
        //-------------
        longdiv(T1,  25, T1);
        longdiv(T2, 239, T2);
        longdiv(T2, 239, T2);
        //--------
        // Make T3
        //--------
        longsub(T1, T2, T3);
        converged = longdiv(T3, (unsigned short)(2*i-1), T3); 
        //if (converged) break;
        //-----------------
        // Accumulate to PI
        //-----------------
        if (i%2 != 0)
            longadd(PI, T3, PI);
        else
            longsub(PI, T3, PI);
        //------------
        // Increment i
        //------------
        i++;
    }
}

//---------
// Long Add
//---------
void longadd(unsigned short *a, unsigned short *b, unsigned short *c)
{
    int i;
    unsigned short carry;

    carry = 0;
    for (i = MAXFIGURE-1; i >= 0; i--)
    {
        *(c+i) = *(a+i) + *(b+i) + carry;
        if (*(c+i) < 10000)
            carry = 0;
        else
        {
            carry = 1;
            *(c+i) = *(c+i) - 10000;
        }
    }
}

//---------
// Long Sub
//---------
void longsub(unsigned short *a, unsigned short *b, unsigned short *c)
{
    int i;
    unsigned short borrow;
    unsigned short temp;

    borrow = 0;
    for (i = MAXFIGURE-1; i >= 0; i--)
    {
        temp = *(b+i) + borrow;
        if (*(a+i) >= temp)
        {
            *(c+i) = *(a+i) - temp;
            borrow = 0;
        }
        else
        {
            *(c+i) = 10000 + *(a+i) - temp;
            borrow = 1;
        }
    }
}

//---------
// Long Div
//---------
int longdiv(unsigned short *a, unsigned short b, unsigned short *c)
{
    int i;
    int conv;
    unsigned long al, bl, cl, dvd, rem;

    conv = 1;
    rem = 0;
    for (i = 0; i <= MAXFIGURE-1; i++)
    {
        al = (unsigned long) *(a+i);
        bl = (unsigned long) b;
        cl = (unsigned long) *(c+i);

        dvd = al + rem;
        cl = dvd / b;
        rem    = (dvd - cl * bl) * 10000;
        if (cl > 0) conv = 0;
        *(c+i) = (unsigned short) cl; 
    }
    return conv;
}

//-----------
// Display Pi
//-----------
void disp_pi(void)
{
    unsigned char mes1[] = "Calculating DONE";
    unsigned char mes2[] = "Constant Pi = 3.";
    int i, j;

    while(1)
    {
        lcd_message( 0, mes1);
        lcd_message(16, mes2);
        key_wait_off();
        key_wait_on();
        // PI[MAXFIGURE-1] has error, so do not display.
        for (i = 0; i < (MAXFIGURE - 2) / 8; i++)
        {
            for (j = 0; j < 8; j++)
            {
                if (j == 0) lcd_pos(0);
                if (j == 4) lcd_pos(16);
                disp_oct4(*(PI + i*8 + j + 1));
            }
            key_wait_off();
            key_wait_on(); 
        }
    }
}

//-------------------
// Display Oct 4 digit
//-------------------
void disp_oct4(unsigned short x)
{
    unsigned short d;

    d = x / 1000;
    x = x - d * 1000;
    lcd_disp((char)(d+0x30));
    d = x / 100;
    x = x - d * 100;
    lcd_disp((char)(d+0x30));
    d = x / 10;
    x = x - d * 10;
    lcd_disp((char)(d+0x30));
    lcd_disp((char)(x+0x30));
}

//****************************************************
//*                                                  *
//*                 LCD Utilities                    *
//*                                                  *
//****************************************************

//========================================
// Print a Message from Current Position
//----------------------------------------
//     Input  : pstr = message top address
//     Outpur : none
//========================================
void lcd_message(unsigned char pos, unsigned char *pstr)
{
    unsigned char *pmessage;

    lcd_pos(pos);
    pmessage = pstr;
    while (*pmessage) lcd_disp(*pmessage++);
}

//==========================================
// Display One Character on Current Position
//------------------------------------------
//     Input  : chr = display charcter
//     Output : none
//==========================================
void lcd_disp(unsigned char chr)
{
    lcd_ready();
    lcd_wr(DATA, chr);
}

//================================
// Set LCD Display Position
//--------------------------------
//     Input  : pos = position
//                1st line = 00-15
//                2nd line = 16-31
//     Ouput  : none
//================================
void lcd_pos(unsigned char pos)
{
    unsigned char phypos;

    phypos = pos % 32;
    if (phypos >= 16)
        phypos = (phypos - 16) + 64;
    phypos = phypos | 0x80; 

    lcd_ready();
    lcd_wr(INST, phypos);
}

//=====================
// Wait until LCD ready
//---------------------
//     Input  : none
//     Output : none 
//=====================
void lcd_ready(void)
{
    while ((lcd_rd(INST) & 0x80) == 0x80); 
}

//=================================
// LCD Read
//---------------------------------
//     Input  : rs (0=Instr,1=Data)
//     Output : lcd_rd (Read Data) 
//=================================
unsigned char lcd_rd(int rs)
{
    int i;
    unsigned char dummy;
    unsigned char data;

    PORTO.LCDCON.BYTE = 0x02 | (rs & 0x01);

    // wait 60ns = 2cyc@20MHz
    dummy = PORTI.RESERVED_0; 
    dummy = PORTI.RESERVED_0;


    PORTO.LCDCON.BYTE = 0x06 | (rs & 0x01);

    // wait 500ns = 10cyc@20MHz
    for (i = 0 ; i <= 10 ; i++) dummy = PORTI.RESERVED_0;

    data = PORTI.LCDIN;

    PORTO.LCDCON.BYTE = 0x02 | (rs & 0x01);

    // wait 500ns = 10cyc@20MHz
    for (i = 0 ; i <= 10 ; i++) dummy = PORTI.RESERVED_0;

    return(data);
}

//=================================
// LCD Write
//---------------------------------
//     Input  : rs (0=Instr,1=Data)
//              wd (Write Data)
//     Output : none
//=================================
void lcd_wr(int rs, unsigned char wd)
{
    int i;
    unsigned char dummy;

    PORTO.LCDOUT = wd;

    PORTO.LCDCON.BYTE = 0x00 | (rs & 0x01);

    // wait 60ns = 2cyc@20MHz
    dummy = PORTI.RESERVED_0; 
    dummy = PORTI.RESERVED_0;

    PORTO.LCDCON.BYTE = 0x04 | (rs & 0x01);

    // wait 500ns = 10cyc@20MHz
    for (i = 0 ; i <= 10 ; i++) dummy = PORTI.RESERVED_0;

    PORTO.LCDCON.BYTE = 0x00 | (rs & 0x01);

    // wait 500ns = 10cyc@20MHz
    for (i = 0 ; i <= 10 ; i++) dummy = PORTI.RESERVED_0;
}

//==================
// LCD Initialize
//------------------
//     Input  : none
//     Output : none
//==================
void lcd_init(void)
{
    int i;
    unsigned char dummy;

    lcd_wr(INST, 0x30);

    // wait 4100us=82000cyc@20MHz
    for (i = 0 ; i < 82000 ; i++) dummy = PORTI.RESERVED_0;

    lcd_wr(INST, 0x30);

    // wait 100us=2000cyc@20MHz
    for (i = 0 ; i < 2000 ; i++) dummy = PORTI.RESERVED_0;

    lcd_wr(INST, 0x30);

    // set function (8bit, 2lines)
    lcd_ready();
    lcd_wr(INST, 0x38);

    // display (disp on, cursor off, blink off)
    lcd_ready();
    lcd_wr(INST, 0x0c);

    // clear
    lcd_ready();
    lcd_wr(INST, 0x01);

    // entry mode (increment, no-shift)
    lcd_ready();
    lcd_wr(INST, 0x06);
}

//****************************************************
//*                                                  *
//*                 Key Utilities                    *
//*                                                  *
//****************************************************

//===================================
// Wait until Key On
//-----------------------------------
//     Input  : none
//     Output : key = pushed key code
//===================================
unsigned char key_wait_on(void)
{
    unsigned char key;

    while((key = key_scan()) == KEYNONE) waitNms(8);

    return(key);
}

//===================
// Wait until Key Off
//-------------------
//     Input  : none
//     Output : none
//===================
void key_wait_off(void)
{
    while(key_scan() != KEYNONE) waitNms(8);
}

//===================================
// Key Scan
//-----------------------------------
//     Input  : none
//     Output : key = pushed key code
//===================================
unsigned char key_scan()
{
    unsigned char keyx4;
    unsigned char keyx3;
    unsigned char keyx2;
    unsigned char keyx1;
    unsigned char keyx0;

    PORTO.KEYYO.BYTE = 0xef; // KEYY4
    waitNms(1);
    keyx4 = PORTI.KEYXI.BYTE & 0x1f;

    PORTO.KEYYO.BYTE = 0xf7; // KEYY3
    waitNms(1);
    keyx3 = PORTI.KEYXI.BYTE & 0x1f;

    PORTO.KEYYO.BYTE = 0xfb; // KEYY2
    waitNms(1);
    keyx2 = PORTI.KEYXI.BYTE & 0x1f;

    PORTO.KEYYO.BYTE = 0xfd; // KEYY1
    waitNms(1);
    keyx1 = PORTI.KEYXI.BYTE & 0x1f;

    PORTO.KEYYO.BYTE = 0xfe; // KEYY0
    waitNms(1);
    keyx0 = PORTI.KEYXI.BYTE & 0x1f;

    switch(keyx4)
    {
        case 0x17 : return(KEYPUT);
        case 0x1b : return(KEYGET);
        case 0x1d : return(KEYRUN);
        case 0x1e : return(KEYUTL);
    }
    switch(keyx3)
    {
        case 0x0f : return(KEYADR);
        case 0x17 : return(KEYF);
        case 0x1b : return(KEYE);
        case 0x1d : return(KEYD);
        case 0x1e : return(KEYC);
    }
    switch(keyx2)
    {
        case 0x0f : return(KEYINC);
        case 0x17 : return(KEYB);
        case 0x1b : return(KEYA);
        case 0x1d : return(KEY9);
        case 0x1e : return(KEY8);
    }
    switch(keyx1)
    {
        case 0x0f : return(KEYDEC);
        case 0x17 : return(KEY7);
        case 0x1b : return(KEY6);
        case 0x1d : return(KEY5);
        case 0x1e : return(KEY4);
    }
    switch(keyx0)
    {
        case 0x0f : return(KEYDAT);
        case 0x17 : return(KEY3);
        case 0x1b : return(KEY2);
        case 0x1d : return(KEY1);
        case 0x1e : return(KEY0);
    }
    return(KEYNONE);
}

//==================
// Wait n ms
//------------------
//     Input  : n ms
//     Output : none
//==================
void waitNms(unsigned char n)
{
    int  i, j;
    unsigned char dummy;

    for (i = 0 ; i < n ; i++)
    {
        // 1ms = 20000 * 50ns (20MHz)
        for (j = 0 ; i <= 10000 ; i++) dummy = PORTI.RESERVED_0;
    }
}

//===============
// End of Program
//===============
