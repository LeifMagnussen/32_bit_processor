// Author: Matthew Tucsok

module ldr_mux_test;
    //Inputs
    reg select;
    reg [31:0] ldr_data, result;


    //Outputs
     wire [31:0] out_load_data;

    initial
    begin

        #5 select = 0; ldr_data = 32'd60000; result = 32'd5;
        #5 select = 1; ldr_data = 32'd60000; result = 32'd5;
    end

    initial
    begin
        $monitor($time, " select = %b, out_load_data %b", select, out_load_data);
    end


    ldr_mux test(select, ldr_data, result, out_load_data);
endmodule