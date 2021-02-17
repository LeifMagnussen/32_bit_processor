// Author: Matthew Tucsok

// enable: 16 bit output where only one bit can be a 1. Wire this to the enable of the registers.

// in: 4 bits fetched from 32 bit instruction. These 4 bits decide which bit is a one in enable. Parse these bits from
// the fetched instruction (bits [19-22].

module decoder_4to16 (in, enable);
    input [3:0] in;
    output reg [15:0] enable;

    always @ *
    begin
        case (in)
            4'd0: enable = 16'd1;
            4'd1: enable = 16'd2;
            4'd2: enable = 16'd4;
            4'd3: enable = 16'd8;
            4'd4: enable = 16'd16;
            4'd5: enable = 16'd32;
            4'd6: enable = 16'd64;
            4'd7: enable = 16'd128;
            4'd8: enable = 16'd256;
            4'd9: enable = 16'd512;
            4'd10: enable =  16'd1024;
            4'd11: enable =  16'd2048;
            4'd12: enable =  16'd4096;
            4'd13: enable =  16'd8192;
            4'd14: enable =  16'd16384;
            4'd15: enable =  16'd32768;
            default: enable = {16{1'bz}};
        endcase
    end
endmodule