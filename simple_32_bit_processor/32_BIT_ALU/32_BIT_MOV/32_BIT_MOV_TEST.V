// Author: Tyson Meraw
// copy module testbench

module BIT_COPY_TEST;
reg [31:0] Rin;
wire [31:0] Rx;

initial
  begin
	   Rin = {{3{1'b1}},{5{1'b0}},{10{1'b1}},{12{1'b0}},{2{1'b1}}};
	#5 Rin = 924385;
	#5 Rin = 3;
	#5 Rin = 0;
	// #5 $finish;
  end

initial
  begin
	$monitor($time, " input = %d, Reg = %d or 32'b%b", Rin, Rx, Rx);
  end

BIT_COPY MVR(Rin, Rx);
endmodule