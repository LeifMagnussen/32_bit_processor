module tb_mul;
//Inputs
 reg[31:0] in1,in2;

//Outputs
 wire[31:0] Out;
 // Verilog code for ALU
initial
  begin
	in1 = 4294967295; in2 = 1;
	#5 in1 = 4294967295; in2 = 10;
	#5 in1 = 555; in2 = 246;
	#5 in1 = 0; in2 = 12345678;
	#5 in1 = 100; in2 = 12345678;
	#5 in1 = 6; in2 = 9;
	//#5 $finish;
  end

initial
  begin
	$monitor($time, " input = %d and %d, output %d", in1, in2, Out);
  end


 MUL test_mul(in1,in2,Out);

      
endmodule
