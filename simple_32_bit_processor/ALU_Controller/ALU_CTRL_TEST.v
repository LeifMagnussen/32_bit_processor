module tb_alu;
//Inputs
 reg[31:0] src2,src1;
reg [3:0] cond,opcode,iNZCV;
reg s;
reg [15:0] imv;
wire [3:0] oNZCV;

//Outputs
 wire [31:0] result;
 // Verilog code for ALU
integer i;
initial
  begin
	cond=4'b0;  s=1; src2=10; src1=9; imv=65000;iNZCV=4'b0; 
	opcode = 4'd0;
	#5
	for (i=0; i<15;i=i+1)
	begin
	opcode= opcode+1;
	iNZCV = oNZCV;
	#5;
	end
	
	src2 = 4294967295; src1 = 1; opcode = 4'b0000;
	#5 src2 = 4294967295; src1 = 2;
	
	#5 cond=4'b0000; opcode = 4'b0001; s = 1; src2 = 12; src1 = 12; imv=0; iNZCV=4'b0;
	#5 cond=4'b0010; opcode = 4'b0000; s = 1; src2 = 5; src1 = 6; imv=0; iNZCV=oNZCV;
	#4 cond=4'b0001; opcode = 4'b0000; s = 1; src2 = 40; src1 = 7; imv=0; iNZCV=oNZCV;

	

	//#5 $finish;
  end

initial
  begin
	$monitor($time, "opcode= %b, input = %b or %d and %b or %d, output %b or %d. Inflag: %b. Outflag: %b", opcode, src1, src1, src2, src2, result, result, iNZCV, oNZCV);
  end


ALU_CTRL test_alu(cond, opcode, s, src2, src1, imv, iNZCV, oNZCV, result);

      
endmodule
