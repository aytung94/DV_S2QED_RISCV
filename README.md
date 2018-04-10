# DV_S2QED_RISCV
Team: 
William Glanton (wtg296)
Alvin Tung (ayt243)

Topic:
Verification of RISC-V Processor Core(s) using S2QED.

Outline:

We will be reimplementing the work with a different processor from the paper Symbolic Quick Error Detection Using Symbolic Initial State for Pre-Silicon Verification. We will use the method described in the paper to verify an open RISC-V core called mriscv. We will use jaspergold as our formal verification tool. We will write verilog to instantiate two processors and connect them too a module with formal assertions and assumptions based on the S2QED method.

S2QED combines the Symbolic Quick Error Detection (SQED) method running the Error Detection using Duplicate Instruction for Validation test (EDDI-V) and a freely chosen initial state by the Bounded Model Checker (BMC). It works by creating two instances of the processor, instantiates both to different initial states, and runs the same instruction on both cores but with a transformation of the register space on one. This method due to the BMC should set the initial states to activate a bug if it exists and produce a counterexample in the formal tool. 	

For instance, 1 processor may do an operation on R0 while the other processor does an equivalent operation on R15. The result of the operation regardless should be the same. However, the symbolic tool will find a counterexample, if a bug exists, and set the initial states of both cores, except for the registers, that will cause the R0 to be inconsistent with R15. We can then trace back the counterexamples to find the bug.

Relevant Sources:
https://www.date-conference.com/conference/session/2.4 (see Abraham for paper)
https://github.com/onchipuis/mriscvcore

Deliverables:

RTL code of the two cores.
Formal verification code.
Test cripts.
Text of found bugs and solutions. 
Fixed RTL Code.

