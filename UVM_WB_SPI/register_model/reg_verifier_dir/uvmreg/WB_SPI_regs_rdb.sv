//*************************************************************//
//   ** File Generated Automatically
//   ** Please donot edit manually
//*************************************************************//


package WB_SPI_reg_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import cdns_uvmreg_utils_pkg::*;

  bit no_factory = 0; 

/////////////////////////////////////////////////////
//                SPCR
/////////////////////////////////////////////////////
class SPCR_c extends cdns_uvm_reg;

  `uvm_object_utils(SPCR_c)
  rand uvm_reg_field SPR;
  rand uvm_reg_field CPHA;
  rand uvm_reg_field CPOL;
  rand uvm_reg_field MSTR;
  rand uvm_reg_field SPE;
  rand uvm_reg_field SPIE;
  
  covergroup wr_fld_covg;
    SPR: coverpoint SPR.value[1:0];
    CPHA: coverpoint CPHA.value[0:0];
    CPOL: coverpoint CPOL.value[0:0];
    MSTR: coverpoint MSTR.value[0:0];
    SPE: coverpoint SPE.value[0:0];
    SPIE: coverpoint SPIE.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    SPR: coverpoint SPR.value[1:0];
    CPHA: coverpoint CPHA.value[0:0];
    CPOL: coverpoint CPOL.value[0:0];
    MSTR: coverpoint MSTR.value[0:0];
    SPE: coverpoint SPE.value[0:0];
    SPIE: coverpoint SPIE.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    SPR = fld_set[0];
    CPHA = fld_set[1];
    CPOL = fld_set[2];
    MSTR = fld_set[3];
    SPE = fld_set[4];
    SPIE = fld_set[5];
  endfunction

  function new(input string name="SPCR_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                SPDR
/////////////////////////////////////////////////////
class SPDR_c extends cdns_uvm_reg;

  `uvm_object_utils(SPDR_c)
  rand uvm_reg_field WriteBuffer;
  
  covergroup wr_fld_covg;
    WriteBuffer: coverpoint WriteBuffer.value[7:0];
  endgroup
  covergroup rd_fld_covg;
    WriteBuffer: coverpoint WriteBuffer.value[7:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    WriteBuffer = fld_set[0];
  endfunction

  function new(input string name="SPDR_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                SPER
/////////////////////////////////////////////////////
class SPER_c extends cdns_uvm_reg;

  `uvm_object_utils(SPER_c)
  rand uvm_reg_field ESPR;
  rand uvm_reg_field ICNT;
  
  covergroup wr_fld_covg;
    ESPR: coverpoint ESPR.value[1:0];
    ICNT: coverpoint ICNT.value[1:0];
  endgroup
  covergroup rd_fld_covg;
    ESPR: coverpoint ESPR.value[1:0];
    ICNT: coverpoint ICNT.value[1:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    ESPR = fld_set[0];
    ICNT = fld_set[1];
  endfunction

  function new(input string name="SPER_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                SPSR
/////////////////////////////////////////////////////
class SPSR_c extends cdns_uvm_reg;

  `uvm_object_utils(SPSR_c)
  rand uvm_reg_field RFEMPTY;
  rand uvm_reg_field RFFULL;
  rand uvm_reg_field WFEMPTY;
  rand uvm_reg_field WFFULL;
  rand uvm_reg_field WCOL;
  rand uvm_reg_field SPIF;
  
  covergroup wr_fld_covg;
    RFEMPTY: coverpoint RFEMPTY.value[0:0];
    RFFULL: coverpoint RFFULL.value[0:0];
    WFEMPTY: coverpoint WFEMPTY.value[0:0];
    WFFULL: coverpoint WFFULL.value[0:0];
    WCOL: coverpoint WCOL.value[0:0];
    SPIF: coverpoint SPIF.value[0:0];
  endgroup
  covergroup rd_fld_covg;
    RFEMPTY: coverpoint RFEMPTY.value[0:0];
    RFFULL: coverpoint RFFULL.value[0:0];
    WFEMPTY: coverpoint WFEMPTY.value[0:0];
    WFFULL: coverpoint WFFULL.value[0:0];
    WCOL: coverpoint WCOL.value[0:0];
    SPIF: coverpoint SPIF.value[0:0];
  endgroup

  protected virtual function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    super.sample(data, byte_en, is_read, map);
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      if(!is_read) begin
          wr_fld_covg.sample();
      end
      if(is_read) begin
          rd_fld_covg.sample();
      end
    end
  endfunction

  virtual function void sample_values();
    super.sample_values();
    if (get_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg.sample();
      rd_fld_covg.sample();
    end
  endfunction

  virtual function void build();
    uvm_reg_field fld_set[$];
    uvm_reg_field_config_ta ta = get_field_config(getconfigUID());
    build_uvm_reg_fields(this, ta, fld_set);
    
    RFEMPTY = fld_set[0];
    RFFULL = fld_set[1];
    WFEMPTY = fld_set[2];
    WFFULL = fld_set[3];
    WCOL = fld_set[4];
    SPIF = fld_set[5];
  endfunction

  function new(input string name="SPSR_c");
    super.new(name, 8, build_coverage(UVM_CVR_FIELD_VALS));
    if (has_coverage(UVM_CVR_FIELD_VALS)) begin
      wr_fld_covg = new();
      rd_fld_covg = new();
    end
  endfunction

endclass


/////////////////////////////////////////////////////
//                WB_SPI_memory_WB_SPI_registers
/////////////////////////////////////////////////////
class WB_SPI_regs_c extends cdns_uvm_reg_block;

  `uvm_object_utils(WB_SPI_regs_c)
  rand SPCR_c SPCR;
  rand SPDR_c SPDR;
  rand SPER_c SPER;
  rand SPSR_c SPSR;



  virtual function void build();
    uvm_reg  reg_set[$];
    string config_path = get_hier_path();
    default_map = create_map(get_name(), `UVM_REG_ADDR_WIDTH'h0, 1, UVM_LITTLE_ENDIAN, 1);
    begin
       uvm_reg_config_ta ta = get_reg_config({"WB_SPI_regs", config_path});
       build_uvm_regs(default_map, this, null, ta, reg_set);
    end
    if(! $cast(SPCR, reg_set[0]))
      `uvm_error("UVM_REG", "SPCR register casting error")
    if(! $cast(SPDR, reg_set[1]))
      `uvm_error("UVM_REG", "SPDR register casting error")
    if(! $cast(SPER, reg_set[2]))
      `uvm_error("UVM_REG", "SPER register casting error")
    if(! $cast(SPSR, reg_set[3]))
      `uvm_error("UVM_REG", "SPSR register casting error")

  endfunction

  function new(input string name="WB_SPI_memory_WB_SPI_registers");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


/////////////////////////////////////////////////////
//                WB_SPI_regs
/////////////////////////////////////////////////////
class WB_SPI_regs_vendor_Cadence_Design_Systems_library_WB_SPI_Registers_version_1_0 extends cdns_uvm_reg_block;

  `uvm_object_utils(WB_SPI_regs_vendor_Cadence_Design_Systems_library_WB_SPI_Registers_version_1_0)

  uvm_reg_map default_map;
  uvm_reg_map WB_SPI_memory;
  rand WB_SPI_regs_c WB_SPI_memory_WB_SPI_registers;

  virtual function void build();
    WB_SPI_memory = create_map("WB_SPI_memory", `UVM_REG_ADDR_WIDTH'h0, 1, UVM_LITTLE_ENDIAN, 1);
    default_map = WB_SPI_memory;
    WB_SPI_memory_WB_SPI_registers = WB_SPI_regs_c::type_id::create("WB_SPI_memory_WB_SPI_registers", , get_full_name());
    WB_SPI_memory_WB_SPI_registers.configure(this);
    WB_SPI_memory_WB_SPI_registers.build();

    //Mapping WB_SPI_memory map
    WB_SPI_memory_WB_SPI_registers.default_map.add_parent_map(WB_SPI_memory,`UVM_REG_ADDR_WIDTH'h0);
    WB_SPI_memory.set_submap_offset(WB_SPI_memory_WB_SPI_registers.default_map, `UVM_REG_ADDR_WIDTH'h0);
    //Apply hdl_paths
    apply_hdl_paths(this);

  endfunction



  function new(input string name="WB_SPI_regs");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

endclass


//*************************************************//
//Factory Methods
//*************************************************//
class reg_verifier_factory extends cdns_factory_base;
   virtual function uvm_object create(string typename, string pathname,string objectname);
      case(typename)
         "SPCR_c": begin SPCR_c SPCR = new(objectname); create = SPCR;  end
         "SPDR_c": begin SPDR_c SPDR = new(objectname); create = SPDR;  end
         "SPER_c": begin SPER_c SPER = new(objectname); create = SPER;  end
         "SPSR_c": begin SPSR_c SPSR = new(objectname); create = SPSR;  end

      endcase
   endfunction
endclass


//get_factory() function to select the factory
function automatic cdns_factory_base get_factory(bit no_factory);
   static cdns_factory_base factory;
   if(factory == null) begin
      if(no_factory == 1) begin
         reg_verifier_factory rv_factory = new;
         factory = rv_factory;
      end
      else begin
         uvm_factory_proxy rv_factory = new;
         factory = rv_factory;
      end
   end
   cdns_uvmreg_utils_pkg::factory=factory;


   return factory;
endfunction
cdns_factory_base factory = get_factory(no_factory);

endpackage



