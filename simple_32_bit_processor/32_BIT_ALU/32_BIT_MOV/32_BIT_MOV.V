// Author: Tyson Meraw
// MOV module in the ALU, for copying another register value

module BIT_COPY(Rin, Rx);
input [31:0] Rin;
output reg [31:0] Rx;
always@*
  begin
	Rx = Rin;	//copy value in register Rin to register Rx
  end
endmodule