// Authors: Matthew Tucsok and Leif Magnussen
// Main module for the processing of instructions

module PROCESSOR_MAIN(instruction, manual_ram_addr, manual_readWrite, ramOut, manual_ram_write, PC_counter, flagsRegisterOut, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15);
    input [31:0] instruction, manual_ram_write;
    input [15:0] manual_ram_addr;
    input manual_readWrite;
    wire [31:0] memControlDataOut, memControl_to_LDR, aluResult, sourceOne, sourceTwo, ldrMuxDataOut, data_override_to_ram;
    output wire [31:0] ramOut;
    output wire [31:0] Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15;
    wire [15:0] RamAddBus, memControlDataBus, addr_override_to_ram;
    wire [15:0] decoderEnable;
    wire [4:0] shiftROR;
    wire [3:0] flagsRegisterIn, destination, opCode, condition, sourceOneSelect, sourceTwoSelect;
    wire [3:0] destination_override_to_mux;
    wire [3:0] aluCalculatedOpcode;
    output wire [3:0] flagsRegisterOut;
    wire sBit, ldrSelect, addSelect;
    wire readWrite, readWrite_from_override;
    wire [2:0] extraBits;
    output [7:0] PC_counter;

    // breaking up received instruction
    fetchInstruction fetch(.instruction(instruction),
    .condition(condition),
    .opCode(opCode),
    .sBit(sBit),
    .destination(destination),
    .sourceTwoSelect(sourceTwoSelect),
    .sourceOneSelect(sourceOneSelect),
    .shiftROR(shiftROR),
    .extraBits(extraBits),
    .program_counter(PC_counter));

    // manual Memory write override
    manual_ram_data_mux mem_override(
    .sel(manual_readWrite),
    .manual_data(manual_ram_write),
    .system_data(memControlDataOut),
    .data_to_ram(data_override_to_ram));

    manual_ram_addr_mux addr_override(
    .sel(manual_readWrite),
    .manual_addr(manual_ram_addr),
    .system_addr(RamAddBus),
    .addr_to_ram(addr_override_to_ram));

    manual_ram_write_enable_override write_override(
    .sel(manual_readWrite),
    .input_read_write_signal(readWrite),
    .output_read_write_signal(readWrite_from_override));

    // memory access process
    ram RAM(
    .Enable(1'b1),
    .ReadWrite(readWrite_from_override),
    .Address(addr_override_to_ram),
    .DataIn(data_override_to_ram),
    .DataOut(ramOut));

    // Memory Control Unit
    MEMORY_CONTROL MEM(
    .op_code(opCode),
    .r_w_source_1_address(sourceOne),
    .r_source_2_data(sourceTwo),
    .ldr_sel(ldrSelect),
    .add_bus_sel(addSelect),
    .read_write_toggle(readWrite),
    .add_buss_data_access(memControlDataBus),
    .data_bus_in(ramOut),
    .data_bus_out(memControlDataOut),
    .LDR_data_out(memControl_to_LDR));

    // addr_bus_mux
    addr_bus_mux ADR_MUX(
    .select(addSelect),
    .pc_address(PC_counter),
    .addr_bus_data_access(memControlDataBus),
    .address_bus(RamAddBus));

    // ldr_mux
    ldr_mux LDR_MUX(
    .select(ldrSelect),
    .ldr_data(memControl_to_LDR),
    .result(aluResult),
    .out_load_data(ldrMuxDataOut));

    // register bank process
    no_dest_reg_override OVERRIDE_DEST(
    .original_destination(destination),
    .op_code(aluCalculatedOpcode),
    .true_destination(destination_override_to_mux));

    decoder_4to16 DEC(
    .in(destination_override_to_mux),
    .enable(decoderEnable));

    register_bank REG(
    .load_data(ldrMuxDataOut),
    .enable(decoderEnable),
    .R0(Q0), .R1(Q1), .R2(Q2), .R3(Q3), .R4(Q4), .R5(Q5), .R6(Q6), .R7(Q7), .R8(Q8), .R9(Q9), .R10(Q10),.R11(Q11), .R12(Q12), .R13(Q13), .R14(Q14), .R15(Q15));

    // multiplexing
    mux_32_bit_16x1 MUX1(
    .sel(sourceOneSelect),
    .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3), .Q4(Q4), .Q5(Q5), .Q6(Q6), .Q7(Q7), .Q8(Q8), .Q9(Q9), .Q10(Q10), .Q11(Q11), .Q12(Q12), .Q13(Q13), .Q14(Q14), .Q15(Q15),
    .source(sourceOne));

    mux_32_bit_16x1 MUX2(
    .sel(sourceTwoSelect),
    .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3), .Q4(Q4), .Q5(Q5), .Q6(Q6), .Q7(Q7), .Q8(Q8), .Q9(Q9), .Q10(Q10), .Q11(Q11), .Q12(Q12), .Q13(Q13), .Q14(Q14), .Q15(Q15),
    .source(sourceTwo));

    // ALU
    ALU_CTRL ALU(
    .cond(condition),
    .opcode(opCode),
    .opcodeCase(aluCalculatedOpcode),
    .s(sBit),
    .src2(sourceTwo),
    .src1(sourceOne),
    .imv({sourceTwoSelect, sourceOneSelect, shiftROR, extraBits}),
    .iNZCV(flagsRegisterOut),
    .oNZCV(flagsRegisterIn),
    .result(aluResult));

    // Simple flags register
    flags_register FLA(
    .write(flagsRegisterIn),
    .read(flagsRegisterOut));
endmodule

// To allow for initialization of values to the ram, there needs to be an address and data override to the RAM
module manual_ram_data_mux(sel, manual_data, system_data, data_to_ram);
    input sel;
    input [31:0] manual_data, system_data;
    output reg [31:0] data_to_ram;
    always @ *
    begin
        if (sel)
        begin
            data_to_ram = manual_data;
        end
        else
        begin
            data_to_ram = system_data;
        end
    end
endmodule

module manual_ram_addr_mux(sel, manual_addr, system_addr, addr_to_ram);
    input sel;
    input [15:0] manual_addr, system_addr;
    output reg [15:0] addr_to_ram;
    always @ *
    begin
        if (sel)
        begin
            addr_to_ram = manual_addr;
        end
        else
        begin
            addr_to_ram = system_addr;
        end
    end
endmodule

module manual_ram_write_enable_override(sel, input_read_write_signal, output_read_write_signal);
    input sel, input_read_write_signal;
    output reg output_read_write_signal;
    always @ *
    begin
        if (sel)
        begin
            output_read_write_signal = 1'b0;
        end
        else
        begin
            output_read_write_signal = input_read_write_signal;
        end
    end
endmodule

// This mux is required so CMP and NOP does not try to save a value to R0
module no_dest_reg_override(original_destination, op_code, true_destination);
    input [3:0] op_code, original_destination;
    output reg [3:0] true_destination;
    always @ *
    begin
        case (op_code)
            4'b1011: true_destination = {4{1'bz}};
            4'b1110: true_destination = {4{1'bz}};
            4'b1111: true_destination = {4{1'bz}};
            default: true_destination = original_destination;
        endcase
    end
endmodule

module fetchInstruction(instruction, condition, opCode, sBit, destination, sourceTwoSelect, sourceOneSelect, shiftROR, extraBits, program_counter);
    input [31:0] instruction;
    output reg [2:0] extraBits;
    output reg [3:0] condition, opCode, destination, sourceTwoSelect, sourceOneSelect;
    output reg [4:0] shiftROR;
    output reg sBit;
    output reg [7:0] program_counter = 8'd0;

    always @ (instruction)
    begin
        condition = instruction[31:28];
        opCode = instruction[27:24];
        sBit = instruction[23];
        destination = instruction[22:19];
        sourceTwoSelect = instruction[18:15];
        sourceOneSelect = instruction[14:11];
        shiftROR = instruction[10:6];
        extraBits = instruction[5:3];
        if (opCode >= 4'd0 && opCode <= 4'd15)
        begin
            program_counter = program_counter + 8'd1; // Increment the PC if valid Opcode. This ensures no increment for manual override
        end

    end
endmodule
