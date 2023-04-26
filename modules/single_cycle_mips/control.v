`timescale 1 ps / 1 ps

module control(
	input [5:0] op_code,
					func,
	input ready,
	output reg 
			mem_to_reg,
			mem_write_en,
			reg_write_en,
			alu_reset,
			imm_sl,
			br_sl,
			breq_sl,
			reg_dest,
			jump_sl,
			jump_reg_sl,
			instr_stall_sl,
			hi_lo_sl,
	output reg [2:0] alu_op
);

localparam R_TYPE = 6'b000000;

localparam ADD 	= 6'b100000,
			  ADDI 	= 6'b001000,
			  SUB 	= 6'b100010,
			  AND 	= 6'b100100,
			  ANDI 	= 6'b001100,
			  OR 		= 6'b100101,
			  ORI 	= 6'b001101,
			  SLT 	= 6'b101011,
			  SLTI 	= 6'b001011,
			  SRL 	= 6'b000110,
			  SLL 	= 6'b000111,
			  LW		= 6'b100011,
			  LI		= 6'b001111,
			  SW		= 6'b101011,
			  BEQ		= 6'b000100,
			  BNE		= 6'b000101,
			  J 		= 6'b000010,
			  JAL 	= 6'b000011,
			  JR 		= 6'b001000,
			  MULT 	= 6'b011000;

			  
always @ (*) begin
	mem_to_reg 		= 1'b0;
	mem_write_en 	= 1'b0;
	reg_write_en 	= 1'b0;
	imm_sl 			= 1'b0;
	br_sl 			= 1'b0;
	breq_sl 			= 1'b0;
	reg_dest 		= 1'b0;
	alu_op 			= 3'b000;
	jump_sl			= 1'b0;
	jump_reg_sl 	= 1'b0;
	hi_lo_sl			= 1'b0;
	instr_stall_sl = 1'b0;
	alu_reset		= 1'b0;
	
	case (op_code) 
		R_TYPE: begin
			case (func)
				JR: begin
					jump_sl = 1'b1;
					jump_reg_sl = 1'b1;
				end
				
				default: begin
					alu_op = func[2:0];
					reg_write_en = 1'b1;
				end
			endcase
		end
				
		SLTI: begin
			alu_op = 3'b011;
			imm_sl = 1'b1;
			reg_dest = 1'b1;
			reg_write_en = 1'b1;
		end
		
		SW: begin
			alu_op = 3'd0;
			imm_sl = 1'b1;
			mem_write_en = 1'b1;
		end
		
		LW: begin
			alu_op = 3'd0;
			imm_sl = 1'b1;
			mem_to_reg = 1'b1;
			reg_write_en = 1'b1;
			reg_dest = 1'b1;
		end
		
		BEQ: begin
			breq_sl = 1'b1;
			alu_op = 3'b010;
			br_sl = 1'b1;
		end
		
		BNE: begin
			alu_op = 3'b010;
			br_sl = 1'b1;
		end
		
		J: begin
			jump_sl = 1'b1;
		end
		
		JAL: begin
			jump_sl = 1'b1;
			reg_write_en = 1'b1;
		end
		
		LI: begin
			alu_op = 3'b101;
			imm_sl = 1'b1;
			reg_dest = 1'b1;
			reg_write_en = 1'b1;
		end
		
		MULT: begin
			alu_op <= 3'b001;
			hi_lo_sl <= 1'b1;
			
			if(~ready) begin
				instr_stall_sl <= 1'b1;
				alu_reset = 1'b1;
				#2
				alu_reset = 1'b0;
			end
			
			else begin
				#2
				instr_stall_sl <= 1'b0;
			end
		end
		
		default: begin
			alu_op = op_code[2:0];
			imm_sl = 1'b1;
			reg_dest = 1'b1;
			reg_write_en = 1'b1;
		end
	endcase
end
endmodule