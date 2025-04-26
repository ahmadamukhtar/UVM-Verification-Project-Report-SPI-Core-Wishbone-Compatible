

class wishbone_agent extends uvm_agent;

  protected uvm_active_passive_enum is_active = UVM_ACTIVE;
  wishbone_monitor          monitor;
  wishbone_driver           driver;
  wishbone_sequencer        sequencer;

  `uvm_component_utils(wishbone_agent)

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor = wishbone_monitor::type_id::create("monitor", this);
    if(is_active == UVM_ACTIVE) 
      begin
        sequencer = wishbone_sequencer::type_id::create("sequencer", this);
        driver    = wishbone_driver::type_id::create("driver", this);
      end
  endfunction : build_phase
   
  // connect_phase
  virtual function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase
endclass : wishbone_agent
