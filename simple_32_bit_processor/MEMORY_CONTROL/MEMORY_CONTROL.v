// Authors: Leif Magnussen and Matthew Tucsok

// Memory Control Unit ~ takes in op code, source address and source data
// sets the ldr select, address bus select, address for data access and 

module MEMORY_CONTROL(op_code, r_w_source_1_address, r_source_2_data, ldr_sel, add_bus_sel,
 read_write_toggle, add_buss_data_access, data_bus_in, data_bus_out, LDR_data_out);

input [3:0] op_code;
input [31:0] r_w_source_1_address, r_source_2_data, data_bus_in;

output reg read_write_toggle;
output reg ldr_sel = 1'b0;
output reg add_bus_sel = 1'b0;
output reg [15:0] add_buss_data_access;
output reg [31:0] data_bus_out, LDR_data_out;

always @*
begin
	if (op_code == 4'b1101) // LDR ~ one source, one destination
	begin
        ldr_sel = 1'b1;
        add_bus_sel = 1'b1;
        read_write_toggle = 1;
        add_buss_data_access = r_w_source_1_address[15:0];
        LDR_data_out = data_bus_in;
	end

	else if (op_code == 4'b1110) // STR ~ two sources no destination
	begin
        add_bus_sel = 1'b1;
        read_write_toggle = 1'b0;
        add_buss_data_access = r_w_source_1_address[15:0];
        data_bus_out = r_source_2_data;
	end
	else
	begin
	    read_write_toggle = 1'b1;
	    ldr_sel = 1'b0;
	    add_bus_sel = 1'b1;
	end
end
endmodule
