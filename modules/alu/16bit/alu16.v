module alu16(
	input [15:0] a, b,
	input [2:0] aluOp,
	input [3:0] shamt,
	input clk, reset,
	output [31:0] result,
	output zero, ready);
	
	wire [15:0] and_wr, or_wr, updated_b_wr, shift_wr;
	wire [31:0] mult_wr;
	wire [1:0] mult_unit_op;
	wire subOp, sl_op;
	
	assign mult_unit_op = {aluOp[1], ~aluOp[2] & aluOp[0]};
	assign subOp = mult_unit_op[1];
	assign zero = ~|mult_wr[15:0];

	and32 and_32(and_wr, a, b);
	or32 or_32(or_wr, a, b);
	
	mux32_2_1 neg_sign(b, ~b, subOp, updated_b_wr);
	
	mux32_8_1 muxOut(
			mult_wr,						//summation
			mult_wr,						//multiplication
			mult_wr,						//subtraction
			{31'd0, mult_wr[15]},	//subtraction too
			and_wr,
			or_wr,
			shift_wr,
			shift_wr,
			aluOp,
			result);
	
	mult16 multUnit(
		.clock(clk), 
		.reset(reset), 
		.op(mult_unit_op), 
		.a(a), 
		.b(updated_b_wr), 
		.out(mult_wr),
		.ready(ready));
		
	shifter16 shifter(b, shamt, aluOp[0], shift_wr);
endmodule