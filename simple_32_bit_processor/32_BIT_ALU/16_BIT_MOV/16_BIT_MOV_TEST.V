// Author: Tyson Meraw
// MOV module testbench

module BIT_MOV_TEST;
reg [15:0] n;
wire [31:0] Rx;

initial
  begin
	   n = {16{1'b1}};
	#5 n = 924385;
	#5 n = 3;
	#5 n = 0;
	// #5 $finish;
  end

initial
  begin
	$monitor($time, " input = %d or 16'b%b, Reg = %d or 32'b%b", n, n, Rx, Rx);
  end

BIT_MOV MOV(n, Rx);
endmodule