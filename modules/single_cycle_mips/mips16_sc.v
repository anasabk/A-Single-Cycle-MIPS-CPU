module mips16_sc(
	input clock,
	output [15:0] out,
	output [5:0] op_code_out, func_out,
	output [2:0] alu_op_out,
	output [31:0] instruction,
	output [15:0] reg_data_out_a, reg_data_out_b,
	output mem_to_reg_out,
			 mem_write_en_out,
			 reg_write_en_out,
			 alu_reset_out,
			 imm_sl_out,
			 br_sl_out,
			 breq_sl_out,
			 reg_dest_out,
			 jump_sl_out,
			 jump_reg_sl_out,
			 instr_stall_sl_out,
			 ready_out,
			 hi_lo_sl_out
);

wire [5:0] op_code;
wire [5:0] func;
wire [2:0] alu_op;
wire mem_to_reg;
wire mem_write_en;
wire reg_write_en;
wire alu_reset;
wire imm_sl;
wire br_sl;
wire breq_sl;
wire reg_dest;
wire jump_sl;
wire jump_reg_sl;
wire instr_stall_sl;
wire hi_lo_sl;
wire ready;


assign alu_op_out = alu_op;
assign func_out = func;
assign op_code_out = op_code;
assign mem_to_reg_out = mem_to_reg;
assign mem_write_en_out = mem_write_en;
assign reg_write_en_out = reg_write_en;
assign alu_reset_out = alu_reset;
assign imm_sl_out = imm_sl;
assign br_sl_out = br_sl;
assign breq_sl_out = breq_sl;
assign reg_dest_out = reg_dest;
assign jump_sl_out = jump_sl;
assign jump_reg_sl_out = jump_reg_sl;
assign instr_stall_sl_out = instr_stall_sl;
assign ready_out = ready;
assign hi_lo_sl_out = hi_lo_sl;


datapath d1(
	.clock(clock),
	.mem_to_reg(mem_to_reg),
	.mem_write_en(mem_write_en),
	.reg_write_en(reg_write_en),
	.alu_reset(alu_reset),
	.imm_sl(imm_sl),
	.br_sl(br_sl),
	.breq_sl(breq_sl),
	.jump_sl(jump_sl),
	.jump_reg_sl(jump_reg_sl),
	.reg_dest(reg_dest),
	.alu_op(alu_op),
	.op_code(op_code),
	.func(func),
	.out(out),
	.instruction_out(instruction),
	.reg_data_out_a(reg_data_out_a),
	.reg_data_out_b(reg_data_out_b),
	.instr_stall_sl(instr_stall_sl),
	.hi_lo_sl(hi_lo_sl),
	.ready(ready)
);

control c1(
	.op_code(op_code),
	.func(func),
	.mem_to_reg(mem_to_reg),
	.mem_write_en(mem_write_en),
	.reg_write_en(reg_write_en),
	.alu_reset(alu_reset),
	.imm_sl(imm_sl),
	.br_sl(br_sl),
	.breq_sl(breq_sl),
	.jump_sl(jump_sl),
	.jump_reg_sl(jump_reg_sl),
	.reg_dest(reg_dest),
	.alu_op(alu_op),
	.instr_stall_sl(instr_stall_sl),
	.hi_lo_sl(hi_lo_sl),
	.ready(ready)
);

endmodule