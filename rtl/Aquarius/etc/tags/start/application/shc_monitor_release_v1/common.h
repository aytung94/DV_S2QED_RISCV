//===============================
// C Source Header
//-------------------------------
// for VirtexE Evaluation Board
// Apr.19 2003 Ver.1
//===============================

//--------------------------
// Peripheral I/O definition
//--------------------------
struct st_porto
{
    unsigned char RESERVED_0;
    union
    {
        unsigned char BYTE;
        struct
        {
            unsigned char    :3;
            unsigned char KY4:1;
            unsigned char KY3:1;
            unsigned char KY2:1;
            unsigned char KY1:1;
            unsigned char KY0:1;
        } BIT;
    } KEYYO;
    union
    {
        unsigned char BYTE;
        struct
        {
            unsigned char   :5;
            unsigned char E :1;
            unsigned char RW:1;
            unsigned char RS:1;
        } BIT;
    } LCDCON;
    unsigned char LCDOUT;
};

struct st_porti
{
    unsigned char RESERVED_0;
    union
    {
        unsigned char BYTE;
        struct
        {
            unsigned char    :3;
            unsigned char KX4:1;
            unsigned char KX3:1;
            unsigned char KX2:1;
            unsigned char KX1:1;
            unsigned char KX0:1;
        } BIT;
    } KEYXI;
    unsigned char RESERVED_2;
    unsigned char LCDIN;
};

struct st_uart
{
    unsigned char UARTBG0;
    unsigned char UARTBG1;
    union
    {
        unsigned char BYTE;
        struct
        {
          unsigned char    :6;
          unsigned char TXF:1;
          unsigned char RXE:1;
        } BIT;
    } UARTCON;
    union
    {
        unsigned char TX;
        unsigned char RX;
    } BYTE;
};

struct st_sys
{
    unsigned long INTCTL;
    unsigned long BRKADR;
};

struct st_reg
{
    unsigned long SR;
    unsigned long PC;
    unsigned long SP;
    unsigned long PR;
    unsigned long R0;
    unsigned long R1;
    unsigned long R2;
    unsigned long R3;
    unsigned long R4;
    unsigned long R5;
    unsigned long R6;
    unsigned long R7;
    unsigned long R8;
    unsigned long R9;
    unsigned long R10;
    unsigned long R11;
    unsigned long R12;
    unsigned long R13;
    unsigned long R14;
    unsigned long R15;
    unsigned long MACH;
    unsigned long MACL;
    unsigned long GBR;
    unsigned long VBR;
};

#define PORTO (*(volatile struct st_porto  *)0xabcd0000)
#define PORTI (*(volatile struct st_porti  *)0xabcd0000)
#define UART  (*(volatile struct st_uart   *)0xabcd0100)
#define SYS   (*(volatile struct st_sys    *)0xabcd0200)
#define REG   (*(volatile struct st_reg    *)0x00000300)

//-----------
// LCD Access
//-----------
#define INST 0
#define DATA 1

//---------
// Key Code
//---------
#define KEY0 0
#define KEY1 1
#define KEY2 2
#define KEY3 3
#define KEY4 4
#define KEY5 5
#define KEY6 6
#define KEY7 7
#define KEY8 8
#define KEY9 9
#define KEYA 10
#define KEYB 11
#define KEYC 12
#define KEYD 13
#define KEYE 14
#define KEYF 15
#define KEYUTL 16
#define KEYRUN 17
#define KEYGET 18
#define KEYPUT 19
#define KEYADR 20
#define KEYINC 21
#define KEYDEC 22
#define KEYDAT 23
#define KEYNONE 255




