#Tcl script which can be used with JasperGold
#Use "source jg_mriscvcore.tcl" in the console to source this script

#Reading the files 
analyze -v2k {mriscvcore_top_s2qed.v mriscvcore.v MEMORY_INTERFACE/MEMORY_INTERFACE.v DECO_INSTR/DECO_INSTR.v REG_FILE/REG_FILE.v ALU/ALU.v IRQ/IRQ.v MULT/MULT.v UTILITIES/UTILITY.v FSM/FSM.v};
analyze -sv {jg_bind_wrapper.sv};

#Elaborating the design
elaborate -top {mriscvcore_top_s2qed};

#You will need to add commands below

#Set the clock
clock -clear; clock clk

#Set Reset
reset -expression {!rstn};

#Prove all
#prove -bg -all

