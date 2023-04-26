module cll4(
	input [3:0] g, p,
	input c0,
	output [3:0] c);
	
	wire [9:0] tempAnd;
	
	and and1(tempAnd[0], p[0], c0);
	or or1(c[0], g[0], tempAnd[0]);
	
	and and2(tempAnd[1], p[1], p[0], c0);
	and and3(tempAnd[2], p[1], g[0]);
	or or2(c[1], g[1], tempAnd[1], tempAnd[2]);
	
	and and4(tempAnd[3], p[2], p[1], p[0], c0);
	and and5(tempAnd[4], p[2], p[1], g[0]);
	and and6(tempAnd[5], p[2], g[1]);
	or or3(c[2], g[2], tempAnd[3], tempAnd[4], tempAnd[5]);
	
	and and7(tempAnd[6], p[3], p[2], p[1], p[0], c0);
	and and8(tempAnd[7], p[3], p[2], p[1], g[0]);
	and and9(tempAnd[8], p[3], p[2], g[1]);
	and and10(tempAnd[9], p[3], g[2]);
	or or4(c[3], g[3], tempAnd[6], tempAnd[7], tempAnd[8], tempAnd[9]);
endmodule