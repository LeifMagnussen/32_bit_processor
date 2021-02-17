// Author: Matthew Tucsok

module decoder_4to16_test;
    //Inputs
    reg [3:0] in;

    //Outputs
    wire[15:0] enable;

    initial
        begin
               in = 0;
            #5 in = 1;
            #5 in = 2;
            #5 in = 3;
            #5 in = 4;
            #5 in = 5;
            #5 in = 6;
            #5 in = 7;
            #5 in = 8;
            #5 in = 9;
            #5 in = 10;
            #5 in = 11;
            #5 in = 12;
            #5 in = 13;
            #5 in = 14;
            #5 in = 15;
            #5 in = 1'bx;
        end

    initial
        begin
            $monitor($time, " in = %b, enable %b", in, enable);
        end


    decoder_4to16 test(in, enable);
endmodule