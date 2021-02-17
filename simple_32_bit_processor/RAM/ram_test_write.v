// Author: Matthew Tucsok

module ram_test_write;
    reg  Enable, ReadWrite;
    reg [31:0] DataIn;
    reg [15:0] Address;
    wire [31:0] DataOut;

    ram ram_test(Enable, ReadWrite, Address, DataIn, DataOut);

    initial
    begin


           Enable=0;   ReadWrite=0;	Address=16'd0;	DataIn =32'hAAAAAAAA;
        #5 Enable=1;   ReadWrite=0;	Address=16'd0;	DataIn =32'hAAAAAAAA;
        #5 Enable=1;   ReadWrite=0;	Address=16'd1;	DataIn =32'h00AABBCC;
        #5 Enable=1;   ReadWrite=0;	Address=16'd2;	DataIn =32'h00BB2351;
        #5 Enable=1;   ReadWrite=0;	Address=16'd3;	DataIn =32'h00CCFFFF;
        #5 Enable=1;   ReadWrite=0;	Address=16'd4;	DataIn =32'h00DDABCD;
        #5 Enable=1;   ReadWrite=0;	Address=16'd5;	DataIn =32'h00000000;
        #5 Enable=1;   ReadWrite=0;	Address=16'd6;	DataIn =32'hFFFFEFFF;
        #5 Enable=1;   ReadWrite=0;	Address=16'd7;	DataIn =32'hEEEEEEEE;
        #5;

        $writememh("ram_test_data_h.txt", ram_test.Mem);
    end
endmodule
