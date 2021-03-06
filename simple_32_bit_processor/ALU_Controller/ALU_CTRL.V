// Author: Tyson Meraw and Jack McClelland
module ALU_CTRL(cond, opcode, opcodeCase, s, src2, src1, imv, iNZCV,oNZCV, result);
input [31:0] src2, src1;
input s;
input [3:0] cond, opcode;
input [15:0] imv;
input [3:0] iNZCV;
output [3:0] oNZCV;
output reg [3:0] opcodeCase;
output reg [31:0] result;
reg [4:0] n;
wire [31:0] add_result, sub_result, mul_result, or_result, and_result, eor_result, mov_result, cpy_result, lsr_result,
lsl_result, ror_result;
wire [15:0] adr_result;
wire [3:0] cmp_result;

//assign opcodeCase = opcode;
always @ *
begin
	opcodeCase = opcode;
    case (cond)
        4'd1: if (iNZCV[2] == 1'b0) opcodeCase = 4'd15; 				//EQ: Change opcode to NOP if NE (~Z)
        4'd2: if (iNZCV[2] == 1'b1 || (iNZCV[3]^iNZCV[0]) == 1'b1) opcodeCase = 4'd15; //GT: Change opcode to NOP if LE (Z or (N xor V))
        4'd3: if ((iNZCV[3]^iNZCV[0]) == 1'b0) opcodeCase = 4'd15; 			//LT: Change opcode to NOP if GE (~(N xor V))
        4'd4: if ((iNZCV[3]^iNZCV[0]) == 1'b1) opcodeCase = 4'd15; 			//GE: Change opcode to NOP if LT (N xor V)
        4'd5: if (iNZCV[2] == 1'b0 && (iNZCV[3]^iNZCV[0]) == 1'b0) opcodeCase = 4'd15; //LE: Change opcode to NOP if GT (~Z and ~(N xor V))
        4'd6: if (iNZCV[2] == 1'b1 || iNZCV[1] == 1'b0) opcodeCase = 4'd15; 		//HI: Change opcode to NOP if LS (Z or ~C)
        4'd7: if (iNZCV[1] == 1'b1) opcodeCase = 4'd15; 				//LO: Change opcode to NOP if HS (C)
        4'd8: if (iNZCV[1] == 1'b0) opcodeCase = 4'd15; 				//HS: Change opcode to NOP if LO (~C)
	default: ;//do nothing
    endcase
end
always @ *
begin
    n = imv[7:3];
    case (opcodeCase)
        4'd0: result = add_result;			//result = src2+src1 ALSO flag module can replace C output here.
        4'd1: result = sub_result;	//result = src2-src1 ALSO flag module can replace N output here.
        4'd2: result = mul_result;	//result = src2*src1 ALSO Do we need to set V flag for MUL at all?
        4'd3: result = or_result;
        4'd4: result = and_result;
        4'd5: result = eor_result;
        4'd6: result = mov_result;		//result = n
        4'd7: result = cpy_result;		//result = src1
        4'd8: result = lsr_result;	//result = src1>>n
        4'd9: result = lsl_result;	//result = src1<<n
        4'd10: result = ror_result;	//result = src1 rotated right n-bits
        4'd11: result = cmp_result; 	//set flags according to src2-src1
        4'd12: result = adr_result; //ADR
        4'd13: result = {32{1'bx}}; //LDR
        4'd14: result = {32{1'bx}}; //STR
        4'd15: result = {32{1'bx}}; //NOP (skip instruction)
        default: result = {32{1'bx}};
    endcase
end

ADD ADD(.R2(src2),.R3(src1),.R1(add_result));			//result = src2+src1 ALSO flag module can replace C output here.
SUB SUB(.R2(src2),.R3(src1),.R1(sub_result));	//result = src2-src1 ALSO flag module can replace N output here.
MUL MUL(.R2(src2),.R3(src1),.R1(mul_result));	//result = src2*src1 ALSO Do we need to set V flag for MUL at all?
OR  ORR(.R2(src2),.R3(src1),.R1(or_result));
AND AND(.A(src2),.B(src1),.Out(and_result));
EOR XOR(.R2(src2),.R3(src1),.R1(eor_result));
BIT_MOV MOV(.n(imv), .Rx(mov_result));		//result = n
BIT_COPY CPY(.Rin(src1), .Rx(cpy_result));		//result = src1
BIT_LSR LSR(.Rin(src2), .n(n), .Rx(lsr_result));	//result = src1>>n
BIT_LSL LSL(.Rin(src2), .n(n), .Rx(lsl_result));	//result = src1<<n
BIT_ROR ROR(.Rin(src2), .n(n), .Rx(ror_result));	//result = src1 rotated right n-bits
BIT_CMP CMP(.in1(src2), .in2(src1), .result_flags(cmp_result)); 	//set flags according to src2-src1
BIT_ADR ADR(.destination_reg(adr_result), .address(imv));
SET_FLAGS FLG(.op_code(opcodeCase), .s_flag(s), .in1(src1), .in2(src2), .result(result), .output_flags(oNZCV));
endmodule