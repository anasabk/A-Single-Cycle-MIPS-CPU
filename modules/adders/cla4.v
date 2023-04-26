module cla4(
	input [3:0] a, b,
	input c0,
	output [3:0] s,
	output cout);
	
	wire [3:0] g, p;
	wire [4:0] c;
	
	assign c[0] = c0;
	assign cout = c[4];
	
	genvar i;
	generate
	for(i = 0; i < 4; i = i + 1) begin : claLoop
		or or1(p[i], a[i],  b[i]);
		and and1(g[i], a[i],  b[i]);
		xor xor1(s[i], a[i], b[i], c[i]);
	end
	endgenerate
	
	cll4 cllMain(g, p, c0, c[4:1]);
endmodule