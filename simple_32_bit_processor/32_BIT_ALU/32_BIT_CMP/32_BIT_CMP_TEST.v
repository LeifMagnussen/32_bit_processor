module BIT_CMP_TEST;

reg [31:0] in1, in2;
wire [3:0] result_flags;
BIT_CMP CMP(in1,in2,result_flags);

initial
begin
	#5 in1 = {32{1'b1}}; in2 = {32{1'b1}}; // for zero flag
	#5 in1 = {32{1'b0}}; in2 = {32{1'b1}}; // for carry flag and sign flag
	#5 $finish;
end

initial
begin
	$monitor($time, "1st Reg = %b, 2nd Reg = %b, Result_flags = %b", in1, in2, result_flags);

end
endmodule

