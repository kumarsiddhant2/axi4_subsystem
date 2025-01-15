//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the AXI4_SLAVE interface signals.
//      It is instantiated once per AXI4_SLAVE bus.  Bus Functional Models, 
//      BFM's named AXI4_SLAVE_driver_bfm, are used to drive signals on the bus.
//      BFM's named AXI4_SLAVE_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(AXI4_SLAVE_bus.AWID_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWADDR_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWLEN_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWSIZE_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWBURST_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWLOCK_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWCACHE_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWPROT_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWVALID_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.AWREADY_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.WID_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.WDATA_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.WSTRB_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.WLAST_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.WVALID_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.WREADY_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.BID_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.BRESP_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.BVALID_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.BREADY_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARID_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARADDR_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARLEN_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARSIZE_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARBURST_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARLOCK_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARCACHE_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARPROT_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARVALID_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.ARREADY_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.RID_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.RDATA_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.RRESP_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.RLAST_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.RVALID_a), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.RREADY_a), // Agent input 
// .dut_signal_port(AXI4_SLAVE_bus.wr_rsp_en), // Agent output 
// .dut_signal_port(AXI4_SLAVE_bus.rd_rsp_en), // Agent output 

import uvmf_base_pkg_hdl::*;
import AXI4_SLAVE_pkg_hdl::*;

interface  AXI4_SLAVE_if 

  (
  input tri ACLK, 
  input tri ARESETn,
  inout tri [3:0] AWID_a,
  inout tri [31:0] AWADDR_a,
  inout tri [3:0] AWLEN_a,
  inout tri [2:0] AWSIZE_a,
  inout tri [1:0] AWBURST_a,
  inout tri [1:0] AWLOCK_a,
  inout tri [1:0] AWCACHE_a,
  inout tri [2:0] AWPROT_a,
  inout tri  AWVALID_a,
  inout tri  AWREADY_a,
  inout tri [3:0] WID_a,
  inout tri [63:0] WDATA_a,
  inout tri [3:0] WSTRB_a,
  inout tri  WLAST_a,
  inout tri  WVALID_a,
  inout tri  WREADY_a,
  inout tri [3:0] BID_a,
  inout tri [1:0] BRESP_a,
  inout tri  BVALID_a,
  inout tri  BREADY_a,
  inout tri [3:0] ARID_a,
  inout tri [31:0] ARADDR_a,
  inout tri [3:0] ARLEN_a,
  inout tri [2:0] ARSIZE_a,
  inout tri [1:0] ARBURST_a,
  inout tri [1:0] ARLOCK_a,
  inout tri [1:0] ARCACHE_a,
  inout tri [2:0] ARPROT_a,
  inout tri  ARVALID_a,
  inout tri  ARREADY_a,
  inout tri [3:0] RID_a,
  inout tri [63:0] RDATA_a,
  inout tri [1:0] RRESP_a,
  inout tri  RLAST_a,
  inout tri  RVALID_a,
  inout tri  RREADY_a,
  inout tri  wr_rsp_en,
  inout tri  rd_rsp_en
  );

modport monitor_port 
  (
  input ACLK,
  input ARESETn,
  input AWID_a,
  input AWADDR_a,
  input AWLEN_a,
  input AWSIZE_a,
  input AWBURST_a,
  input AWLOCK_a,
  input AWCACHE_a,
  input AWPROT_a,
  input AWVALID_a,
  input AWREADY_a,
  input WID_a,
  input WDATA_a,
  input WSTRB_a,
  input WLAST_a,
  input WVALID_a,
  input WREADY_a,
  input BID_a,
  input BRESP_a,
  input BVALID_a,
  input BREADY_a,
  input ARID_a,
  input ARADDR_a,
  input ARLEN_a,
  input ARSIZE_a,
  input ARBURST_a,
  input ARLOCK_a,
  input ARCACHE_a,
  input ARPROT_a,
  input ARVALID_a,
  input ARREADY_a,
  input RID_a,
  input RDATA_a,
  input RRESP_a,
  input RLAST_a,
  input RVALID_a,
  input RREADY_a,
  input wr_rsp_en,
  input rd_rsp_en
  );

modport initiator_port 
  (
  input ACLK,
  input ARESETn,
  input AWID_a,
  input AWADDR_a,
  input AWLEN_a,
  input AWSIZE_a,
  input AWBURST_a,
  input AWLOCK_a,
  input AWCACHE_a,
  input AWPROT_a,
  input AWVALID_a,
  output AWREADY_a,
  input WID_a,
  input WDATA_a,
  input WSTRB_a,
  input WLAST_a,
  input WVALID_a,
  output WREADY_a,
  output BID_a,
  output BRESP_a,
  output BVALID_a,
  input BREADY_a,
  input ARID_a,
  input ARADDR_a,
  input ARLEN_a,
  input ARSIZE_a,
  input ARBURST_a,
  input ARLOCK_a,
  input ARCACHE_a,
  input ARPROT_a,
  input ARVALID_a,
  output ARREADY_a,
  output RID_a,
  output RDATA_a,
  output RRESP_a,
  output RLAST_a,
  output RVALID_a,
  input RREADY_a,
  output wr_rsp_en,
  output rd_rsp_en
  );

modport responder_port 
  (
  input ACLK,
  input ARESETn,  
  output AWID_a,
  output AWADDR_a,
  output AWLEN_a,
  output AWSIZE_a,
  output AWBURST_a,
  output AWLOCK_a,
  output AWCACHE_a,
  output AWPROT_a,
  output AWVALID_a,
  input AWREADY_a,
  output WID_a,
  output WDATA_a,
  output WSTRB_a,
  output WLAST_a,
  output WVALID_a,
  input WREADY_a,
  input BID_a,
  input BRESP_a,
  input BVALID_a,
  output BREADY_a,
  output ARID_a,
  output ARADDR_a,
  output ARLEN_a,
  output ARSIZE_a,
  output ARBURST_a,
  output ARLOCK_a,
  output ARCACHE_a,
  output ARPROT_a,
  output ARVALID_a,
  input ARREADY_a,
  input RID_a,
  input RDATA_a,
  input RRESP_a,
  input RLAST_a,
  input RVALID_a,
  output RREADY_a,
  input wr_rsp_en,
  input rd_rsp_en
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

