
class wishbone_sequencer extends uvm_sequencer #(wishbone_trans);
  `uvm_component_utils(wishbone_sequencer)
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : wishbone_sequencer
