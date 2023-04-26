`timescale 1 ps / 1 ps

module sub_test();

reg clock = 1'b1;
wire [15:0] out;
wire [5:0] op_code, func;
wire [2:0] alu_op;
wire [31:0] instruction;
wire [15:0] reg_data_out [1:0];
wire mem_to_reg,
	  mem_write_en,
	  reg_write_en,
	  alu_reset,
	  imm_sl,
	  br_sl,
	  breq_sl,
	  reg_dest,
	  jump_sl,
	  jump_reg_sl,
	  //is_zero,
	  instr_stall_sl,
	  ready,
	  hi_lo_sl;

always begin
	#1
	clock = ~clock;
end

initial @ (*) begin
	$readmemb("C:/Users/anasa/Documents/Quartus/Final_project/test_benches/sub/sub_test.mem", mu_pc.d1.instruction_registers.register);

	#5
	$display("The value in register 1 is: %d\nThe value in register 2 is: %d\nThe value in register 3 (before assignment) is: %d\n", mu_pc.d1.data_registers.register[1], mu_pc.d1.data_registers.register[2], mu_pc.d1.data_registers.register[3]);
	$monitor("The value in register 3 ($1 - $2) is: %d\nfinished after %d cycles\n", mu_pc.d1.data_registers.register[3], $time/2 - 2);
end

mips16_sc mu_pc(
	.clock(clock),
	.out(out),
	.op_code_out(op_code), 
	.func_out(func),
	.alu_op_out(alu_op),
	.instruction(instruction),
	.mem_to_reg_out(mem_to_reg),
	.mem_write_en_out(mem_write_en),
	.reg_write_en_out(reg_write_en),
	.alu_reset_out(alu_reset),
	.imm_sl_out(imm_sl),
	.br_sl_out(br_sl),
	.breq_sl_out(breq_sl),
	.reg_dest_out(reg_dest),
	.jump_sl_out(jump_sl),
	.jump_reg_sl_out(jump_reg_sl),
	.reg_data_out_a(reg_data_out[0]),
	.reg_data_out_b(reg_data_out[1]),
	//.is_zero_out(is_zero),
	.instr_stall_sl_out(instr_stall_sl),
	.ready_out(ready),
	.hi_lo_sl_out(hi_lo_sl)
);

endmodule