// Author: Leif Magnussen

// CMP instruction, sets flags

module BIT_CMP(in1, in2, result_flags);
input [31:0] in1,in2;
output reg [3:0] result_flags; // NZCV ~ Sign, Carry, Zero, Overflow ~ reordered by Tyson to Sign, Zero, Carry Overflow to match ALU
reg [31:0] tmp_result;
 // this process is done by subtracting the second operand from the first and then set flags based on that result
 // the result is discarded as both in1 and in2 are unmodified

 always @*
 begin
	
	// flag setting subtraction operation
 	tmp_result = in1 - in2;

	// sign is a copy of the MSB in the tmp_result
 	result_flags[3] = tmp_result[31];
	
	// setting carry flag
 	if (in1 > in2)
	begin	
 		result_flags[1] = 1'b1;
	end
 	else 
	begin
 		result_flags[1] = 1'b0;
 	end	

	// setting zero flag
 	if (tmp_result == 32'b0)
	begin
 		result_flags[2] = 1'b1;
	end
 	else
	begin
 		result_flags[2] = 1'b0;
	end

	// overflow will not be set for CMP
 	result_flags[0] = 1'b0;

 end
endmodule

