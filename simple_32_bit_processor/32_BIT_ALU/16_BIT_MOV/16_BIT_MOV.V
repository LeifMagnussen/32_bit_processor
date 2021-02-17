// Author: Tyson Meraw
// MOV module in the ALU for a 16 bit input

module BIT_MOV(n, Rx);
input [15:0] n;
output reg [31:0] Rx;
always @ *
  begin
	Rx = n;	  //assign input value n to register Rx
  end
endmodule