
`include "rv32_opcodes.v"

module qed_properties(
    input reg [31:0] cpu0_inst,
    input reg [31:0] cpu1_inst
);
    
    wire cpu0_opcode;
    wire cpu1_opcode;
    wire cpu0_funct7;
    wire cpu1_funct7;
    wire cpu0_funct3;
    wire cpu1_funct3;

    wire cpu0_imm12;
    wire cpu1_imm12;

    

    assign cpu0_opcode = cpu0_inst[6:0];
    assign cpu1_opcode = cpu1_inst[6:0];
    assign cpu0_funct7 = cpu0_inst[31:25];
    assign cpu1_funct7 = cpu1_inst[31:25];
    assign cpu0_funct3 = cpu0_inst[14:12];
    assign cpu1_funct3 = cpu1_inst[14:12];


    property equal_to(ina, inb);
        ina == inb;
    endproperty
    
    property conditioned_equal_to(cond, ina, inb);
        cond -> ina == inb;
    endproperty

    property allow_opcodes(opcode);
        opcode == `RV32_OP      ||
        opcode == `RV32_OP_IMM;
    endproperty

    property funct7_limit_0(op,f3,f7);
        (op == `RV32_OP_IMM && f3 == `RV32_FUNCT3_SLL) ||
        (op == `RV32_OP &&
        (f3 == `RV32_FUNCT3_SLL || f3 == `RV32_FUNCT3_SLT || f3 == `RV32_FUNCT3_SLTU || f3 == `RV32_FUNCT3_XOR || f3 == `RV32_FUNCT3_OR || f3 == `RV32_FUNCT3_AND))
        ->
        (f7 == 0);
    endproperty

    cpus_have_same_funct3  : assume property(equal_to(cpu0_funct3, cpu1_funct3));
    cpus_have_same_funct7  : assume property(conditioned_equal_to(cpu0_opcode == `RV32_OP, cpu0_funct7, cpu1_funct7));
    cpus_have_same_opcodes : assume property(equal_to(cpu0_opcode,cpu1_opcode));
endmodule

