// Author: Matthew Tucsok

// select: Selects between program counter adress (0) or address to load/store from the memory controller (1).

// pc_address: 8 bit address from the program counter.

// addr_bus_data_access: 16 bit address to load/store data from the memory controller.

// address_bus: 16 bit address bus for accessing the RAM

module addr_bus_mux(select, pc_address, addr_bus_data_access, address_bus);
    input select;
    input [7:0] pc_address;
    input [15:0] addr_bus_data_access;
    output reg [15:0] address_bus;

    always @ *
    begin
        if (select)
            address_bus = addr_bus_data_access;
        else
            address_bus = pc_address;
    end
endmodule