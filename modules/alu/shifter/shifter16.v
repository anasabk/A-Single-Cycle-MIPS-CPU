module shifter16(
	input [15:0] a,
	input [3:0] shamt,
	input left,
	output [15:0] out
);

	wire [15:0] entrance;
	wire [15:0] layer [3:0];
	
	genvar i;
	generate
		for(i = 0; i < 16; i = i + 1) begin : flip1
			assign entrance[i] = left ? a[15 - i] : a[i];
		end
	endgenerate
	
	assign layer[0] = shamt[0] ? {1'd0, entrance[15:1]} : entrance;
	assign layer[1] = shamt[1] ? {2'd0, layer[0][15:2]} : layer[0];
	assign layer[2] = shamt[2] ? {4'd0, layer[1][15:4]} : layer[1];
	assign layer[3] = shamt[3] ? {8'd0, layer[2][15:8]} : layer[2];

	generate
		for(i = 0; i < 16; i = i + 1) begin : flip2
			assign out[i] = left ? layer[3][15 - i] : layer[3][i];
		end
	endgenerate

endmodule