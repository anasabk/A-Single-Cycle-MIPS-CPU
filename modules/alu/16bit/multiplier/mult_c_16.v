module mult_c_16(
	input [4:0] counter, 
	input ls_bit, multOp, reset,
	output reg wr_shift_reg, 
				  wr_counter, 
				  sl_shift, 
				  rt_shift_reg, 
				  rt_counter,
				  rt_multiplicand,
				  ready
);

	always @ (*) begin
		wr_shift_reg = 1'b0;
		wr_counter = 1'b0;
		sl_shift = 1'b0;
		ready = 1'b0;
		rt_shift_reg = reset;
		rt_counter = reset;
		rt_multiplicand = reset;
		
		if(counter == 5'd0) begin
			if(multOp) begin
				rt_multiplicand = 1'b1;
				rt_shift_reg = 1'b1;
				wr_counter = 1'b1;
			end
		end
		
		else if(counter == 5'd17) ready = 1'b1;
		
		else if(counter != 5'd17) begin
			wr_shift_reg = ls_bit;
			sl_shift = 1'b1;
			wr_counter = 1'b1;
		end
	end
endmodule