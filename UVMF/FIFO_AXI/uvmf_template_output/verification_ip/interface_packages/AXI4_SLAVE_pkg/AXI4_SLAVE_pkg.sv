//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    interface package that will run on the host simulator.
//
// CONTAINS:
//    - <AXI4_SLAVE_typedefs_hdl>
//    - <AXI4_SLAVE_typedefs.svh>
//    - <AXI4_SLAVE_transaction.svh>

//    - <AXI4_SLAVE_configuration.svh>
//    - <AXI4_SLAVE_driver.svh>
//    - <AXI4_SLAVE_monitor.svh>

//    - <AXI4_SLAVE_transaction_coverage.svh>
//    - <AXI4_SLAVE_sequence_base.svh>
//    - <AXI4_SLAVE_random_sequence.svh>

//    - <AXI4_SLAVE_responder_sequence.svh>
//    - <AXI4_SLAVE2reg_adapter.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package AXI4_SLAVE_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import AXI4_SLAVE_pkg_hdl::*;

   `include "uvm_macros.svh"

   // pragma uvmf custom package_imports_additional begin 
   // pragma uvmf custom package_imports_additional end
   `include "src/AXI4_SLAVE_macros.svh"

   export AXI4_SLAVE_pkg_hdl::*;
   
 

   // Parameters defined as HVL parameters

   `include "src/AXI4_SLAVE_typedefs.svh"
   `include "src/AXI4_SLAVE_transaction.svh"

   `include "src/AXI4_SLAVE_configuration.svh"
   `include "src/AXI4_SLAVE_driver.svh"
   `include "src/AXI4_SLAVE_monitor.svh"

   `include "src/AXI4_SLAVE_transaction_coverage.svh"
   `include "src/AXI4_SLAVE_sequence_base.svh"
   `include "src/AXI4_SLAVE_random_sequence.svh"

   `include "src/AXI4_SLAVE_responder_sequence.svh"
   `include "src/AXI4_SLAVE2reg_adapter.svh"

   `include "src/AXI4_SLAVE_agent.svh"

   // pragma uvmf custom package_item_additional begin
   // UVMF_CHANGE_ME : When adding new interface sequences to the src directory
   //    be sure to add the sequence file here so that it will be
   //    compiled as part of the interface package.  Be sure to place
   //    the new sequence after any base sequences of the new sequence.
   // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

