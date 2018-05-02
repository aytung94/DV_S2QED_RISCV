#========================================
# SuperH (SH-2) C Compiler Makefile
#----------------------------------------
#     Rev.1 March 21, 2003 by Thorn Aitch
#========================================

#-------------
# Command Path 
#-------------
CMD_PATH = /usr/local/bin
CC = $(CMD_PATH)/sh-elf-gcc
OBJCOPY = $(CMD_PATH)/sh-elf-objcopy
SIZE = $(CMD_PATH)/sh-elf-size

#-------------
# Output Files
#-------------
TARGET = main.srec
TARGET_ELF = main.elf
MAP_FILE = $(TARGET_ELF:.elf=.map)

OUTPUT_FORMAT = srec --srec-forceS3	

#-------------------------
# Compile and Link Options
#-------------------------
INCLUDES = -I./include
#CFLAGS = -m2 -g -Os $(INCLUDES) -Wall
CFLAGS = -m2 -Os $(INCLUDES) -Wall

LDSCRIPT = startup/sh.x

LDFLAGS = -m2 -T $(LDSCRIPT) -O3 -nostartfiles -Wl,-Map,$(MAP_FILE) 

#------------
# Input Files
#------------
STARTUP = crt0.S
LIBS = 
SRCS = main.c
OBJS = $(STARTUP:.S=.o) $(LIBS:.c=.o) $(SRCS:.c=.o)

#---------------
# Make Operation
#---------------
$(TARGET) : $(TARGET_ELF)
	$(OBJCOPY) -v -O $(OUTPUT_FORMAT) $(TARGET_ELF) $(TARGET)

$(TARGET_ELF) : $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $(TARGET_ELF)
	$(SIZE) -Ax $(TARGET_ELF) 

$(OBJS) : Makefile

clean :
	rm -f *.o $(TARGET) $(TARGET_ELF) $(MAP_FILE)

%.o : %.c
	$(CC) -c $(CFLAGS) $< 

%.o : %.S
	$(CC) -c $(CFLAGS) $<

%.o : %.s
	$(CC) -c $(CFLAGS) $<

#-------------------
# Header and Startup 
#-------------------
vpath %.h ./include
vpath %.S ./startup

#------------------
# Source and Object
#------------------
main.o : main.c
