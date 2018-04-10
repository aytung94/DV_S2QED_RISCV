# Create the library.
if [file exists work] {
    vdel -all
}
vlib work

# Compile the sources.
vlog mriscvcore.v MEMORY_INTERFACE/MEMORY_INTERFACE.v DECO_INSTR/DECO_INSTR.v REG_FILE/REG_FILE.v ALU/ALU.v IRQ/IRQ.v MULT/MULT.v UTILITIES/UTILITY.v FSM/FSM.v
#vlog +cover -sv ../tb/interfaces.sv  ../tb/sequences.sv ../tb/coverage.sv ../tb/scoreboard.sv ../tb/modules.sv ../tb/tests.sv  ../tb/tb.sv  

# Simulate the design.
vsim -c mriscvcore
run -all
exit