module datapath(
	input clock,
			mem_to_reg,
			mem_write_en,
			reg_write_en,
			alu_reset,
			imm_sl,
			br_sl,
			reg_dest,
			jump_sl,
			breq_sl,
			jump_reg_sl,
			instr_stall_sl,
			hi_lo_sl,
	input [2:0] alu_op,
	output [5:0] op_code,
					 func,
	output [15:0] out,
	output [31:0] instruction_out,
	output [15:0] reg_data_out_a, reg_data_out_b,
	output ready
);

	reg [9:0] pc_reg = 10'd0;
	reg [3:0] reg_write_addr;
	reg [15:0] reg_write_data;
	
	wire [3:0] reg_read_addr [1:0];
	wire [15:0] alu_in [1:0];
	wire [15:0] reg_read_data [1:0];
	wire [31:0] aluOut;
	wire [15:0] mem_out;
	wire [31:0] instruction;
	wire [31:0] instr_reg_out [1:0];
	wire [15:0] immediate;
	wire [3:0] shamt;
	wire [9:0] address;
	wire [9:0] next_instr;
	wire [3:0] rs_addr, rt_addr, rd_addr;
	wire is_zero;
	
	
	assign instruction_out = instruction;
	assign reg_data_out_a = reg_read_data[0];
	assign reg_data_out_b = reg_read_data[1];
	
	assign out = aluOut[15:0];
	assign reg_read_addr[0] = rs_addr;
	assign reg_read_addr[1] = rt_addr;
	assign alu_in[0] = reg_read_data[0];
	assign alu_in[1] = imm_sl ? immediate : reg_read_data[1];
	assign next_instr = pc_reg + 10'b1;
	assign is_zero_out = is_zero;
	assign instr_reg_out[1] = 32'd0;
	assign instruction = instr_reg_out[0];
	
	assign immediate = instruction[17:2];
	assign shamt = instruction[13:10];
	assign op_code = instruction[31:26];
	assign address = instruction[25:16];
	assign rs_addr = instruction[25:22];
	assign rt_addr = instruction[21:18];
	assign rd_addr = instruction[17:14];
	assign func = instruction[9:4];
	
	
	data_reg data_registers(
		.address_a(reg_read_addr[0]),
		.address_b(reg_read_addr[1]),
		.address_w1(reg_write_addr),
		.address_w2(4'd14),
		.clock(clock),
		.data_w1(reg_write_data),
		.data_w2(aluOut[31:16]),
		.wren_w1(reg_write_en | hi_lo_sl),
		.wren_w2(hi_lo_sl),
		.q_a(reg_read_data[0]),
		.q_b(reg_read_data[1])
	);
	
	alu16 alu_unit(
		.a(alu_in[0]), 
		.b(alu_in[1]),
		.aluOp(alu_op),
		.shamt(shamt),
		.clk(clock), 
		.reset(alu_reset),
		.zero(is_zero),
		.result(aluOut),
		.ready(ready)
	);
	
	data_mem data_memory(
		.address(aluOut[15:0]),
		.clock(clock),
		.data(reg_read_data[1]),
		.wren(mem_write_en),
		.q(mem_out)
	);
	
	rom_1024_32 instruction_registers(
		.address(pc_reg),
		.q(instr_reg_out[0])
	);
	
	
	always @ (*) begin
		if(mem_to_reg)
			reg_write_data <= mem_out;
		else if(jump_sl)
			reg_write_data <= {6'd0, next_instr};
		else
			reg_write_data <= aluOut[15:0];
			
		if(jump_sl)
			reg_write_addr <= 4'd15;
		else if(reg_dest)
			reg_write_addr <= rt_addr;
		else if(hi_lo_sl)
			reg_write_addr <= 4'd13;
		else
			reg_write_addr <= rd_addr;
	end

	
	always @ (posedge clock) begin
		if(~instr_stall_sl) begin
			if(br_sl & (breq_sl ~^ is_zero)) 
				pc_reg <= immediate[9:0];
			else if(jump_sl)
				pc_reg <= jump_reg_sl ? reg_read_data[0][9:0] : address;
			else if(pc_reg < 10'd1023)
				pc_reg <= next_instr;
		end
	end

endmodule