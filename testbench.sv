module testbench();

	logic clk, reset;

	logic hazard_signal_hazard_output, jump_signal_ifid_input, memToReg_signal_idEx_input, regWrite_signal_idEx_input, memWrite_signal_idEx_input, memRead_signal_idEx_input, aluSrc_signal_idEx_input, regDst_signal_idEx_input, memToReg_signal_idEx_output, regWrite_signal_idEx_output, memWrite_signal_idEx_output, memRead_idEx_output, aluSrc_signal_idEx_output, regDst_signal_idEx_output, memToReg_exMem_input, regWrite_exMem_input, memWrite_exMem_input, memRead_exMem_input, memToReg_exMem_output, regWrite_exMem_output, memWrite_exMem_output, memRead_exMem_output, memToReg_memWb_input, regWrite_memWb_input, memToReg_memWb_output, regWrite_memWb_output, branchControl_exMem_input;

	logic [1:0] forwardingMux0Ex, forwardingMux1Ex, branch_signal_idEx_input, branch_signal_idEx_output;

	logic [3:0] aluOp_idEx_input, aluOp_idEx_output;

	logic [4:0] rs_address_idEx_input, rt_address_idEx_input, rd_address_idEx_input, rs_address_idEx_output, rt_address_idEx_output, rd_address_idEx_output, regWrite_address_exMem_input, regWriteRegister_exMem_output, regWriteAddress_memWb_input, regWriteAddress_memWb_output;

	logic [5:0] func_idEx_input, func_idEx_output;

	logic [31:0] pcBranch_exMem_input, pcJump_signal_ifid_input, instruction_ifId_input, pc_ifId_input, instruction_ifId_output, pc_ifId_output, writeData_writeBack_output, immediateExtended_data_idEx_input, rs_data_idEx_input, rt_data_idEx_input, immediateExtended_data_idEx_output, rs_data_idEx_output, rt_data_idEx_output, aluResult_exMem_input, memWrite_data_exMem_input, aluResult_exMem_output, dataMemory_memWb_input, memWrite_data_exMem_output, aluResult_memWb_input, dataMemory_memWb_output, aluResult_memWb_output, pc4_idEx_input, pc4_idEx_output;

    always begin
		clk<= 1; #1;
		clk<=0; #1;
	end

    initial begin
		$dumpfile("mips.vcd");
      	$dumpvars(0, testbench);
        reset<=1; #3;
		reset<=0; #1;
	end

	hazard hazard0 (memRead_idEx_output, rs_address_idEx_input, rt_address_idEx_input, regWrite_address_exMem_input, hazard_signal_hazard_output);
	forward forward0 (rs_address_idEx_output, rt_address_idEx_output, regWrite_exMem_output, regWriteAddress_memWb_input, regWrite_memWb_output, regWriteAddress_memWb_output, forwardingMux0Ex, forwardingMux1Ex);

	instructionFetch instructionFetch0 (clk, reset, hazard_signal_hazard_output, branchControl_exMem_input, pcBranch_exMem_input, jump_signal_ifid_input, pcJump_signal_ifid_input, instruction_ifId_input, pc_ifId_input);
	if_id if_id0 (clk, reset, hazard_signal_hazard_output, branchControl_exMem_input, jump_signal_ifid_input, pc_ifId_input, instruction_ifId_input, pc_ifId_output, instruction_ifId_output);
	instructionDecode instructionDecode0 (clk, reset, instruction_ifId_output, pc_ifId_output, regWrite_memWb_output, regWriteAddress_memWb_output, writeData_writeBack_output, pc4_idEx_input, memToReg_signal_idEx_input, regWrite_signal_idEx_input, memWrite_signal_idEx_input, memRead_signal_idEx_input, aluOp_idEx_input, aluSrc_signal_idEx_input, regDst_signal_idEx_input, branch_signal_idEx_input, immediateExtended_data_idEx_input, rs_address_idEx_input, rt_address_idEx_input, rd_address_idEx_input, rs_data_idEx_input, rt_data_idEx_input, jump_signal_ifid_input, pcJump_signal_ifid_input, func_idEx_input);
	id_ex id_ex0 (clk, reset, hazard_signal_hazard_output, branchControl_exMem_input, pc4_idEx_input, memToReg_signal_idEx_input, regWrite_signal_idEx_input, memWrite_signal_idEx_input, memRead_signal_idEx_input, aluOp_idEx_input, aluSrc_signal_idEx_input, regDst_signal_idEx_input, branch_signal_idEx_input, immediateExtended_data_idEx_input, rs_address_idEx_input, rt_address_idEx_input, rd_address_idEx_input, rs_data_idEx_input, rt_data_idEx_input, func_idEx_input, pc4_idEx_output, memToReg_signal_idEx_output, regWrite_signal_idEx_output, memWrite_signal_idEx_output, memRead_idEx_output, aluOp_idEx_output, aluSrc_signal_idEx_output, regDst_signal_idEx_output, branch_signal_idEx_output, immediateExtended_data_idEx_output, rs_address_idEx_output, rt_address_idEx_output, rd_address_idEx_output, rs_data_idEx_output, rt_data_idEx_output, func_idEx_output);    
	executing executing0 (clk, reset, pc4_idEx_output, memToReg_signal_idEx_output, regWrite_signal_idEx_output, memWrite_signal_idEx_output, memRead_idEx_output, aluOp_idEx_output, aluSrc_signal_idEx_output, regDst_signal_idEx_output, branch_signal_idEx_output, immediateExtended_data_idEx_output, rs_address_idEx_output, rt_address_idEx_output, rd_address_idEx_output, rs_data_idEx_output, rt_data_idEx_output, func_idEx_output, forwardingMux0Ex, forwardingMux1Ex, writeData_writeBack_output, aluResult_exMem_output, memToReg_exMem_input, regWrite_exMem_input, memWrite_exMem_input, memRead_exMem_input, aluResult_exMem_input, memWrite_data_exMem_input, regWrite_address_exMem_input, branchControl_exMem_input, pcBranch_exMem_input);
	ex_mem ex_mem0 (clk, reset, memToReg_exMem_input, regWrite_exMem_input, memWrite_exMem_input, memRead_exMem_input, aluResult_exMem_input, memWrite_data_exMem_input, regWrite_address_exMem_input, memToReg_exMem_output, regWrite_exMem_output, memWrite_exMem_output, memRead_exMem_output, aluResult_exMem_output, memWrite_data_exMem_output, regWriteRegister_exMem_output);
	memory memory0 (clk, reset, memToReg_exMem_output, regWrite_exMem_output, memWrite_exMem_output, memRead_exMem_output, aluResult_exMem_output, memWrite_data_exMem_output, regWriteRegister_exMem_output, memToReg_memWb_input, regWrite_memWb_input, dataMemory_memWb_input, aluResult_memWb_input, regWriteAddress_memWb_input);
	mem_wb mem_wb0 (clk, reset, memToReg_memWb_input, regWrite_memWb_input, dataMemory_memWb_input, aluResult_memWb_input, regWriteAddress_memWb_input, memToReg_memWb_output, regWrite_memWb_output, dataMemory_memWb_output, aluResult_memWb_output, regWriteAddress_memWb_output);
	writeBack writeBack0 (memToReg_memWb_output, aluResult_memWb_output, dataMemory_memWb_output, writeData_writeBack_output);

endmodule