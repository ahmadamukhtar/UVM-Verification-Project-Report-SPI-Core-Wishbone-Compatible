class wishbone_base_seq extends uvm_sequence #(wishbone_trans);

  // Required macro for sequences automation
  `uvm_object_utils(wishbone_base_seq)

  string phase_name;
  uvm_phase phaseh;
  // Constructor
  function new(string name="wishbone_base_seq");
    super.new(name);
  endfunction
  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body
  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body
endclass : wishbone_base_seq
///////////////////////////////////////////////////////////////////////reset_seq_wishbone
class wishbone_reset extends wishbone_base_seq;
  `uvm_object_utils(wishbone_reset)
   rand bit [7:0] test_no;
  function new(string name="wishbone_reset");
    super.new(name);
  endfunction
  virtual task body();
    `uvm_info(get_type_name(), "Executing wishbone_reset sequence", UVM_LOW)

      `uvm_do_with(req,
                  {
                   rst_i == 1'b1;
                   test_number == test_no; 
                   })
  endtask
endclass : wishbone_reset
/////////////////////////////////////////////////////////////////////////////////////wishbone_write_seq
class wishbone_write_seq extends wishbone_base_seq;                   
  `uvm_object_utils(wishbone_write_seq)
   rand bit [7:0] test_no;
  function new(string name="wishbone_write_seq");
    super.new(name);
  endfunction
  rand bit [1:0] addr_ctrl;
  rand bit [7:0] data_in_ctrl;
  virtual task body();
    `uvm_info(get_type_name(), "Executing wishbone_write_seq sequence", UVM_LOW)
      `uvm_do_with(req,
                  {
                   cyc_i == 1'b1; 
                   stb_i == 1'b1; 
                   adr_i == addr_ctrl;
                   we_i  == 1'b1;
                   dat_i == data_in_ctrl;
                   rst_i == 1'b0;
                   test_number == test_no;             
                   })
  endtask
endclass : wishbone_write_seq
/////////////////////////////////////////////////////////////////////////////////////wishbone_read_seq
class wishbone_read_seq extends wishbone_base_seq;
  `uvm_object_utils(wishbone_read_seq)
  function new(string name="wishbone_read_seq");
    super.new(name);
  endfunction
   rand bit [7:0] test_no; 
  rand bit [1:0] addr_ctrl;
  bit [7:0] read_data;  
  virtual task body();
    `uvm_info(get_type_name(), "Executing wishbone_read_seq sequence", UVM_LOW)
      `uvm_do_with(req,
                  {
                   cyc_i == 1'b1; 
                   stb_i == 1'b1; 
                   adr_i == addr_ctrl; 
                   we_i  == 1'b0;
                   rst_i == 1'b0;
                   test_number == test_no;
                   })
 
  endtask
endclass : wishbone_read_seq
////////////////////////////////////////////////////////////////////////////////seq_for reset_test
                 
 class reset_test extends wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(reset_test)
// Constructor
  function new(string name="reset_test");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building reset_test",UVM_LOW)
 
       `uvm_do(myseq_1) //reset
       
        `uvm_do_with(myseq_2,
    {
      addr_ctrl == 2'b00;
              test_no == 1;
      }) 
       
                `uvm_do_with(myseq_2,
    {
      addr_ctrl == 2'b01; 
              test_no == 1;
      }) 
    
                `uvm_do_with(myseq_2,
    {
      addr_ctrl == 2'b11; 
              test_no == 1;
      })  
        `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b00; //DATA REGISTER
        data_in_ctrl == 8'b11010000;
        test_no == 1;
        
      })
      
      
      
         `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b11010000;
                test_no == 1;
      })

  
  endtask

 endclass : reset_test
 ////////////////////////////  ////////////////////////////////////////////read_write betweem the the wishbone and spi 
  class wishbone_read_back_seq extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;   
  `uvm_object_utils(wishbone_read_back_seq)
// Constructor
  function new(string name="wishbone_read_back_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_read_back_seq",UVM_LOW)

  `uvm_do(myseq_1) //reset
         `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b00; //DATA REGISTER
        data_in_ctrl == 8'b11010000;
          test_no == 2;
      })      
          `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b11010000;
          test_no == 2;
      })   
    repeat(29) begin
       `uvm_do_with(myseq_2,
    {
      addr_ctrl == 2'b10; 
        test_no == 2;
      })    
      end

  endtask

 endclass : wishbone_read_back_seq  
  
 ////////////////////////////  ////////////////////////////////////////////seq for the write buffer full test
  class test_3 extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(test_3)
// Constructor
  function new(string name="test_3");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Test  test3 ",UVM_LOW)

      `uvm_do(myseq_1) //reset
     `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b00; //DATA REGISTER
        data_in_ctrl == 8'b11010000;
          test_no ==3;
          })
          repeat(2) begin
          `uvm_do_with(myseq_3,
       {
       
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b100;
          test_no == 3;
      })  
      end
      repeat(2) begin
            `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b101;
          test_no == 3;
      }) 
      end
      repeat(2) begin 
            `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b110;
          test_no == 3;
      }) 
      end
      repeat(2) begin  
          `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b111;
          test_no == 3;
      }) 
      end
        
      repeat(2) begin  
          `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b111;
          test_no == 3;
      }) 
      end  
               `uvm_do_with(myseq_2,
       {
      addr_ctrl == 2'b01; //DATA REGISTER
          test_no == 3;
      })  


  endtask

 endclass : test_3                     
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////seq for the collsion_test_write
  
   class test_4 extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(test_4)
// Constructor
  function new(string name="test_4");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Test  test4 ",UVM_LOW)

      `uvm_do(myseq_1) //reset
     `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b00; //DATA REGISTER
        data_in_ctrl == 8'b11010000;
          test_no ==4;
          })
          repeat(2) begin
          `uvm_do_with(myseq_3,
       {
       
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b100;
          test_no == 4;
      })  
      end
      repeat(2) begin
            `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b101;
          test_no == 4;
      }) 
      end
      repeat(2) begin 
            `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b110;
          test_no == 4;
      }) 
      end
      repeat(2) begin  
          `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b111;
          test_no == 4;
      }) 
      end
        
      repeat(2) begin  
          `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b111;
          test_no == 4;
      }) 
      
      end  
      
       repeat(10) begin  
          `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b111;
          test_no == 4;
      }) 
      end
      
               `uvm_do_with(myseq_2,
       {
      addr_ctrl == 2'b01; //DATA REGISTER
          test_no == 4;
      }) 
      
  endtask

 endclass : test_4                 
  
  
  
  //////////////////////////////////////////////////////               readbuffer full test
   class test_5 extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(test_5)
// Constructor
  function new(string name="test_5");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Test  test5 ",UVM_LOW)

      `uvm_do(myseq_1) //reset
     `uvm_do_with(myseq_3,
       {
      addr_ctrl == 2'b00; //DATA REGISTER
        data_in_ctrl == 8'b11010000;
          test_no ==5;
          })
          
          repeat(2) begin
          `uvm_do_with(myseq_3,
       {
       
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b100;
          test_no == 5;
      })  
      end
      
      repeat(2) begin
          `uvm_do_with(myseq_3,
       {
       
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b110;
          test_no == 5;
      })  
      end
      
      repeat(2) begin
          `uvm_do_with(myseq_3,
       {
       
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b111;
          test_no == 5;
      })  
      end
      
      repeat(2) begin
          `uvm_do_with(myseq_3,
       {
       
      addr_ctrl == 2'b10; //DATA REGISTER
        data_in_ctrl == 8'b11100;
          test_no == 5;
      })  
      end
      
    
    repeat(100) begin
               `uvm_do_with(myseq_2,
       {
      addr_ctrl == 2'b01; //DATA REGISTER
          test_no == 5;
      })  
      end
    

  endtask

 endclass : test_5 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
/*
class wishbone_custom_seq extends  wishbone_base_seq;
    wishbone_write_seq          myseq_1;
    wishbone_read_seq           myseq_2;
    
// Required macro for sequences automation
  `uvm_object_utils(wishbone_custom_seq)
// Constructor
  function new(string name="wishbone_custom_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_custom_seq",UVM_LOW)

  `uvm_do_with(myseq_1,
      {
        addr_ctrl == 2'b11; //for SPCR
        data_in_ctrl == 8'b11110000;
        
        })

  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b11; //for SPCR
        })

  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b10; //for SPCR
        })
  `uvm_do_with(myseq_1,
      {
        addr_ctrl == 2'b10; //for SPCR
        data_in_ctrl == 8'b11110111;
        
        })

  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b10; //for SPCR
        })
  endtask

  endclass : wishbone_custom_seq

class wishbone_reset_seq extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    
  `uvm_object_utils(wishbone_reset_seq)
// Constructor
  function new(string name="wishbone_reset_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_reset_seq",UVM_LOW)

  `uvm_do(myseq_1)

  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b00; 
      })

  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b01;
      })
  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b11;
        })
  endtask

  endclass : wishbone_reset_seq


class wishbone_interrupt_zero_seq extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(wishbone_interrupt_zero_seq)
// Constructor
  function new(string name="wishbone_interrupt_zero_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_interrupt_zero_seq",UVM_LOW)

  `uvm_do(myseq_1) //reset

  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b00; 
        data_in_ctrl == 8'b1101_0000;
      })

  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b10; 
        data_in_ctrl == 8'b1111_0111;
      })
repeat(19)
  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b01;
      })

  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b10;
      })
  endtask

  endclass : wishbone_interrupt_zero_seq

class wishbone_interrupt_two_seq extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(wishbone_interrupt_two_seq)
// Constructor
  function new(string name="wishbone_interrupt_two_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_interrupt_two_seq",UVM_LOW)

  `uvm_do(myseq_1) //reset
  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b00; 
        data_in_ctrl == 8'b1101_0000;
      })
  
  `uvm_do_with(myseq_3,  
      {
        addr_ctrl == 2'b11; //SPER REGISTER
        data_in_ctrl == 8'b0100_0000;
      })

repeat(2)
  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b10; //SPDR REGISTER
        data_in_ctrl == 8'b11110111;
      })

repeat(38)
  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b01; //STATUS REGISTER
      })
  endtask
  endclass : wishbone_interrupt_two_seq

class wishbone_interrupt_three_seq extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(wishbone_interrupt_three_seq)
// Constructor
  function new(string name="wishbone_interrupt_three_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_interrupt_three_seq",UVM_LOW)

  `uvm_do(myseq_1) //reset
  
  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b00; //CONTROL REGISTER
        data_in_ctrl == 8'b1101_0000;
      })

  `uvm_do_with(myseq_3,  
      {
        addr_ctrl == 2'b11; //SPER REGISTER
        data_in_ctrl == 8'b1000_0000;
      })

repeat(3)
  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b10; //SPDR REGISTER
        data_in_ctrl == 8'b11110111;
      })

repeat(49) //Issue data_out is b101 on first read
  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b01; //STATUS REGISTER
      })
  endtask
  endclass : wishbone_interrupt_three_seq


class wishbone_interrupt_four_seq extends  wishbone_base_seq;
    wishbone_reset              myseq_1;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(wishbone_interrupt_four_seq)
// Constructor
  function new(string name="wishbone_interrupt_four_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_interrupt_four_seq",UVM_LOW)

  `uvm_do(myseq_1) //reset

  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b00; //CONTROL REGISTER
        data_in_ctrl == 8'b1101_0000;
      })

  `uvm_do_with(myseq_3,  
      {
        addr_ctrl == 2'b11; //SPER REGISTER
        data_in_ctrl == 8'b1100_0000;
      })
repeat(4)
  `uvm_do_with(myseq_3,
      {
        addr_ctrl == 2'b10; //SPDR REGISTER
        data_in_ctrl == 8'b11110111;
      })

repeat(65) //Issue data_out is b101 on first read
  `uvm_do_with(myseq_2,
      {
        addr_ctrl == 2'b01; //STATUS REGISTER
      })
  endtask
endclass : wishbone_interrupt_four_seq

class wishbone_cpol_seq extends  wishbone_base_seq;
    wishbone_read_seq           myseq_2;
    wishbone_write_seq          myseq_3;

    
  `uvm_object_utils(wishbone_cpol_seq)
// Constructor
  function new(string name="wishbone_cpol_seq");
    super.new(name);
  endfunction
    rand bit [1:0] mode_set;
    bit [7:0] ctrl_reg_data;

    //[0] mode_set CPOL 0,CPHA 0
    //[1] mode_set CPOL 0,CPHA 1
    //[2] mode_set CPOL 1,CPHA 0
    //[3] mode_set CPOL 1,CPHA 1

// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_cpol_seq",UVM_LOW)

  `uvm_do_with(myseq_2,
    {
      addr_ctrl == 2'b00; //CONTROL REGISTER
    })

    ctrl_reg_data = myseq_2.read_data;
    

    $display("Current ctrl reg data %0d",ctrl_reg_data);

    case (mode_set)
      0:
        begin
            ctrl_reg_data[3:2] = 2'b00;
        end
      1:
        begin
          ctrl_reg_data[3:2] = 2'b01;
        end
      2:
        begin
          ctrl_reg_data[3:2] = 2'b10;
        end
      3:
        begin
          ctrl_reg_data[3:2] = 2'b11;
        end
    endcase

  `uvm_do_with(myseq_3,  
      {
        addr_ctrl == 2'b00; //CONTROL REGISTER
        data_in_ctrl == ctrl_reg_data;
      })
  endtask
endclass : wishbone_cpol_seq

class wishbone_spi_modes_seq extends  wishbone_base_seq;
    wishbone_cpol_seq              myseq_1;

    
  `uvm_object_utils(wishbone_spi_modes_seq)
// Constructor
  function new(string name="wishbone_spi_modes_seq");
    super.new(name);
  endfunction
    
// Sequence body definition
  virtual task body();
  `uvm_info(get_type_name(),"Building wishbone_spi_modes_seq",UVM_LOW)
  `uvm_do_with(myseq_1,
    {
      mode_set == 3; //SPI MODE
    })
  endtask
endclass : wishbone_spi_modes_seq */

