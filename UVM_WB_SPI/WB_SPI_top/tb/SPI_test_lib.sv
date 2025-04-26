//////////////////////////////////////////////////////////////////////////////_test__1
class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  SPI_tb tb;
  uvm_objection obj;

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_int::set(this, "*", "recording_detail", UVM_FULL);


    tb = SPI_tb::type_id::create("tb", this);
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    obj = phase.get_objection();
    obj.set_drain_time(this, 10ns);
  endtask
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
endclass
//////////////////////////////////////////////////////////////////////////////_test__1
class TEST_1 extends base_test;
  `uvm_component_utils(TEST_1)
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_wrapper::set(this, "*wish*sequencer.run_phase",
                        "default_sequence",
                        reset_test::get_type());
                        
    uvm_config_wrapper::set(this, "*slave*sequencer.run_phase",
                        "default_sequence",
                        spi_read_sequence_seq::get_type());


  endfunction
endclass
///////////////////////////////////////////////////////////////////////////////////_test_2
class TEST_2 extends base_test;
  `uvm_component_utils(TEST_2)
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_wrapper::set(this, "*wish*sequencer.run_phase",
                        "default_sequence",
                        wishbone_read_back_seq::get_type());
                        
    uvm_config_wrapper::set(this, "*slave*sequencer.run_phase",
                        "default_sequence",
                        spi_read_sequence_seq::get_type());


  endfunction
endclass




///////////////////////////////////////////////////////////////////////////////////_test_3
class TEST_3 extends base_test;
  `uvm_component_utils(TEST_3)
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_wrapper::set(this, "*wish*sequencer.run_phase",
                        "default_sequence",
                        test_3::get_type());
                        
    uvm_config_wrapper::set(this, "*slave*sequencer.run_phase",
                        "default_sequence",
                        spi_read_sequence_seq::get_type());


  endfunction
endclass



///////////////////////////////////////////////////////////////////////////////////_test_4
class TEST_4 extends base_test;
  `uvm_component_utils(TEST_4)
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_wrapper::set(this, "*wish*sequencer.run_phase",
                        "default_sequence",
                        test_4::get_type());
                        
    uvm_config_wrapper::set(this, "*slave*sequencer.run_phase",
                        "default_sequence",
                        spi_read_sequence_seq::get_type());


  endfunction
endclass




///////////////////////////////////////////////////////////////////////////////////_test_5
class TEST_5 extends base_test;
  `uvm_component_utils(TEST_5)
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_wrapper::set(this, "*wish*sequencer.run_phase",
                        "default_sequence",
                        test_5::get_type());
                        
    uvm_config_wrapper::set(this, "*slave*sequencer.run_phase",
                        "default_sequence",
                        test_2::get_type());


  endfunction
endclass
