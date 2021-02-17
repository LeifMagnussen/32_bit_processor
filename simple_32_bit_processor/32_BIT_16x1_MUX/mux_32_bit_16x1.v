// Author: Matthew Tucsok

// sel: 4 bit selector that decides which of the 16 inputs should be put on the output. Parse these bits from the
// fetched instruction (either bits [15-18] or [11-14] for source MUXs' 1 and 2 respectively.

// Q0-Q15: 32 bit values from R0-R15.

// source: Output data to go to ALU.

module mux_32_bit_16x1 (sel, Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, source);
    input [31:0] Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15;
    input [3:0] sel;
    output reg [31:0] source;

    always @ *
    begin
        case (sel)
            4'd0: source = Q0;
            4'd1: source = Q1;
            4'd2: source = Q2;
            4'd3: source = Q3;
            4'd4: source = Q4;
            4'd5: source = Q5;
            4'd6: source = Q6;
            4'd7: source = Q7;
            4'd8: source = Q8;
            4'd9: source = Q9;
            4'd10: source = Q10;
            4'd11: source = Q11;
            4'd12: source = Q12;
            4'd13: source = Q13;
            4'd14: source = Q14;
            4'd15: source = Q15;
            default: source = {32{1'bz}};
        endcase
    end
endmodule