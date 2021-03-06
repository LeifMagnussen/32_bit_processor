// Author: Leif Magnussen
// Sets logic for flag setting at the output of the ALU
// Any instruction with S flag will trigger this module

module SET_FLAGS (op_code, s_flag, in1, in2, result, output_flags);

input [31:0] result, in1, in2;
input s_flag;
input [3:0] op_code;
output reg [3:0] output_flags;

always @*
begin
	// checking for s bit in the instruction
	if (s_flag && op_code!=4'b1111)
	begin
        // avoiding output_flags dont care
        output_flags = 4'b0000;

        // setting N flag
        if (result[31] == 1'b1)		//Tyson changed result[0] to result[31]
            output_flags[3] = 1'b1;
        else
            output_flags[3] = 1'b0;

        // setting Z flag
        if (result == {32{1'b0}})
            output_flags[2] = 1'b1;
        else
            output_flags[2] = 1'b0;

        // setting C flag by Tyson
        if (op_code == 4'b000) //addition
        begin
          if (result < in1)	//if result < in1 then also result < in2 and vice-versa, so it doesn't matter which we test
          begin
            output_flags[1] = 1'b1;
          end
        end

        // setting V flag
        if (op_code == 4'b000) // addition case
        begin
            if (in1[31] == 1'b1 && in2[31] == 1'b1 && result[31] == 1'b0) // two negatives being added and result is positive
                output_flags[0] = 1'b1;
            else if (in1[31] == 1'b0 && in2[31] == 1'b0 && result[31] == 1'b1) // two positives being added and result is negative
                output_flags[0] = 1'b1;
        end

        else if (op_code == 4'b0001)
        begin
            if (in1[31] == 1'b0 && in2[31] == 1'b1 && result[31] == 1'b0) // positive subtracted from negative and produces positive
                output_flags[0] = 1'b1;
            else if (in1[31] == 1'b1 && in2[31] == 1'b0 && result[31] == 1'b1) // negative subtracted from positive and produces negative
                output_flags[0] = 1'b1;					//Tyson changed to set flag to true (formerly output_flags[0] = 1'b0;)
        end
	end
	if (op_code == 4'b1011)
	    output_flags = result[3:0];

end
endmodule