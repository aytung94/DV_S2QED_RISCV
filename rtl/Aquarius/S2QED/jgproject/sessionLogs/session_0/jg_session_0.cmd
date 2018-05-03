#----------------------------------------
# JasperGold Version Info
# tool      : JasperGold 2015.09
# platform  : Linux 2.6.32-696.20.1.el6.x86_64
# version   : 2015.09 FCS 64 bits
# build date: 2015.09.29 22:07:32 PDT
#----------------------------------------
# started Thu May 03 17:30:29 CDT 2018
# hostname  : kamek
# pid       : 14128
# arguments : '-label' 'session_0' '-console' 'kamek:42681' '-style' 'windows' '-proj' '/home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jgproject/.tmp/.initCmds.tcl'
include /home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jg_mriscvcore.tcl
visualize -violation -property <embedded>::S2QED_top.S2QED_BIND.ast_S2QED_SAME_VAL_W_COND_reg_diff_x -new_window
visualize -violation -property <embedded>::S2QED_top.S2QED_BIND.ast_S2QED_SAME_VAL_W_COND_reg_diff_x -new_window
visualize -min_length [expr [visualize -get_length -window visualize:1] + 1] -window visualize:1; visualize -freeze [visualize -get_length -window visualize:1] -window visualize:1; visualize -replot -bg -window visualize:1
include {/home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jg_mriscvcore.tcl}
include {/home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jg_mriscvcore.tcl}
include {/home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jg_mriscvcore.tcl}
include {/home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jg_mriscvcore.tcl}
prove -stop
include {/home/ecelrc/students/atung/verif_labs/S2QED_Aquarius/DV_S2QED_RISCV/rtl/Aquarius/S2QED/jg_mriscvcore.tcl}
