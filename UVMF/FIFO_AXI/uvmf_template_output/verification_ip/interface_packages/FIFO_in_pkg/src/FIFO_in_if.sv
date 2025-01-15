//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the FIFO_in interface signals.
//      It is instantiated once per FIFO_in bus.  Bus Functional Models, 
//      BFM's named FIFO_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named FIFO_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(FIFO_in_bus.wr_en), // Agent output 
// .dut_signal_port(FIFO_in_bus.rd_en), // Agent output 
// .dut_signal_port(FIFO_in_bus.wr_data), // Agent output 
// .dut_signal_port(FIFO_in_bus.rd_data), // Agent input 
// .dut_signal_port(FIFO_in_bus.full), // Agent input 
// .dut_signal_port(FIFO_in_bus.empty), // Agent input 

import uvmf_base_pkg_hdl::*;
import FIFO_in_pkg_hdl::*;

interface  FIFO_in_if 

  (
  input tri clk, 
  input tri rst,
  inout tri  wr_en,
  inout tri  rd_en,
  inout tri [127:0] wr_data,
  inout tri [127:0] rd_data,
  inout tri  full,
  inout tri  empty
  );

modport monitor_port 
  (
  input clk,
  input rst,
  input wr_en,
  input rd_en,
  input wr_data,
  input rd_data,
  input full,
  input empty
  );

modport initiator_port 
  (
  input clk,
  input rst,
  output wr_en,
  output rd_en,
  output wr_data,
  input rd_data,
  input full,
  input empty
  );

modport responder_port 
  (
  input clk,
  input rst,  
  input wr_en,
  input rd_en,
  input wr_data,
  output rd_data,
  output full,
  output empty
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

