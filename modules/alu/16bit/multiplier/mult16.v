module mult16 (
	input clock, reset,
	input [1:0] op,
	input [15:0] a, b, 
	output [31:0] out,
	output ready
);
	
	wire wr_result, 
		  wr_shift_reg, 
		  wr_counter, 
		  sl_shift, 
		  rt_shift_reg, 
		  rt_counter,
		  rt_multiplicand, 
		  ls_bit;

	wire [4:0] counter;
	wire [15:0] toAdder, added, multiplicandCurrent, addA, addB;
	wire [31:0] result;
	wire [15:0] tempOut [1:0];	
	wire ready_signal;
	wire mult_op;
	
	assign out = {tempOut[1], tempOut[0]};
	assign ready = ready_signal & mult_op & ~reset;
	assign mult_op = ~op[1] & op[0];
	
	mux32_2_1 add_param_mux1(a, toAdder, mult_op, addA);
	mux32_2_1 add_param_mux2(b, multiplicandCurrent, mult_op, addB);
	mux32_2_1 least32_out_mux(added, result[15:0], mult_op, tempOut[0]);
	mux32_2_1 most32_out_mux(0, result[31:16], mult_op, tempOut[1]);
	
	adder add1(addA, addB, op[1], added);
		
	mult_dp_16 d1(
		.multiplicand(a), 
		.multiplier(b), 
		.added(added), 
		.wr_shift_reg(wr_shift_reg), 
		.wr_counter(wr_counter), 
		.sl_shift(sl_shift), 
		.rt_shift_reg(rt_shift_reg), 
		.rt_counter(rt_counter),
		.rt_multiplicand(rt_multiplicand),
		.clock(clock),
		.toAdder(toAdder), 
		.multiplicandOut(multiplicandCurrent),
		.counterOut(counter), 
		.ls_bit(ls_bit),
		.result(result)
	);

	mult_c_16 c1(
		.counter(counter), 
		.ls_bit(ls_bit), 
		.multOp(mult_op), 
		.reset(reset),
		.wr_shift_reg(wr_shift_reg), 
		.wr_counter(wr_counter), 
		.sl_shift(sl_shift), 
		.rt_shift_reg(rt_shift_reg), 
		.rt_counter(rt_counter),
		.rt_multiplicand(rt_multiplicand),
		.ready(ready_signal)
	);
endmodule