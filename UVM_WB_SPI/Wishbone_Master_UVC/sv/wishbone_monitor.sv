
class wishbone_monitor extends uvm_monitor;
  virtual wishbone_if vif;
  int packet_count = 1;

  uvm_analysis_port #(wishbone_trans) item_collected_port;
 
  wishbone_trans item;
  `uvm_component_utils(wishbone_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  function void build_phase(uvm_phase phase);
    if (!wishbone_if_config::get(this, get_full_name(),"vif", vif))
      `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
  endfunction: build_phase

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS", "Inside Run Phase!", UVM_LOW)
    @(negedge vif.clock);

    forever 
    begin
      item = wishbone_trans::type_id::create("item");
      @(posedge vif.clock);
      

      item.dat_i   = vif.dat_i;
      item.cyc_i   = vif.cyc_i;
      item.stb_i   = vif.stb_i;
      item.adr_i   = vif.adr_i;
      item.we_i    = vif.we_i;
      item.rst_i   = vif.rst_i;
      item.test_number = vif.test_number;

      @(negedge vif.clock);
   
      item.dat_o   = vif.dat_o;
      item.inta_o  = vif.inta_o;
      item.ack_o   = vif.ack_o;

      item_collected_port.write(item);
      `uvm_info(get_type_name(), $sformatf("Sending Packet :\n%s \n packet no: %d \n", item.sprint(),packet_count), UVM_LOW)
      packet_count++;

    end
        
  endtask: run_phase



endclass : wishbone_monitor
