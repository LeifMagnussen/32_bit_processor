// Author: Matthew Tucsok

module mux_32_bit_16x1_test;
    //Inputs
    reg [31:0] Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15;
    reg [3:0] sel;

    //Outputs
    wire [31:0] source;

    initial
    begin
           Q0 = 100; Q1 = 101; Q2 = 102; Q3 = 103; Q4 = 104; Q5 = 105; Q6 = 106; Q7 = 107; Q8 = 108; Q9 = 109; Q10 = 110; Q11 = 111; Q12 = 112; Q13 = 113;  Q14 = 114; Q15 = 115;
        #5 sel = 0;
        #5 sel = 1;
        #5 sel = 2;
        #5 sel = 3;
        #5 sel = 4;
        #5 sel = 5;
        #5 sel = 6;
        #5 sel = 7;
        #5 sel = 8;
        #5 sel = 9;
        #5 sel = 10;
        #5 sel = 11;
        #5 sel = 12;
        #5 sel = 13;
        #5 sel = 14;
        #5 sel = 15;
        #5 sel = 1'bx;
    end

    initial
    begin
        $monitor($time, " sel = %b, source %b", sel, source);
    end


    mux_32_bit_16x1 test(sel, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, source);
endmodule