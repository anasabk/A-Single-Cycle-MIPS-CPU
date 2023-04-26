module and32(
	output [31:0] c,
	input [31:0] a, b
);

genvar i;
generate
for (i = 0; i < 32; i = i + 1) begin : and_gate
	and and1(c[i], a[i], b[i]);
end
endgenerate

endmodule