module alu32_tb();

reg [15:0] a, b;
reg clock = 1'b1, reset;
reg [2:0] aluOp = 3'd0;
reg [3:0] shamt;

wire [15:0] result;
wire zero, ready;

alu16 mult0(
	.a(a), 
	.b(b),
	.aluOp(aluOp),
	.clk(clock),
	.reset(reset),
	.result(result),
	.shamt(shamt),
	.zero(zero),
	.ready(ready));
	
always begin
	#1
	clock = ~clock;
end

initial begin
	aluOp = 3'd0;
	reset = 1'b1;
	a = 15'd7;
	b = 15'd289;
	shamt = 4'd2;
	
	#10
	reset = 1'b0;
	aluOp = aluOp + 3'd1;
	
	#80
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;

	
	#20
	aluOp = 3'd0;
	reset = 1'b1;
	a = 15'd73;
	b = 15'd19;
	
	#10
	reset = 1'b0;
	aluOp = aluOp + 3'd1;
	
	#80
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	
	#20
	aluOp = 3'd0;
	reset = 1'b1;
	a = 15'd40;
	b = 15'd52;
	
	#10
	reset = 1'b0;
	aluOp = aluOp + 3'd1;
	
	#80
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	
	#20
	aluOp = 3'd0;
	reset = 1'b1;
	a = 15'd40;
	b = 15'd40;
	
	#10
	reset = 1'b0;
	aluOp = aluOp + 3'd1;
	
	#80
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
	
	#10
	aluOp = aluOp + 3'd1;
end 

endmodule