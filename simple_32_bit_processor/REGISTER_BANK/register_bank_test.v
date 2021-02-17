// Author: Matthew Tucsok

module register_bank_test;
    //Inputs
    reg [15:0] enable;
    reg [31:0] load_data;


    //Outputs
     wire [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;

    initial
    begin

        #5 enable = 16'd1; load_data = 32'd7;
        #5 enable = 16'd2; load_data = 32'd5;
        #5 enable = 16'd4; load_data = 32'd24974;
        #5 enable = 16'd8; load_data = 32'd8196;
        #5 enable = 16'd54; load_data = 32'd16;
        #5 enable = 16'd2; load_data = 32'd1;
        #5 enable = 16'd16; load_data = 32'd16;

    end

    initial
    begin
        $monitor($time, " enable = %b, load_data %b, R0 = %b, R1 = %b, R2 = %b, R3 = %b, R4 = %b, R5 = %b...", enable, load_data, R0, R1, R2, R3, R4, R5);
    end


    register_bank test(
    load_data, enable,
    R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15
    );
endmodule