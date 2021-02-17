// Author: Matthew Tucsok

module flags_register_test;
    //Inputs
    reg [3:0] write;

    //Outputs
    wire [3:0] read;

    initial
    begin
           write = 4'b1001;
        #5;
        #5 write = 4'b1101;
        #5 write = 4'b1111;
    end

    initial
    begin
        $monitor($time, " write = %b, read %b", write, read);
    end


    flags_register test(write, read);
endmodule