class wishbone_driver extends uvm_driver#(wishbone_trans);

virtual wishbone_if vif;

`uvm_component_utils(wishbone_driver)

  wishbone_trans item;


    function new (string name = "wishbone_driver",uvm_component parent);
        super.new(name,parent);
    `uvm_info(get_type_name(),"Inside wishbone_driver constructor",UVM_HIGH)

    endfunction

   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if (!wishbone_if_config::get(this,"","vif", vif))
        `uvm_error("NOVIF","vif not set")  
    endfunction: build_phase


    task run_phase(uvm_phase phase);

        forever 
        begin
            item = wishbone_trans::type_id::create("item");
            seq_item_port.get_next_item(item);

            send_to_dut(item);
            seq_item_port.item_done();
        end
    endtask

      task send_to_dut(wishbone_trans my_req);
        `uvm_info(get_type_name(),$sformatf("Packet is \n%s", my_req.sprint()),UVM_LOW)
        @(negedge vif.clock);
      vif.dat_i <=   item.dat_i;
      vif.cyc_i <= item.cyc_i;   
      vif.stb_i <= item.stb_i;
      vif.test_number <= item.test_number;   
      vif.adr_i <= item.adr_i;   
      vif.we_i  <= item.we_i; 
      vif.rst_i <= item.rst_i; 
      
    endtask

    function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"I am here",UVM_HIGH)
    endfunction

endclass
