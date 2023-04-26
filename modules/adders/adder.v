module adder(
	input [31:0] a, b,
	input c0,
	output [31:0] s,
	output cout);
	
	wire [3:0] claR [7:0];
	wire [8:0] carry;
	
	assign carry[0] = c0;
	assign cout = carry[8];
	assign s = {claR[7], claR[6], claR[5], claR[4], claR[3], claR[2], claR[1], claR[0]};
	
	genvar i;
	generate
	for(i = 0; i < 8; i = i + 1) begin : claLoop
		cla4 claMain(a[ (i+1)*4-1 : i*4 ], b[ (i+1)*4-1 : i*4 ], carry[i], claR[i], carry[i + 1]);
	end
	endgenerate
endmodule