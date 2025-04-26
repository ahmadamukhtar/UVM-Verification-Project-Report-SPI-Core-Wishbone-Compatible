class SPI_scorboard extends uvm_scoreboard;
    `uvm_component_utils(SPI_scorboard)
     uvm_tlm_analysis_fifo  #(wishbone_trans)wishbone_in_fifo;
     uvm_tlm_analysis_fifo  #(slave_packet)slave_out_fifo;
    int num_error;

    wishbone_trans wishbone_in;
    slave_packet slave_out;

    bit [7:0] SPCR;
    bit [7:0] SPSR;
    bit [7:0] SPER;
    
    bit [7:0] Write_buffer[$:4];
    bit [7:0] Read_buffer[$:4];

    bit [1:0] write_replace;
    bit [1:0] read_replace;

    bit [2:0] interrupt_count;
    bit [7:0] fifo_data_o[$];
    bit [7:0]read_counter;
   bit [7:0]read;
   bit [7:0] write_fifo[$];
    bit [7:0]write_counter;
   
   
    function new(string name, uvm_component parent);
        super.new(name, parent);
        wishbone_in_fifo = new("wishbone_in_fifo", this);
        slave_out_fifo = new("slave_out_fifo", this);
        num_error = 0;
    endfunction
    
    
    task run_phase(uvm_phase phase);
     forever 
  //   fork
     /////////////////////////////////////////thread_1
     begin
          wishbone_in_fifo.get_peek_export.get(wishbone_in);
          if(wishbone_in.rst_i)begin
            SPCR = 8'h10;
            SPSR = 8'h05;
            SPER = 8'h00;
            write_replace = 0;
            read_replace = 0;
            interrupt_count = 0;
          end else if (wishbone_in.cyc_i && wishbone_in.stb_i) begin
            if (!wishbone_in.we_i)
            begin 
                if (read_counter < 3) begin
                fifo_data_o.push_front(wishbone_in.dat_o);               
                 $display("Read data is \n %b",wishbone_in.dat_o);
                 end
                 read_counter++;
                 $display("Read counter is %d", read_counter);
                 if(read_counter==3&&(wishbone_in.test_number==1)) reset_test();   
                 if(read_counter==25&&(wishbone_in.test_number==2)) read_write_test();  
                 if(read_counter==74&&(wishbone_in.test_number==5)) test_5(); 
                 if(read_counter==1&&(wishbone_in.test_number==4)) test_4(); 
                  if(read_counter==1&&(wishbone_in.test_number==3)) test_3(); 
            end
            else 
            begin
              if (wishbone_in.adr_i == 2)
                write_fifo.push_front(wishbone_in.dat_i);  // save input data to write buffer
            write_counter++;
            
              end
            
           end
         
         end
           
           
    endtask
   task reset_test();
           read=fifo_data_o.pop_back();
           if(read==8'b00010000) begin `uvm_info("SCB_RST_test","Control register Matched", UVM_LOW)  end
           else
           begin
            `uvm_error("SCB_RST_test","Control register Mis_matched")
            end
           read=fifo_data_o.pop_back();
           if(read==8'b00000101) begin `uvm_info("SCB_RST_test","Status register Matched", UVM_LOW)  end
           else
           begin
            `uvm_error("SCB_RST_test","Status register Mis_matched")
            end
           read=fifo_data_o.pop_back();
           if(read==8'h00) begin `uvm_info("SCB_RST_test","Extension register Matched", UVM_LOW)  end
           else
           begin
            `uvm_error("SCB_RST_test","Extension register Mis_matched")
            end
   endtask
   
   task read_write_test();
   
   bit [7:0] read_val;
     slave_out_fifo.get_peek_export.get(slave_out);
    
     if(slave_out.in_val == wishbone_in.dat_o)
      begin `uvm_info("SCB_RWT_test","In value Matched", UVM_LOW)  end
           else
           begin
            `uvm_error("SCB_RWT_test","In value Mis_matched")
            end
            
            read_val = write_fifo.pop_back();
            if(slave_out.out_val == read_val)
      begin `uvm_info("SCB_RWT_test","Out value Matched", UVM_LOW)  end
           else
           begin
            `uvm_error("SCB_RWT_test","Out value Mis_matched")
            end
   endtask
   
   
   
   task test_3();                   //write buffe  full test
       read=wishbone_in.dat_o;
      if(read==8'b1001)
      `uvm_info("read fifo full test ","the fifo buffer full matched",UVM_LOW)
      else `uvm_error("read fifo full test ","the fifo buffer full mis_matched")
   
   endtask
   
   
    
   task test_4();     //collsion_test_write
       read=wishbone_in.dat_o;      
    if(read==8'b11000100)
      `uvm_info("write fifo WCOL test ","the fifo buffer  WCOL matched",UVM_LOW)
      else `uvm_error("write fifo full test ","the fifo buffer WCOL mis_matched")
   
   endtask
   
     task test_5();                 // read_fifo_full_test
       read=wishbone_in.dat_o;
      if(read==8'b10000110)
      `uvm_info("read fifo full test ","the fifo read buffer full matched",UVM_LOW)
      else `uvm_error("read fifo full test ","the fifo read buffer full mis_matched")
   
   endtask
   
 
  
endclass
