// Author: Leif Magnussen
// tests the ADR module


module ADR_TEST;
reg address;
wire destination;

BIT_ADR ADR(destination, address);

initial
begin
	// testing with address and destinations
	#5 address = {16{1'b1}}; 
	#5 address = {16{1'b0}};
	#5 address = 1'b0;
end

initial
begin
	$monitor($time, " address = %b, destination = %b", address, destination);
end

endmodule