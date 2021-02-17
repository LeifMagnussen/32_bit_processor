// Author: Matthew Tucsok

// select: Selects betweeen LDR data to registers or ALU result to registers. 1 for LDR and 0 for result.

// ldr_data: 32 bit data coming from the memory controller.

// result: 32 bit result from the ALU.

// out_load_data: 32 bit data that must be sent to the registers.

module ldr_mux(select, ldr_data, result, out_load_data);
    input select;
    input [31:0] ldr_data, result;
    output reg [31:0] out_load_data;

    always @ *
    begin
        if (select)
            out_load_data = ldr_data;
        else
            out_load_data = result;
    end
endmodule