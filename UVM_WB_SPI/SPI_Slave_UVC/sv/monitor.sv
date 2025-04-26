class slave_monitor extends uvm_monitor;
    `uvm_component_utils(slave_monitor)
    virtual interface spi_if vif;
    uvm_analysis_port #(slave_packet) mon2scoreboard_port;          //tlm port .................................................
    
    slave_packet pkt;
    
    int in_dex;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
        mon2scoreboard_port = new("slave_out", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(!(uvm_config_db#(virtual spi_if)::get(this, "*", "vif", vif)))
        `uvm_error(get_type_name(), "Failed to get VIF from config DB!")
    endfunction
    
    task run_phase(uvm_phase phase);
        mon_slave();
    endtask
        
    task mon_slave();
        forever begin
            pkt=slave_packet::type_id::create("Mon_slave_pkt", this);
            in_dex = 7;
         //   bit [7:0]rec;
            repeat(8)begin
              
            @(posedge vif.sck_o) 
            #2
            // trigger transaction at start of packet
            void'(begin_tr(pkt, "Slave_Monitor_Packet"));// For recording of monitor packet
               pkt.in_val[in_dex] = vif.miso_i;
                pkt.out_val[in_dex] = vif.mosi_o;
                pkt.miso_i = vif.miso_i;
                pkt.mosi_o = vif.mosi_o;
                in_dex--;
                // End transaction recording
                end_tr(pkt);
            
            end       
                `uvm_info(get_type_name(), $sformatf("Packet collected:\n%s", pkt.sprint()), UVM_NONE)  
            mon2scoreboard_port.write(pkt);              //data goes from spi to scoreboard
        end
    endtask
endclass
