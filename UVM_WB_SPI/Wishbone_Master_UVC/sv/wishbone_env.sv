

class wishbone_env extends uvm_env;

  wishbone_agent my_agent;
  `uvm_component_utils(wishbone_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  extern virtual function void build_phase(uvm_phase phase);


endclass : wishbone_env


  function void wishbone_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"Building wishbone ENV",UVM_HIGH)
     my_agent = wishbone_agent::type_id::create("my_agent",this);
  endfunction : build_phase
