//EE382M-Verification of Digital Systems
//Lab 4 - Formal Property Verification
//
//
//Modules - apb_props and Wrapper
//SystemVerilog Properties for the module - arbiter_top
`include "defines.v"

module s2qed(
    input clk,
    input rst,
    input cpu0_fetch_inst_ready,
    input cpu1_fetch_inst_ready,
    input [15:0] cpu0_inst,
    input [15:0] cpu1_inst,
    input [31:0] cpu0_reg[0:15],
    input [31:0] cpu1_reg[0:15],
    input [9:0]  cpu0_sr,
    input [9:0]  cpu1_sr,
    input [31:0] cpu0_gbr,
    input [31:0] cpu1_gbr,
    input [31:0] cpu0_vbr,
    input [31:0] cpu1_vbr,
    input [31:0] cpu0_pr,
    input [31:0] cpu1_pr,
    input [31:0] cpu0_pc,
    input [31:0] cpu1_pc,
    input [31:0] cpu0_mach,    
    input [31:0] cpu1_mach,
    input [31:0] cpu0_macl,
    input [31:0] cpu1_macl,
    input cpu0_wrreg_w,
    input cpu1_wrreg_w,
    input cpu0_wrreg_z,
    input cpu1_wrreg_z,
    input cpu0_wrmach,
    input cpu1_wrmach,
    input cpu0_wrmacl,
    input cpu1_wrmacl,
    input [3:0] cpu0_regnum_x,
    input [3:0] cpu1_regnum_x,
    input [3:0] cpu0_regnum_y,
    input [3:0] cpu1_regnum_y,
    input [3:0] cpu0_regnum_z,
    input [3:0] cpu1_regnum_z,
    input [3:0] cpu0_regnum_w,
    input [3:0] cpu1_regnum_w
);

    function bit [3:0] reg_map(
        input bit [3:0] orig_reg
    );
        case (orig_reg)
            0:  reg_map = 0;
            1:  reg_map = 12;
            2:  reg_map = 11;
            3:  reg_map = 10;
            4:  reg_map = 9;
            5:  reg_map = 8;
            6:  reg_map = 7;
            7:  reg_map = 6;
            8:  reg_map = 5;
            9:  reg_map = 4;
            10: reg_map = 3;
            11: reg_map = 2;
            12: reg_map = 13;
            13: reg_map = 1;
            14: reg_map = 15;
            15: reg_map = 14;
        endcase    
    endfunction


property p_S2QED_SAME_VAL(inp0, inp1);
	@(posedge clk) 
	inp0 == inp1;
endproperty

property p_S2QED_SAME_VAL_W_COND(cond, inp0, inp1);
	@(posedge clk) 
	cond |-> inp0 == inp1;
endproperty

property p_S2QED_INP_CHANGE_W_COND(cond, inp);
	@(posedge clk) 
	$rose(cond) |=> ($past(inp) != inp);
endproperty

// INSTR LEGAL
//asm_S2QED_SAME_VAL_top_byte: assume property(p_S2QED_SAME_VAL(cpu0_inst[15:12], cpu1_inst[15:12]));
//asm_S2QED_SAME_VAL_bot_byte: assume property(p_S2QED_SAME_VAL(cpu0_inst[3:0], cpu1_inst[3:0]));
//
//asm_S2QED_SAME_VAL_sec_1: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12],cpu0_inst[3:1]}==7'b0000001, {cpu0_inst[15:12],cpu0_inst[7:0]}, {cpu1_inst[15:12],cpu1_inst[7:0]}));
//
//asm_S2QED_SAME_VAL_sec_2: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12],cpu0_inst[3:2]}==6'b000001, {cpu0_inst[15:12],cpu0_inst[3:0]}, {cpu1_inst[15:12],cpu1_inst[3:0]}));
//
//asm_S2QED_SAME_VAL_sec_3a: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12],cpu0_inst[3:2]}==6'b000010, {cpu0_inst[15:12],cpu0_inst[7:0]}, {cpu1_inst[15:12],cpu1_inst[7:0]}));
//asm_S2QED_SAME_VAL_sec_3b: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12],cpu0_inst[5],cpu0_inst[3:0]}==9'b000001001, cpu0_inst[11:8],cpu1_inst[11:8]));
//asm_S2QED_SAME_VAL_sec_3c: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12],cpu0_inst[3:2],cpu0_inst[1:0]}==8'b00001011, cpu0_inst[11:8],cpu1_inst[11:8]));
//
//asm_S2QED_SAME_VAL_sec_4a: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12],cpu0_inst[3:2]}==6'b000011, {cpu0_inst[15:12],cpu0_inst[3:0]}, {cpu1_inst[15:12],cpu1_inst[3:0]}));
//asm_S2QED_SAME_VAL_sec_4b: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12]}==4'b0001, {cpu0_inst[15:12],cpu0_inst[3:0]}, {cpu1_inst[15:12],cpu1_inst[3:0]}));
//asm_S2QED_SAME_VAL_sec_4c: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:13]}==3'b001, {cpu0_inst[15:12],cpu0_inst[3:0]}, {cpu1_inst[15:12],cpu1_inst[3:0]}));
//
//asm_S2QED_SAME_VAL_sec_5a: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12]}==4'b0100 && cpu0_inst[3:0]!=4'b1111, {cpu0_inst[15:12],cpu0_inst[7:0]}, {cpu1_inst[15:12],cpu1_inst[7:0]}));
//asm_S2QED_SAME_VAL_sec_5b: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12]}==4'b0100 && cpu0_inst[3:0]==4'b1111, {cpu0_inst[15:12],cpu0_inst[3:0]}, {cpu1_inst[15:12],cpu1_inst[3:0]}));
//
//asm_S2QED_SAME_VAL_sec_6a: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12]}==4'b0101, {cpu0_inst[15:12],cpu0_inst[3:0]}, {cpu1_inst[15:12],cpu1_inst[3:0]}));
//asm_S2QED_SAME_VAL_sec_6b: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12]}==4'b0110, {cpu0_inst[15:12],cpu0_inst[3:0]}, {cpu1_inst[15:12],cpu1_inst[3:0]}));
//
//asm_S2QED_SAME_VAL_sec_7: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12]}==4'b0111, {cpu0_inst[15:12],cpu0_inst[7:0]}, {cpu1_inst[15:12],cpu1_inst[7:0]}));
//
//asm_S2QED_SAME_VAL_sec_8a: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:11]}==5'b10000, {cpu0_inst[15:8],cpu0_inst[3:0]}, {cpu1_inst[15:8],cpu1_inst[3:0]}));
//asm_S2QED_SAME_VAL_sec_8b: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:11]}==5'b10001, cpu0_inst, cpu1_inst));
//
//asm_S2QED_SAME_VAL_sec_9: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:12]}==4'b1001, {cpu0_inst[15:12],cpu0_inst[7:0]}, {cpu1_inst[15:12],cpu1_inst[7:0]}));
//
//asm_S2QED_SAME_VAL_sec_10: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:13]}==3'b101, cpu0_inst, cpu1_inst));
//
//asm_S2QED_SAME_VAL_sec_11: assume property(p_S2QED_SAME_VAL_W_COND({cpu0_inst[15:14]}==2'b11, cpu0_inst, cpu1_inst));


// Do register mapping
//REG_MAPPING:asm_S2QED_SAME_VAL_mapped_registers_x: assume property(p_S2QED_SAME_VAL(cpu0_regnum_x, reg_map(cpu1_regnum_x))); 
//REG_MAPPING:asm_S2QED_SAME_VAL_mapped_registers_y: assume property(p_S2QED_SAME_VAL(cpu0_regnum_y, reg_map(cpu1_regnum_y)));
//REG_MAPPING:asm_S2QED_SAME_VAL_mapped_registers_z: assume property(p_S2QED_SAME_VAL(cpu0_regnum_z, reg_map(cpu1_regnum_z)));
//REG_MAPPING:asm_S2QED_SAME_VAL_mapped_registers_w: assume property(p_S2QED_SAME_VAL(cpu0_regnum_w, reg_map(cpu1_regnum_w)));

//asm_S2QED_SAME_VAL_mapped_registers_x: assume property(p_S2QED_SAME_VAL(cpu0_regnum_x, cpu1_regnum_x)); 
//asm_S2QED_SAME_VAL_mapped_registers_y: assume property(p_S2QED_SAME_VAL(cpu0_regnum_y, cpu1_regnum_y));
//asm_S2QED_SAME_VAL_mapped_registers_z: assume property(p_S2QED_SAME_VAL(cpu0_regnum_z, cpu1_regnum_z));
//asm_S2QED_SAME_VAL_mapped_registers_w: assume property(p_S2QED_SAME_VAL(cpu0_regnum_w, cpu1_regnum_w));

// For Fetch Stage
asm_S2QED_SAME_VAL_fetch_inst_ready: assume property(p_S2QED_SAME_VAL(cpu0_fetch_inst_ready, cpu0_fetch_inst_ready));
asm_S2QED_SAME_VAL_inst_same: assume property(p_S2QED_SAME_VAL(cpu0_inst, cpu1_inst));


// For Write Back Stage Assumptions
reg wb_rose;
always @(posedge clk) begin
    wb_rose = $rose(cpu0_wrreg_w) || $rose(cpu0_wrreg_z) || $rose(cpu0_wrmach) || $rose(cpu0_wrmacl); 
end

// Write Back at same time 
asm_S2QED_SAME_VAL_MEM_WB_SIG: assume property(p_S2QED_SAME_VAL(cpu0_wrreg_w, cpu1_wrreg_w));
asm_S2QED_SAME_VAL_ALU_WB_SIG: assume property(p_S2QED_SAME_VAL(cpu0_wrreg_z, cpu1_wrreg_z));
asm_S2QED_SAME_VAL_MACH_WB_SIG: assume property(p_S2QED_SAME_VAL(cpu0_wrmach, cpu1_wrmach));
asm_S2QED_SAME_VAL_MACL_WB_SIG: assume property(p_S2QED_SAME_VAL(cpu0_wrmacl, cpu1_wrmacl));

// 1 cycle before write back, all registers (General, MUL, Special) must be the same
asm_S2QED_SAME_VAL_W_COND_MEM_WB_REG: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, $past(cpu0_reg), $past(cpu1_reg)));
asm_S2QED_SAME_VAL_W_COND_MACH_WB_REG: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, $past(cpu0_mach), $past(cpu1_mach)));
asm_S2QED_SAME_VAL_W_COND_MACL_WB_REG: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, $past(cpu0_macl), $past(cpu1_macl)));
asm_S2QED_SAME_VAL_W_COND_sr: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_sr, cpu1_sr));
asm_S2QED_SAME_VAL_W_COND_gbr: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_gbr, cpu1_gbr));
asm_S2QED_SAME_VAL_W_COND_vbr: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_vbr, cpu1_vbr));
asm_S2QED_SAME_VAL_W_COND_pr: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_pr, cpu1_pr));
asm_S2QED_SAME_VAL_W_COND_pc: assume property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_pc, cpu1_pc));

//    ast_S2QED_SAME_VAL_W_COND_reg_diff_x: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_reg[i], cpu1_reg[reg_map(i)]));
//    ast_S2QED_SAME_VAL_W_COND_reg_diff_z: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_reg[i], cpu1_reg[reg_map(i)]));

//generate
//for (genvar i = 0; i < 16; i++) begin
//    ast_S2QED_SAME_VAL_W_COND_reg_diff_x: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_reg[i], cpu1_reg[i]));
//    ast_S2QED_SAME_VAL_W_COND_reg_diff_z: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_reg[i], cpu1_reg[i]));
//
//end
//endgenerate

// Assert for Memory and ALU WB with general register remapping
ast_S2QED_SAME_VAL_W_COND_reg_diff_x: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_reg, cpu1_reg));
ast_S2QED_SAME_VAL_W_COND_reg_diff_z: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_reg, cpu1_reg));

// Assert for Mult 
ast_S2QED_SAME_VAL_W_COND_mach_diff_x: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_mach, cpu1_mach));
ast_S2QED_SAME_VAL_W_COND_macl_diff_x: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_macl, cpu1_macl));

// Assert for Special 
ast_S2QED_SAME_VAL_W_COND_sr_diff: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_sr, cpu1_sr));
ast_S2QED_SAME_VAL_W_COND_gbr_diff:assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_gbr, cpu1_gbr));
ast_S2QED_SAME_VAL_W_COND_vbr_diff:assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_vbr, cpu1_vbr));
ast_S2QED_SAME_VAL_W_COND_pr_diff: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_pr, cpu1_pr));
ast_S2QED_SAME_VAL_W_COND_pc_diff: assert property(p_S2QED_SAME_VAL_W_COND(wb_rose, cpu0_pc, cpu1_pc));



// Assume for Mult 31*16 need to specify because black boxing multiplier
//asm_S2QED_SAME_VAL_W_COND_abh_same: assume property(p_S2QED_SAME_VAL_W_COND((cpu0_ah == cpu1_ah && cpu0_bh == cpu1_bh), cpu0_abh, cpu1_abh)); // using unblacked box

endmodule

module Wrapper;

bind S2QED_top s2qed S2QED_BIND(
    .clk(CLK),
    .rst(RST),
    .cpu0_fetch_inst_ready(cpu0.MEM.IF_STATE == `S_IFEX),
    .cpu1_fetch_inst_ready(cpu1.MEM.IF_STATE == `S_IFEX),
    .cpu0_inst(cpu0.IF_DR),
    .cpu1_inst(cpu1.IF_DR),
    .cpu0_reg(cpu0.DATAPATH.REGISTER.REG),
    .cpu1_reg(cpu1.DATAPATH.REGISTER.REG),
    .cpu0_sr(cpu0.DATAPATH.SR),
    .cpu1_sr(cpu1.DATAPATH.SR),
    .cpu0_gbr(cpu0.DATAPATH.GBR),
    .cpu1_gbr(cpu1.DATAPATH.GBR),
    .cpu0_vbr(cpu0.DATAPATH.VBR),
    .cpu1_vbr(cpu1.DATAPATH.VBR),
    .cpu0_pr(cpu0.DATAPATH.PR),
    .cpu1_pr(cpu1.DATAPATH.PR),
    .cpu0_pc(cpu0.DATAPATH.PC),
    .cpu1_pc(cpu1.DATAPATH.PC),
    .cpu0_mach(cpu0.MULT.MACH),    
    .cpu1_mach(cpu1.MULT.MACH),
    .cpu0_macl(cpu0.MULT.MACL),
    .cpu1_macl(cpu1.MULT.MACL),
    .cpu0_wrreg_w(cpu0.WRREG_W),
    .cpu1_wrreg_w(cpu1.WRREG_W),
    .cpu0_wrreg_z(cpu0.WRREG_Z),
    .cpu1_wrreg_z(cpu1.WRREG_Z),
    .cpu0_wrmach(cpu0.MULT.WRMACH),
    .cpu1_wrmach(cpu1.MULT.WRMACH),
    .cpu0_wrmacl(cpu0.MULT.WRMACL),
    .cpu1_wrmacl(cpu1.MULT.WRMACL),
    .cpu0_regnum_x(cpu0.DECODE.REGNUM_X),
    .cpu1_regnum_x(cpu1.DECODE.REGNUM_X),
    .cpu0_regnum_y(cpu0.DECODE.REGNUM_Y),
    .cpu1_regnum_y(cpu1.DECODE.REGNUM_Y),
    .cpu0_regnum_z(cpu0.DECODE.REGNUM_Z),
    .cpu1_regnum_z(cpu1.DECODE.REGNUM_Z),
    .cpu0_regnum_w(cpu0.DECODE.REGNUM_W),
    .cpu1_regnum_w(cpu1.DECODE.REGNUM_W)
);

endmodule //Wrapper


