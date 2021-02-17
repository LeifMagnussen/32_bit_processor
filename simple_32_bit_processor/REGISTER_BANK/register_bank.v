// Author: Matthew Tucsok

// enable: 16 bit input where only one bit should be a 1, indicating which register is enabled for saving data to. Wire
// this to the output of the 4 to 16 decoder.

// load_data: 32 bit value that comes from the LDR MUX. This value is placed in the enabled register. Wire this to the
// output of the LDR MUX.

// R0-R15: 32 bit registers that hold various values (PC, values, etc.). Wire these to the inputs of the source MUXs.

module register_bank (
    load_data, enable,
    R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15
    );

    input [15:0] enable;
    input [31:0] load_data;
    output reg [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;

    always @ *
    begin
        case (enable)
            16'd1: R0 = load_data;
            16'd2: R1 = load_data;
            16'd4: R2 = load_data;
            16'd8: R3 = load_data;
            16'd16: R4 = load_data;
            16'd32: R5 = load_data;
            16'd64: R6 = load_data;
            16'd128: R7 = load_data;
            16'd256: R8 = load_data;
            16'd512: R9 = load_data;
            16'd1024: R10 = load_data;
            16'd2048: R11 = load_data;
            16'd4096: R12 = load_data;
            16'd8192: R13 = load_data;
            16'd16384: R14 = load_data;
            16'd32768: R15 = load_data;
            default:;
        endcase
    end
endmodule