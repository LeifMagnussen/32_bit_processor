// Author: Tyson Meraw
// rotate module testbench

module BIT_ROR_TEST;
reg [31:0] Rin;
reg [4:0] n;
wire [31:0] Rx;

initial
  begin
	   Rin = {{3{1'b1}},{5{1'b0}},{10{1'b1}},{12{1'b0}},{2{1'b1}}}; n = 12;
	#5 Rin = 924385; n = 5;
	#5 Rin = 3; n = 1;
	#5 Rin = 2147483648; n = 25;
	#5 Rin = 15; n = 0;
	// #5 $finish;
  end

initial
  begin
	$monitor($time, " input = %d or 32'b%b, rotated %d bits right, result = %d or 32'b%b", Rin, Rin, n, Rx, Rx);
  end

BIT_ROR ROR(Rin, n, Rx);
endmodule