module ADD(R2,R3,R1);
input[31:0] R2,R3;
output[31:0] R1;

assign R1 = R2 + R3;	//Tyson removed carry set here so SET_FLAGS module can take care of it
endmodule