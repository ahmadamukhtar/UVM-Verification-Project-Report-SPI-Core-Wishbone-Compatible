class slave_base_seq extends uvm_sequence #(slave_packet);
    `uvm_object_utils(slave_base_seq)

  function new(string name="yapp_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
      phase = starting_phase;
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask

  virtual task body();
    `uvm_info(get_type_name(), "Executing base_seqs", UVM_HIGH)
     repeat(5)
      `uvm_do(req)
  endtask

  task post_body();
    uvm_phase phase;
      phase = starting_phase;
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask

endclass : slave_base_seq

/*
class spi_read_sequence_seq extends  slave_base_seq;
    
  `uvm_object_utils(spi_read_sequence_seq)
// Constructor
  function new(string name="spi_read_sequence_seq");
    super.new(name);
  endfunction
    
  int i = 7;
    logic [7:0]j;
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building spi_read_sequence_seq",UVM_LOW)
  repeat(4)
  begin
  i=7;
  j=$random;
  repeat (8)
    begin
       //   pos== i;
      `uvm_do_with(req,  
          {
            in_val ==j; //DATA to DUT(Master)
            miso_i==in_val[i];
          })
            i--;
    end
    end
    
  endtask
  endclass : spi_read_sequence_seq*/
  class spi_read_sequence_seq extends  slave_base_seq;

  `uvm_object_utils(spi_read_sequence_seq)
// Constructor
  function new(string name="spi_read_sequence_seq");
    super.new(name);
  endfunction
  int i = 7;
    logic [7:0]j;
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building spi_read_sequence_seq",UVM_LOW)

  i=7;
 // j=$random;
  repeat (8)
    begin
      `uvm_do_with(req,  
          {
            //in_val ==j; //DATA to DUT(Master)
            in_val == 8'b11110110;
            miso_i==in_val[i];
          })
            i--;
    end
  endtask
  endclass : spi_read_sequence_seq
  //////////////////////////////////////////////////////////////////////////////////////////////////////
    class test_2 extends  slave_base_seq;

  `uvm_object_utils(test_2)
// Constructor
  function new(string name="test_2");
    super.new(name);
  endfunction
  int i = 7;
    logic [7:0]j;
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building spi_read_sequence_seq",UVM_LOW)
repeat(4)
begin
  i=7;
 // j=$random;
  repeat (8)
    begin
      `uvm_do_with(req,  
          {
            //in_val ==j; //DATA to DUT(Master)
            in_val == 8'b11110110;
            miso_i==in_val[i];
          })
            i--;
      end
    end
  endtask
  endclass : test_2
  
