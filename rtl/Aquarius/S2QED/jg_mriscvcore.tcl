#Tcl script which can be used with JasperGold
#Use "source jg_mriscvcore.tcl" in the console to source this script

#Reading the files 
analyze -v2k {S2QED_top.v cpu.v mem.v decode.v datapath.v register.v mult.v};
analyze -sv {jg_bind_wrapper.sv };

#Elaborating the design
elaborate -top {S2QED_top} -bbox_m {black_box mem} -disable_auto_bbox;

#You will need to add commands below

#Set the clock
clock -clear; clock CLK;

#Set Reset
reset -expression {RST};

#Prove all
prove -bg -all

