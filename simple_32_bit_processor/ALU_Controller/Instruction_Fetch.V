// Author: Tyson Meraw

module INST_FTCH;
reg [31:0] INST;
wire [31:0] enable, load_data, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, src2, src1;

initial
  begin
		 //cond    opcode  s    dest    src2    src1    n  
	   INST = {4'b0000,4'b0000,1'b0,4'b0000,4'b0000,4'b0000,5'b00000,3'b000,3'b000};
	#5 INST = {4'b0000,4'b0000,1'b1,4'b0000,4'b0010,4'b0001,5'b00000,3'b000,3'b000};
	#5 INST = {4'b0000,4'b0001,1'b1,4'b0000,4'b0010,4'b0001,5'b00000,3'b000,3'b000};
	#5 INST = {4'b0001,4'b0000,1'b1,4'b0000,4'b0011,4'b0001,5'b00000,3'b000,3'b000};
	#5 INST = {4'b0000,4'b0000,1'b1,4'b0000,4'b0011,4'b0001,5'b00000,3'b000,3'b000};
	#5 INST = {4'b0000,4'b0000,1'b1,4'b0000,4'b0101,4'b0101,5'b00000,3'b000,3'b000};
	// #5 $finish;
  end

initial
  begin
	$monitor($time, " src2 = %d, src1 = %d, result = %d, NZCV = %b", src2, src1, result, NZCV);
  end

//decoder_4to16 dest(.in(INST[22:19]),.enable(enable));
registers REG(load_data, enable, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15);		//take value from decoder to write to destination register, holds register values for source muxs
mux_32_bit_16x1 SRC2(INST[18:15], Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, src2);	//Receive R2 selection from Instruction Fetch, send correct register
mux_32_bit_16x1 SRC1(INST[14:11], Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, src1);	//Receive R3 selection from Instruction Fetch, send correct register
ALU_CTRL ALU(.cond(INST[31:28]), .opcode(INST[27:24]), .s(INST[23]), .src2(src2), .src1(src1), .imv(INST[18:3]), .NZCV(NZCV), .result(result));		//result should be fed back to load_data in registers module, not sure how to accomplish that
//flags_register (.write(NZCV), .read(NZCV);	//NZCV is an inout port in the ALU_CTRL but somehow I doubt it works exactly like this
endmodule