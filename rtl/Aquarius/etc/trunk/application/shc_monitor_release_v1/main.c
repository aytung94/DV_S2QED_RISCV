//===============================
// Monitor Program
//-------------------------------
// for VirtexE Evaluation Board
// May.1 2003 Ver.1
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

//=================
// Define Functions
//=================
void utility(void);
unsigned char command(unsigned long *data);
unsigned long get_sformat(void);
unsigned char get_byte_rx_echo(void);
unsigned char hex2asc(unsigned char hex);
unsigned char asc2hex(unsigned char asc);

void          waitNms(unsigned char n);
unsigned char key_scan();
unsigned char key_wait_on(void);
void          key_wait_off(void);

void          uart_tx(unsigned char data);
unsigned char uart_rx(void);
unsigned char uart_rx_echo(void);
void          uart_rx_flush(void);
void          uart_set_baudrate(void);

void          lcd_disp_long(unsigned long data);
void          lcd_cursor(unsigned char con);
void          lcd_erase(unsigned char pos);
void          lcd_message(unsigned char pos, unsigned char *pstr);
void          lcd_disp(unsigned char chr);
void          lcd_pos(unsigned char pos);
void          lcd_ready(void);
unsigned char lcd_rd(int);
void          lcd_wr(int, unsigned char);
void          lcd_init(void);

//============
// IRQ Handler
//============
void irq_handler(void)
{
    unsigned char mes_irq[]  = "IRQ: Push to RTE";

    lcd_message(16, mes_irq);
    key_wait_off();
    key_wait_on();
    key_wait_off();
}

//============
// NMI Handler
//============
void nmi_handler(void)
{
    unsigned char mes_nmi[]  = "NMI/BRK:Goto Mon";

    SYS.INTCTL = SYS.INTCTL & 0xfeffffff; // BRK off

    lcd_message(16, mes_nmi);
    key_wait_off();
    key_wait_on();
    key_wait_off();
}

//=============
// TRAP Handler
//=============
void trap_handler(void)
{
    unsigned char mes_trap[] = "TRAP:Push to RTE";

    lcd_message(16, mes_trap);
    key_wait_off();
    key_wait_on();
    key_wait_off();
}

//====================
// Illegal Instruction
//====================
void illegal(void)
{
    unsigned char mes_ilgl[] = "Illegal:Goto Mon";

    lcd_message(16, mes_ilgl);
    key_wait_off();
    key_wait_on();
    key_wait_off();
}

//==============
// Address Error
//==============
void error(void)
{
    unsigned char mes_error[]= "AdrsErr:Goto Mon";

    lcd_message(16, mes_error);
    key_wait_off();
    key_wait_on();
    key_wait_off();
}

//=============
// Main Routine
//=============
void main_sh(void)
{
    unsigned char mes_welcome[]   = "SH-2 Monitor v.1";
    unsigned char mes_copyright[] = "(C) 2003 T.Aitch"; 
    unsigned char mes_memory[]    = "Memory--";
    unsigned char mes_run[]       = "Run---Good Luck!";
    
    unsigned char key;
    unsigned long adrs;
    unsigned long data;
    unsigned long data_edit;

    void (* userfunc)(void);
    long i;

    //-----------
    // Initialize
    //-----------
    lcd_init();
    uart_set_baudrate();
    uart_rx_flush();
    key_wait_off();

    //----------------
    // Welcome Message
    //----------------
    lcd_message( 0, mes_welcome);
    lcd_message(16, mes_copyright);
    for (i = 0 ; i < 2000000 ; i++);

    //----------
    // Clear LCD
    //----------
    key_wait_off();
    lcd_erase(0);
    lcd_erase(16);

    //----------------
    // Main Event Loop
    //----------------
    adrs = 0x00000000;

    while(1)
    {
        adrs = adrs & 0xfffffffc;
        data = * (unsigned long *) adrs;
        lcd_pos(0);
        lcd_disp_long(adrs);
        lcd_disp_long(data);

        lcd_message(16, mes_memory);
        
        data_edit = data;
        key = command(&data_edit);

        switch(key)
        {
            case KEYUTL: utility();
                         break;
            case KEYRUN: lcd_message(16, mes_run);
                         key_wait_off();
                         adrs = adrs & 0xfffffffe;
                         userfunc = (void (*)) adrs;
                         (* userfunc)();
                         break;
            case KEYGET: adrs = get_sformat();
                         break;
            case KEYPUT: break;
            case KEYADR: adrs = data_edit;
                         break;
            case KEYINC: adrs = adrs + 4;
                         break;
            case KEYDEC: adrs = adrs - 4;
                         break;
            case KEYDAT: * (unsigned long *) adrs = data_edit;
                         adrs = adrs + 4;
                         break;
            default:     break;
        }
    }
}

//****************************************************
//*                                                  *
//*                Service Utilities                 *
//*                                                  *
//****************************************************

//====================
// "Utility" Functions
//--------------------
//     Input  : none
//     Output : none
//====================
void utility(void)
{
    unsigned char mes_util[]   = "BRK-Func Select?";
    unsigned char mes_menu[]   = "1:REG  2:BRK SET";
    unsigned char mes_break[]  = "Set Break Point.";
    unsigned char mes_adrs[]   = "Address?";
    unsigned char mes_brkok[]  = "Break Accepted. ";
    unsigned char mes_brkng[]  = "Break Canceled. ";
    unsigned char mes_SR[]     = "SR     :";
    unsigned char mes_PC[]     = "PC     :";
    unsigned char mes_SP[]     = "SP(R15):";
    unsigned char mes_PR[]     = "PR     :";
    unsigned char mes_R0[]     = "R0     :";
    unsigned char mes_R1[]     = "R1     :";
    unsigned char mes_R2[]     = "R2     :";
    unsigned char mes_R3[]     = "R3     :";
    unsigned char mes_R4[]     = "R4     :";
    unsigned char mes_R5[]     = "R5     :";
    unsigned char mes_R6[]     = "R6     :";
    unsigned char mes_R7[]     = "R7     :";
    unsigned char mes_R8[]     = "R8     :";
    unsigned char mes_R9[]     = "R9     :";
    unsigned char mes_R10[]    = "R10    :";
    unsigned char mes_R11[]    = "R11    :";
    unsigned char mes_R12[]    = "R12    :";
    unsigned char mes_R13[]    = "R13    :";
    unsigned char mes_R14[]    = "R14    :";
    unsigned char mes_R15[]    = "R15    :";
    unsigned char mes_MACH[]   = "MACH   :";
    unsigned char mes_MACL[]   = "MACL   :";
    unsigned char mes_GBR[]    = "GBR    :";
    unsigned char mes_VBR[]    = "VBR    :";
    unsigned char key;
    unsigned long adrs;

    lcd_message(0, mes_util);
    lcd_message(16, mes_menu);
    key_wait_off();

    key = key_wait_on();
    if (key == KEY1)       // Register Watcher
    {
        key_wait_off();
        lcd_message(0,  mes_SR);   lcd_disp_long(REG.SR);
        lcd_message(16, mes_PC);   lcd_disp_long(REG.PC);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_SP);   lcd_disp_long(REG.SP);
        lcd_message(16, mes_PR);   lcd_disp_long(REG.PR);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R0);   lcd_disp_long(REG.R0);
        lcd_message(16, mes_R1);   lcd_disp_long(REG.R1);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R2);   lcd_disp_long(REG.R2);
        lcd_message(16, mes_R3);   lcd_disp_long(REG.R3);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R4);   lcd_disp_long(REG.R4);
        lcd_message(16, mes_R5);   lcd_disp_long(REG.R5);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R6);   lcd_disp_long(REG.R6);
        lcd_message(16, mes_R7);   lcd_disp_long(REG.R7);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R8);   lcd_disp_long(REG.R8);
        lcd_message(16, mes_R9);   lcd_disp_long(REG.R9);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R10);  lcd_disp_long(REG.R10);
        lcd_message(16, mes_R11);  lcd_disp_long(REG.R11);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R12);  lcd_disp_long(REG.R12);
        lcd_message(16, mes_R13);  lcd_disp_long(REG.R13);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_R14);  lcd_disp_long(REG.R14);
        lcd_message(16, mes_R15);  lcd_disp_long(REG.R15);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_MACH); lcd_disp_long(REG.MACH);
        lcd_message(16, mes_MACL); lcd_disp_long(REG.MACL);
        key_wait_on();
        key_wait_off();
        lcd_message(0,  mes_GBR);  lcd_disp_long(REG.GBR);
        lcd_message(16, mes_VBR);  lcd_disp_long(REG.VBR);
        key_wait_on();
        key_wait_off();
    }
    else if (key == KEY2)  // Break Setting
    {
        lcd_message(0, mes_break);
        lcd_message(16, mes_adrs);
        adrs = SYS.BRKADR;
        key = command(&adrs);
        if (key == KEYDAT)
        {
            lcd_message(0, mes_brkok);
            key_wait_off();
            SYS.BRKADR = adrs;
            SYS.INTCTL = SYS.INTCTL | 0x01000000; // BRK on
        }
        else
        {
            lcd_message(0, mes_brkng);
            key_wait_off();
            SYS.INTCTL = SYS.INTCTL & 0xfeffffff; // BRK off
        }
    }
}

//=========================================
// Command Handler
//-----------------------------------------
//     Input  : data    = display long data
//     Output : command = input command
//              data    = input long data
//=========================================
unsigned char command(unsigned long *data)
{
    unsigned char key;
    int i;

    lcd_pos(24);
    lcd_disp_long(*data);

    lcd_cursor(1);
    i = 0;

    do
    {
        if (i == 0) lcd_pos(24);

        key_wait_off();
        key = key_wait_on();
        if (key <= KEYF)
        {
            lcd_disp(hex2asc(key));
            *data = (*data & ~((0x0000000F) << ((7-i) * 4))) | (key << ((7-i) * 4));
        }

        i = (i + 1) % 8;
    } while (key <= KEYF);
   
    lcd_cursor(0);
    return(key);
}

//=================================================
// Get S-Format
//-------------------------------------------------
//     Input  : none
//     Output : get_sformat = address of top-record
//=================================================
unsigned long get_sformat(void)
{
    unsigned char mes_get[]       = "Get S-Format(S3)";
    unsigned char mes_send[]      = "please send.....";
    unsigned char mes_receive[]   = "-----OK!";
    unsigned char mes_get_error[] = "ERR:Bad S-Format";

    int topflag;
    int endflag;
    unsigned char rc;
    unsigned char rxdata;
    unsigned long adrs;
    unsigned long adrs_record;
    unsigned long adrs_top = 0;
    int count;
    unsigned char checksum;
    int error;
    int i;

    error = 0;
    topflag = 1;
    endflag = 0;
    
    uart_rx_flush();
    lcd_message( 0, mes_get);
    lcd_message(16, mes_send);

    while(endflag == 0)
    {   
        //
        // Wait 'S' character
        //
        while (uart_rx_echo() != 'S');
        //
        // Check Record Type
        //
        switch(rc = uart_rx_echo())
        {
            case '3': //-------- Record of 4 byte length address
            case '7': //-------- End of Record
                      //
                      // Get Record Length
                      //
                      rxdata = get_byte_rx_echo();
                      checksum = rxdata;
                      count = rxdata - 5;
                      //
                      // Get Record Address
                      //
                      adrs = 0;
                      for (i = 0 ; i < 4 ; i++)
                      {
                          rxdata = get_byte_rx_echo();
                          checksum = checksum + rxdata;
                          adrs  = (adrs << 8) + (unsigned long) rxdata;
                      }
                      adrs_record = adrs;
                      if (topflag)
                      {
                          adrs_top = adrs;
                          topflag = 0;
                      }
                      //
                      // Get Record Data and Save to memory
                      //
                      while(count > 0)
                      {
                          rxdata = get_byte_rx_echo();
                          checksum = checksum + rxdata;
                          * (unsigned char *) adrs = rxdata;
                          adrs = adrs + 1;
                          count = count - 1;
                      }
                      //
                      // Check checksum
                      //
                      rxdata = get_byte_rx_echo();
                      checksum = (~checksum) & 0x0ff;
                      error = (checksum != rxdata);
                      //
                      // Continue ? or Finish ?
                      //
                      if (rc == '3') // S3 format
                          break;
                      else           // S7 format
                      {
                          endflag = 1;
                          break;
                      }
            //
            // ignore another Record
            //
            default : continue;
        }
        if (error)
        {
            lcd_message(16, mes_get_error);
            rc = key_wait_on();
            break;
        }
        else
        {
            lcd_pos(16);
            lcd_disp_long(adrs_record);
            lcd_message(24, mes_receive);    
        }
    }
    return(adrs_top);
}

//==============================================
// Get Byte from Rx with echo
//----------------------------------------------
//     Input  : none
//     Output : get_byte_rx_echo = received byte
//==============================================
unsigned char get_byte_rx_echo(void)
{
    unsigned char hex;

    hex = asc2hex(uart_rx_echo());
    hex = (hex << 4) + asc2hex(uart_rx_echo());

    return(hex);
}

//=============================
// Convert Hex(nibble) to Ascii
//-----------------------------
//     Input  : hex (0x00-0x0F)
//     Output : hex2asc
//=============================
unsigned char hex2asc(unsigned char hex)
{
    hex = hex & 0x0f;
    if (hex <= 0x09)
        return(hex + '0');
    else
        return(hex - 0x0a + 'A');
}

//=============================
// Convert Ascii to Hex(nibble)
//-----------------------------
//     Input  : asc(0-9, A-F)
//     Output : asc2hex
//=============================
unsigned char asc2hex(unsigned char asc)
{
    if (asc <= '9')
        return((asc - '0') & 0x0f);
    else
        return((asc - 'A' + 0x0a) & 0x0f);
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

//****************************************************
//*                                                  *
//*                UART Utilities                    *
//*                                                  *
//****************************************************

//==============================
// Send Tx
// -----------------------------
//     Input  : data = send data
//     Output : none
//==============================
void uart_tx(unsigned char data)
{
    while(UART.UARTCON.BIT.TXF);
    UART.BYTE.TX = data;
}

//====================================
// Receive RX
// -----------------------------------
//     Input  : none
//     Output : uart_rx = receive data
//====================================
unsigned char uart_rx(void)
{
    while(UART.UARTCON.BIT.RXE);
    return(UART.BYTE.RX);
}

//=========================================
// Receive RX with echo to TX
// ----------------------------------------
//     Input  : none
//     Output : uart_rx_echo = receive data
//=========================================
unsigned char uart_rx_echo(void)
{
    unsigned char data;

    while(UART.UARTCON.BIT.RXE);
    data = UART.BYTE.RX;

    while(UART.UARTCON.BIT.TXF);
    UART.BYTE.TX = data;

    return(data);
}

//==================
// Flush RXD FIFO
//------------------
//     Input  : none
//     Output : none
//==================
void uart_rx_flush(void)
{
    unsigned char dummy;

    while(UART.UARTCON.BIT.RXE == 0) dummy = UART.BYTE.RX;
}

//==============================
// Set Baud Rate 9600bps
//------------------------------
//     9600*4=38.4KHz
//     20MHz/38.4KHz=520.8=20*26
//     (BRG0 + 2) = 20, BRG0=18 =0x12
//     (BRG1 + 1) = 26, BRG1=25 =0x19
//
//     4800*4=19.2KHz
//     20MHz/19.2KHz=1041.7=20*52
//     (BRG0 + 2) = 20, BRG0=18 =0x12
//     (BRG1 + 1) = 52, BRG1=51 =0x33
//
//     2400*4=9.6KHz
//     20MHz/9.6KHz=2083.3=20*104
//     (BRG0 + 2) = 20, BRG0=18 =0x12
//     (BRG1 + 1) =104, BRG1=103=0x67
//
//     1200*4=4.8KHz
//     20MHz/4.8KHz=4166.7=20*208
//     (BRG0 + 2) = 20, BRG0=18 =0x12
//     (BRG1 + 1) =208, BRG1=207=0xcf
//
//     Input  : none
//     Output : none
//==============================
void uart_set_baudrate(void)
{
    int i;
    unsigned char dummy;

    UART.UARTBG0 = 18;
    UART.UARTBG1 = 207;

    for (i = 0; i < 65536; i++) dummy = PORTI.RESERVED_0;
}

//****************************************************
//*                                                  *
//*                 LCD Utilities                    *
//*                                                  *
//****************************************************

//======================================
// LCD Display Long Hex data (8 digit)
//--------------------------------------
//     Input  : data = display long data
//     Output : none
//======================================
void lcd_disp_long(unsigned long data)
{
    int i;
    unsigned char digit;

    for (i = 7 ; i >= 0 ; i--)
    {
        digit = (unsigned char) (data / (1 << i * 4)) % 0x10;
        lcd_disp(hex2asc(digit));
    }
}

//================================
// Cursor On/Off
//--------------------------------
//     Input  : cur = off(0)/on(1)
//     Output : none
//================================
void lcd_cursor(unsigned char con)
{
    lcd_ready();
    if (con)
        lcd_wr(INST, 0x0d);
    else
        lcd_wr(INST, 0x0c);
}


//===============================
// Erase 1 line from the position
//-------------------------------
//     Input  : pos = position
//               1st line = 00-15
//               2nd line = 16-31
//     Ouput  : none
//===============================
void lcd_erase(unsigned char pos)
{
    int i;

    lcd_pos(pos);
    for (i = 0; i < 16; i++) lcd_disp(' ');
}

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

//===============
// End of Program
//===============
