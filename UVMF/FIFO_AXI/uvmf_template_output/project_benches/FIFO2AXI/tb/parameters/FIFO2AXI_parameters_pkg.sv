//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: This package contains test level parameters
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//


package FIFO2AXI_parameters_pkg;

  import uvmf_base_pkg_hdl::*;

  // pragma uvmf custom package_imports_additional begin 
  // pragma uvmf custom package_imports_additional end

  parameter bit FIFO_DATA_WIDTH = 128;
  parameter bit FIFO_ADDR_WIDTH = 32;
  parameter bit AXI_ADDR_WIDTH = 32;
  parameter bit AXI_WID_WIDTH = 4;
  parameter bit AXI_LEN_WIDTH = 4;
  parameter bit AXI_SIZE_WIDTH = 3;
  parameter bit AXI_BURST_WIDTH = 2;
  parameter bit AXI_LOCK_WIDTH = 2;
  parameter bit AXI_CACHE_WIDTH = 2;
  parameter bit AXI_PROT_WIDTH = 3;
  parameter bit AXI_STRB_WIDTH = 4;

  // These parameters are used to uniquely identify each interface.  The monitor_bfm and
  // driver_bfm are placed into and retrieved from the uvm_config_db using these string 
  // names as the field_name. The parameter is also used to enable transaction viewing 
  // from the command line for selected interfaces using the UVM command line processing.
  parameter string FIFO_agent_BFM  = "FIFO_agent_BFM"; /* [0] */
  parameter string AXI4_SLAVE_agent_BFM  = "AXI4_SLAVE_agent_BFM"; /* [1] */

  // pragma uvmf custom package_item_additional begin
  // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

