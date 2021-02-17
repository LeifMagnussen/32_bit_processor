// Author: Matthew Tucsok

module addr_bus_mux_test;
    //Inputs
    reg select;
    reg [7:0] pc_address;
    reg [15:0] addr_bus_data_access;

    //Outputs
     wire [15:0] address_bus;

    initial
    begin

        #5 select = 0; pc_address = 8'd1; addr_bus_data_access = 16'd200;
        #5 select = 1; pc_address = 8'd1; addr_bus_data_access = 16'd200;
    end

    initial
    begin
        $monitor($time, " select = %b, address_bus %b", select, address_bus);
    end


    addr_bus_mux test(select, pc_address, addr_bus_data_access, address_bus);
endmodule