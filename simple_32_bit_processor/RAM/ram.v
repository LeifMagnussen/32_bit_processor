// Author: Matthew Tucsok

// Enable: Enables/disables RAM read/write capability.

// ReadWrite: Toggles between read and write. 1 is read while 0 is write.

// Address: 16 bit address of RAM.

// DataIn: 32 bit input data channel for RAM.

// DataOut: 32 bit output data channel for RAM.

module ram(Enable, ReadWrite, Address, DataIn, DataOut);
    input Enable, ReadWrite;
    input [31:0] DataIn;
    input [15:0] Address;
    output reg [31:0] DataOut;
    reg [31:0] Mem [65535:0]; // 2^16 x 32 memory

    always @ *
	   if (Enable)
             if (ReadWrite)
              DataOut = Mem[Address];  		//Read
             else
              Mem[Address] = DataIn;   		//Write
	   else DataOut = 32'bz;        	//High impedance state
endmodule
