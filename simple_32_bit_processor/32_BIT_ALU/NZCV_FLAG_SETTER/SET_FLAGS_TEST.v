// Author: Leif Magnussen

// tests setting flags for a variety of op_codes

module FLAG_SET_TEST;
// input variables
reg [3:0] op_code;
reg s_flag;
reg [31:0] in1, in2, result;

// output wire
wire [3:0] output_flags;

// module call
SET_FLAGS FLAG(op_code, s_flag, in1, in2, result, output_flags);

// time stepping initial block
initial
begin


	// testing for zero flag
	#5 in1 = {32{1'b0}}; in2 = {32{1'b0}}; result = {32{1'b0}}; op_code = 4'b1111; s_flag = 1'b1;

	// addition tests
	// two negatives produce a positive
	#5 in1 = {32{1'b1}}; in2 = {32{1'b1}}; result = {32{1'b1}}; op_code = 4'b0000; s_flag = 1'b1;
	
	// two positives and the result is negative
	#5 in1 = {32{1'b0}}; in2 = {32{1'b0}}; result = {32{1'b1}}; op_code = 4'b0000; s_flag = 1'b1;

	// subtraction tests next
	// positve subtracted from negative produces postive
	#5 in1 = {32{1'b0}}; in2 = {32{1'b1}}; result = {32{1'b0}}; op_code = 4'b0001; s_flag = 1'b1;

	// negative subtracted from positive produces negative
	#5 in1 = {32{1'b1}}; in2 = {32{1'b0}}; result = {32{1'b1}}; op_code = 4'b0001; s_flag = 1'b1;

	#5 $finish;
end

// monitoring initial block
initial
begin
	$monitor($time, " result is = %b, op_code is = %b, flags are = %b", result, op_code, output_flags);
end

endmodule
