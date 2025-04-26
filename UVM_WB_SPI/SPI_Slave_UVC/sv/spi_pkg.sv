package spi_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
typedef uvm_config_db#(virtual spi_if) spi_if_config;
`include "packet.sv"
`include "monitor.sv"
`include "sequencer.sv"
`include "seqs.sv"
`include "driver.sv"
`include "agent.sv"
`include "env.sv"
endpackage : spi_pkg
