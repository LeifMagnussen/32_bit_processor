// Author: Matthew Tucsok

// write: 4 bits to be written to the flag register. Wire these to the flag output of the ALU

// read: 4 bits holding the current value of the flags. Wire these to the flag input of the ALU

module flags_register (write, read);
    input [3:0] write;
    output reg [3:0] read;

    always @ (write)
    begin
        read = write;
    end
endmodule