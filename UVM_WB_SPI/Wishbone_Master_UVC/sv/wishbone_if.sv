interface wishbone_if (input bit clock);
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import wishbone_pkg::*;
  logic  [7:0]                 dat_i;
  logic                        cyc_i;
  logic                        stb_i;
  logic  [1:0]                 adr_i;
  logic                        we_i;
  logic                        rst_i;
  logic  [7:0]                 test_number;

  logic                        inta_o;
  logic  [7:0]                 dat_o;
  logic                        ack_o;
endinterface : wishbone_if


