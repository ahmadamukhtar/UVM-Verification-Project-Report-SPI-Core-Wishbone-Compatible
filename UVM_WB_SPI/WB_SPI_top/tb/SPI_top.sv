module SPI_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import wishbone_pkg::*;
    import spi_pkg::*;
    
    `include "../sv/SPI_scoreboard.sv"
    `include "SPI_tb.sv"
    `include "SPI_test_lib.sv"

    initial begin
        uvm_config_db#(virtual wishbone_if)::set( null, "*wish*", "vif", hw_top.wish_vif);
        uvm_config_db#(virtual spi_if)::set( null, "*slave*", "vif", hw_top.spi_vif);
        run_test();
    end

endmodule
