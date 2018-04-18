//EE382M-Verification of Digital Systems
//Lab 4 - Formal Property Verification
//
//
//Modules - apb_props and Wrapper
//SystemVerilog Properties for the module - arbiter_top

module s2qed(
  input clk,
  input rstn,
  input [31:0] cpu0_inst,
  input [31:0] cpu1_inst,
  input [31:0] cpu0_reg[31:0],
  input [31:0] cpu1_reg[31:0],
  input [3:0] cpu0_state,
  input [3:0] cpu1_state
);
parameter S0_fetch = 0, S4_trap = 4;

// ASSUMPTIONS
property p_S2QED_SAME_INST();
	@(posedge clk) 
	cpu0_inst == cpu1_inst;
endproperty
asm_S2QED_SAME_INST: assume property(p_S2QED_SAME_INST());

property p_S2QED_SAME_STATE();
	@(posedge clk)
	cpu0_state == cpu1_state;	
endproperty
// not sure if this should be assumed or asserted? should only be true after reset?
asm_S2QED_SAME_STATE: assume property(p_S2QED_SAME_STATE());

// ASSERTIONS
property p_S2QED_SAME_REG_N_STATE(state);//, num);
	@(posedge clk)
	((cpu0_state == cpu1_state) && (cpu0_state == state)) -> cpu0_reg == cpu1_reg;
endproperty //s2qed
asm_S2QED_SAME_REG_N_STATE: assume property(p_S2QED_SAME_REG_N_STATE(S0_fetch));
ast_S2QED_SAME_REG_N_STATE: assert property(p_S2QED_SAME_REG_N_STATE(S4_trap));

endmodule

module Wrapper;

bind mriscvcore_top_s2qed s2qed S2QED_BIND(
  .clk(clk),
  .rstn(rstn),
  .cpu0_inst(mriscvcore_inst0.MEMORY_INTERFACE_inst.inst),
  .cpu1_inst(mriscvcore_inst1.MEMORY_INTERFACE_inst.inst),
  .cpu0_reg(mriscvcore_inst0.REG_FILE_inst.MEM_FILE.ram),
  .cpu1_reg(mriscvcore_inst1.REG_FILE_inst.MEM_FILE.ram),
  .cpu0_state(mriscvcore_inst0.FSM_inst.state),
  .cpu1_state(mriscvcore_inst1.FSM_inst.state)
 );

endmodule //Wrapper

//module apb_props(
//// APB interface
//input        PCLK,
//input        PRESETn,
//input        PWRITE,
//input        PSEL,
//input        PENABLE,
//input  [7:0] PADDR,
//input  [7:0] PWDATA,
//
//input  [7:0] PRDATA,
//input        PREADY,
//// APB registers
//input        APB_BYPASS,
//input  [3:0] APB_REQ,
//input  [2:0] APB_ARB_TYPE,
//// Arbiter ports
//input  [3:0] REQ,
//input  [3:0] GNT
//);
//
////Write APB interface properties here - assertions, cover properties and assume properties
//
//// Assumptions
//property APBValidPrecedent(current_PSEL_PENABLE, prev_PSEL_PENABLE);
//	@(posedge PCLK)
//	{PSEL,PENABLE} == current_PSEL_PENABLE |-> {$past(PSEL),$past(PENABLE)} == prev_PSEL_PENABLE;
//endproperty
//property APBValidTransition(current_PSEL_PENABLE, next_PSEL_PENABLE);
//	@(posedge PCLK)
//	{PSEL,PENABLE} == current_PSEL_PENABLE |=> {PSEL, PENABLE} == next_PSEL_PENABLE;
//endproperty
//
//APBPhase1Precedent: assume property(APBValidPrecedent(2'b10, 2'b00));
//APBPhase1Transition: assume property(APBValidTransition(2'b10, 2'b11));
//APBPhase2Transition: assume property(APBValidTransition(2'b11, 2'b00));
//
//property APBStableTransfer(antecedent, consequent);
//	@(posedge PCLK)
//	antecedent |=> $stable(consequent);
//endproperty
//
//APBStablePADDR: assume property(APBStableTransfer(PSEL, PADDR));
//APBStablePWRITE: assume property(APBStableTransfer(PSEL, PWRITE));
//APBStablePWDATA: assume property(APBStableTransfer(PSEL && PWRITE, PWDATA));
//
//APBLegalPADDR: assume property(
//	@(posedge PCLK) 
//	PSEL |-> (PADDR==8'h10 || PADDR==8'h14 || PADDR==8'h1C)
//);
//
//APBLegalPWDATA: assume property(
//	@(posedge PCLK)
//	(PSEL==1'b1 && PWRITE==1'b1) |-> ((PADDR==8'h10 && !$isunknown(PWDATA[0]) && PWDATA[7:1]==7'h00) ||
//					 (PADDR==8'h14 && !$isunknown(PWDATA[3:0]) && PWDATA[7:4]==4'h0) ||
//					 (PADDR==8'h1c && !$isunknown(PWDATA[2:0]) && PWDATA[7:3]==5'h00))
//);
//
//
//// Assertions
//property APBCorrectOperationW(w_or_r, data);
//	@(posedge PCLK) disable iff(!PRESETn)
//	(PSEL && PREADY && w_or_r) |=> (($past(PADDR==8'h10) && data[0]==APB_BYPASS) || 
//					($past(PADDR==8'h14) && data[3:0]==APB_REQ) ||  
//					($past(PADDR==8'h1c) && data[2:0]==APB_ARB_TYPE));
//endproperty
//property APBCorrectOperationR(w_or_r, data);
//	@(posedge PCLK) disable iff(!PRESETn)
//	(PSEL && PREADY && w_or_r) |-> ((PADDR==8'h10 && data[0]==APB_BYPASS) || 
//					(PADDR==8'h14 && data[3:0]==APB_REQ) ||  
//					(PADDR==8'h1c && data[2:0]==APB_ARB_TYPE));
//endproperty
//
//APBWriteOperation: assert property(APBCorrectOperationW(PWRITE, PWDATA));
//APBReadOperation: assert property(APBCorrectOperationR(!PWRITE, PRDATA));
//
//APBReset: assert property(
//	@(posedge PCLK) disable iff(!PRESETn) 
//	$rose(PRESETn) |-> (APB_BYPASS==1'b0 && APB_REQ==4'b0000 && APB_ARB_TYPE==3'b100)
//);
//
//// Coverage
//property APBOperationOccured(w_or_r);
//	@(posedge PCLK) disable iff(!PRESETn)
//	PSEL && PENABLE && w_or_r;
//endproperty
//
//APBWriteOccured: cover property(APBOperationOccured(PWRITE));
//APBReadOccured: cover property(APBOperationOccured(!PWRITE));
//
//endmodule
//
//module arb_props (
//  clk,
//  rst_n,
//  req,
//  arb_type,
//  gnt
//  );
//
//input        clk;
//input        rst_n;
//input  [3:0] req;
//input  [2:0] arb_type;
//
//input  [3:0] gnt;
//
////Write arbiter properties here - assertions, cover properties and assume properties
//
//property ARBReqHold(num);
//	@(posedge clk)
//	$fell(req[num]) |-> $rose(gnt[num]);
//endproperty
//
//ARBReqHold0: assume property(ARBReqHold(0)); 
//ARBReqHold1: assume property(ARBReqHold(1)); 
//ARBReqHold2: assume property(ARBReqHold(2)); 
//ARBReqHold3: assume property(ARBReqHold(3)); 
//
//property ARBGntMutex(num);
//	@(posedge clk) disable iff(!rst_n)
//	$rose(gnt[num]) |-> $past(req[num],1) && !gnt[(num+1)%4] && !gnt[(num+2)%4] && !gnt[(num+3)%4];
//endproperty
//
//ARBGntMutex0: assert property(ARBGntMutex(0));
//ARBGntMutex1: assert property(ARBGntMutex(1));
//ARBGntMutex2: assert property(ARBGntMutex(2));
//ARBGntMutex3: assert property(ARBGntMutex(3));
//
//property ARBPriorityCorrect(act_arb_type, num, exp_arb_type, pri3, pri2, pri1, pri0);
//	@(posedge clk) disable iff(!rst_n)
//	$rose(gnt[num]) && $past(act_arb_type==exp_arb_type) |-> $past((pri3==num) || 
//		  						       (!req[pri3] && (pri2==num)) || 
//								       (!req[pri3] && !req[pri2] && (pri1==num)) || 
//				    				       (!req[pri3] && !req[pri2] && !req[pri1] && (pri0==num)));
//endproperty
//
//ARBCorrectP0G0: assert property(ARBPriorityCorrect(arb_type, 0, 3'h0, 0, 1, 2, 3));
//ARBCorrectP0G1: assert property(ARBPriorityCorrect(arb_type, 1, 3'h0, 0, 1, 2, 3));
//ARBCorrectP0G2: assert property(ARBPriorityCorrect(arb_type, 2, 3'h0, 0, 1, 2, 3));
//ARBCorrectP0G3: assert property(ARBPriorityCorrect(arb_type, 3, 3'h0, 0, 1, 2, 3));
//
//ARBCorrectP1G0: assert property(ARBPriorityCorrect(arb_type, 0, 3'h1, 1, 0, 2, 3));
//ARBCorrectP1G1: assert property(ARBPriorityCorrect(arb_type, 1, 3'h1, 1, 0, 2, 3));
//ARBCorrectP1G2: assert property(ARBPriorityCorrect(arb_type, 2, 3'h1, 1, 0, 2, 3));
//ARBCorrectP1G3: assert property(ARBPriorityCorrect(arb_type, 3, 3'h1, 1, 0, 2, 3));
//
//ARBCorrectP2G0: assert property(ARBPriorityCorrect(arb_type, 0, 3'h2, 2, 0, 1, 3));
//ARBCorrectP2G1: assert property(ARBPriorityCorrect(arb_type, 1, 3'h2, 2, 0, 1, 3));
//ARBCorrectP2G2: assert property(ARBPriorityCorrect(arb_type, 2, 3'h2, 2, 0, 1, 3));
//ARBCorrectP2G3: assert property(ARBPriorityCorrect(arb_type, 3, 3'h2, 2, 0, 1, 3));
//
//ARBCorrectP3G0: assert property(ARBPriorityCorrect(arb_type, 0, 3'h3, 3, 0, 1, 2));
//ARBCorrectP3G1: assert property(ARBPriorityCorrect(arb_type, 1, 3'h3, 3, 0, 1, 2));
//ARBCorrectP3G2: assert property(ARBPriorityCorrect(arb_type, 2, 3'h3, 3, 0, 1, 2));
//ARBCorrectP3G3: assert property(ARBPriorityCorrect(arb_type, 3, 3'h3, 3, 0, 1, 2));
//
//property ARBPriorityLiveness(act_arb_type, num, exp_arb_type, n_cycles);
//	@(posedge clk) disable iff(!rst_n)
//	$rose(req[num]) && (act_arb_type==exp_arb_type) |-> ##[0:n_cycles] (gnt[num] || !$stable(act_arb_type==exp_arb_type)) ; 
//endproperty
//
//ARBPriorityP4G0: assert property(ARBPriorityLiveness(arb_type, 0, 3'h4, 4));
//ARBPriorityP4G1: assert property(ARBPriorityLiveness(arb_type, 1, 3'h4, 4));
//ARBPriorityP4G2: assert property(ARBPriorityLiveness(arb_type, 2, 3'h4, 4));
//ARBPriorityP4G3: assert property(ARBPriorityLiveness(arb_type, 3, 3'h4, 4));
//
//ARBPriorityP5G0: assert property(ARBPriorityLiveness(arb_type, 0, 3'h5, 7));
//ARBPriorityP5G1: assert property(ARBPriorityLiveness(arb_type, 1, 3'h5, 7));
//ARBPriorityP5G2: assert property(ARBPriorityLiveness(arb_type, 2, 3'h5, 7));
//ARBPriorityP5G3: assert property(ARBPriorityLiveness(arb_type, 3, 3'h5, 7));
//
//property ARBGoesHigh(A); 
//	@(posedge clk) disable iff(!rst_n)
//	A;
//endproperty
//
//ARBReq0Hi: cover property(ARBGoesHigh(req[0]));
//ARBReq1Hi: cover property(ARBGoesHigh(req[1]));
//ARBReq2Hi: cover property(ARBGoesHigh(req[2]));
//ARBReq3Hi: cover property(ARBGoesHigh(req[3]));
//
//ARBGnt0Hi: cover property(ARBGoesHigh(gnt[0]));
//ARBGnt1Hi: cover property(ARBGoesHigh(gnt[1]));
//ARBGnt2Hi: cover property(ARBGoesHigh(gnt[2]));
//ARBGnt3Hi: cover property(ARBGoesHigh(gnt[3]));
//
//endmodule
//
//module Wrapper;
//
////Bind the 'apb_props' module with the 'arbiter_top' module to instantiate the properties
//
//bind arbiter_top apb_props APB_BIND (.PCLK(PCLK), .PRESETn(PRESETn), .PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE), .PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .APB_BYPASS(APB_BYPASS), .APB_REQ(APB_REQ), .APB_ARB_TYPE(APB_ARB_TYPE), .REQ(REQ), .GNT(GNT));
//
////Bind the 'arb_props' module with the 'arbiter' module to instantiate the properties
//
//bind arbiter arb_props ARB_BIND(.clk(clk),
//  .rst_n(rst_n),
//  .req(req),
//  .arb_type(arb_type),
//  .gnt(gnt)
// );
//
//endmodule
