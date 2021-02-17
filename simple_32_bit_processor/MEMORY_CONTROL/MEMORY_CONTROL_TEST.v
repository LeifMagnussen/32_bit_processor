// Author: Leif Magnussen

// Tester for the memory access control unit

module MEMORY_CONTROLLER_TEST;

reg [3:0] op_code;
reg [31:0] source_address, source_data;

wire ldr_sel, add_bus_sel;
wire [31:0] destination_address, data_bus;

MEMORY_CONTROLLER MEM(op_code,source_address, source_data, ldr_sel, add_bus_sel, destination_address, data_bus);

initial
begin
	#5 op_code = 4'b1101; source_data = {32{1'b1}}; source_address = {32{1'b0}}; // LDR operation
	#5 op_code = 4'b1110; source_data = {32{1'b0}}; source_address = {32{1'b1}}; // STR operation
	#5 $finish;

end

initial
begin
	$monitor($time, "Op-Code = %b, ldr_sel = %b, add_bus_sel = %b, data_bus = %b", op_code, ldr_sel, add_bus_sel, data_bus);
end
endmodule

