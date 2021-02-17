// Author: Leif Magnussen
// Module for 16 bit adr op instruction, op_code = 1100


module BIT_ADR(destination_reg, address);
input [15:0] address;
output reg [15:0] destination_reg;

always @*
begin
	// moving address into the destination register specified
	destination_reg = address;
end
endmodule
