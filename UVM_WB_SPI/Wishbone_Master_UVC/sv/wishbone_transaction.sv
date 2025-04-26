class wishbone_trans extends uvm_sequence_item;     

  rand bit [7:0]            dat_i;
  rand bit                  cyc_i;
  rand bit                  stb_i;
  rand bit [1:0]            adr_i;
  rand bit                  we_i;
  rand bit                  rst_i;
  rand bit       [7:0]    test_number;
  bit                      inta_o;
  bit [7:0]                 dat_o;
  bit                       ack_o;
  
  `uvm_object_utils_begin(wishbone_trans)
    `uvm_field_int(dat_i, UVM_DEFAULT + UVM_BIN)
    `uvm_field_int(cyc_i, UVM_DEFAULT)
    `uvm_field_int(stb_i, UVM_DEFAULT)
    `uvm_field_int(adr_i, UVM_DEFAULT + UVM_BIN)
    `uvm_field_int(we_i, UVM_DEFAULT)
    `uvm_field_int(rst_i, UVM_DEFAULT)
    `uvm_field_int(test_number, UVM_DEFAULT)

    `uvm_field_int(inta_o, UVM_DEFAULT)
    `uvm_field_int(dat_o, UVM_DEFAULT + UVM_BIN)
    `uvm_field_int(ack_o, UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "wishbone_trans");
    super.new(name);
  endfunction : new

endclass : wishbone_trans
