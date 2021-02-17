// Author: Matthew Tucsok

module ram_test_read;
    reg  Enable, ReadWrite;
    reg [31:0] DataIn;
    reg [15:0] Address;
    wire [31:0] DataOut;

    ram ram_test(Enable, ReadWrite, Address, DataIn, DataOut);

    initial
    begin
        $readmemh("ram_test_data_h.txt", ram_test.Mem);

           Enable=0;   ReadWrite=0;	Address=16'd0;
        #5 Enable=1;   ReadWrite=1;	Address=16'd0;
        #5 Enable=1;   ReadWrite=1;	Address=16'd1;
        #5 Enable=1;   ReadWrite=1;	Address=16'd2;
        #5 Enable=1;   ReadWrite=1;	Address=16'd3;
        #5 Enable=1;   ReadWrite=1;	Address=16'd4;
        #5 Enable=1;   ReadWrite=1;	Address=16'd5;
        #5 Enable=1;   ReadWrite=1;	Address=16'd6;
        #5 Enable=1;   ReadWrite=1;	Address=16'd7;
    end

    initial
    begin
        $monitor($time, "data at address %d is %h", Address, DataOut);
    end
endmodule