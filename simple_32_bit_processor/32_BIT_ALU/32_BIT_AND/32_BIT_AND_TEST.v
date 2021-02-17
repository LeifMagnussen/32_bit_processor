
module tb_and;
//Inputs
 reg[31:0] in1,in2;

//Outputs
 wire[31:0] Out;
 // Verilog code for ALU
initial
  begin
	in1 = 11; in2 = 1;
	#5 in1 = 8'b11011100; in2 = 12'b111011101101;
	#5 in1 = 4294967295; in2 = 123456789;
	#5 in1 = 0; in2 = 2;
	#5 in1 = 101; in2 = 1001;
	#5 in1 = 6; in2 = 9;
	#5 in1 = 23; in2 = 23;
	//#5 $finish;
  end

initial
  begin
	$monitor($time, " input = %b and %b, output %b", in1, in2, Out);
  end


 AND test_and(in1,in2,Out);

      
endmodule