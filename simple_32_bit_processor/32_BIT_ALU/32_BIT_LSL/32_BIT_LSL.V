// Author: Tyson Meraw
// MOV module in the ALU, for copying another register value and shifting it left n bits
// Multiplies number by 2^n, but n most significant bits are lost, possibly skewing results

module BIT_LSL(Rin, n, Rx);
input [31:0] Rin;
input [4:0] n;		// 1 <= n <= 31 by design
output reg [31:0] Rx;
reg [4:0] count;	//shift counter
reg [31:0] temp_reg;	//holds value during shift

always @ *
  if(n!=0)	//only shift if n is not 0
    begin
	count = 0;
	temp_reg = Rin;
	while(count<n)
	  begin
	    temp_reg = { temp_reg[30:0],{1{1'b0}} };	//shift 1 bit at a time, n times
	    count = count+1;
	  end
	Rx = temp_reg;
    end
  else
	Rx = Rin;	//copy unshifted value in register Rin to register Rx

endmodule