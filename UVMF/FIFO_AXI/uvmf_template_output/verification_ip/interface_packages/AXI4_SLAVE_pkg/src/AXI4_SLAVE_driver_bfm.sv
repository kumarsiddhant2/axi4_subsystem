//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the AXI4_SLAVE signal driving.  It is
//     accessed by the uvm AXI4_SLAVE driver through a virtual interface
//     handle in the AXI4_SLAVE configuration.  It drives the singals passed
//     in through the port connection named bus of type AXI4_SLAVE_if.
//
//     Input signals from the AXI4_SLAVE_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within AXI4_SLAVE_if based on INITIATOR/RESPONDER and/or
//     ARBITRATION/GRANT status.  
//
//     The output signal connections are as follows:
//        signal_o -> bus.signal
//
//                                                                                           
//      Interface functions and tasks used by UVM components:
//
//             configure:
//                   This function gets configuration attributes from the
//                   UVM driver to set any required BFM configuration
//                   variables such as 'initiator_responder'.                                       
//                                                                                           
//             initiate_and_get_response:
//                   This task is used to perform signaling activity for initiating
//                   a protocol transfer.  The task initiates the transfer, using
//                   input data from the initiator struct.  Then the task captures
//                   response data, placing the data into the response struct.
//                   The response struct is returned to the driver class.
//
//             respond_and_wait_for_next_transfer:
//                   This task is used to complete a current transfer as a responder
//                   and then wait for the initiator to start the next transfer.
//                   The task uses data in the responder struct to drive protocol
//                   signals to complete the transfer.  The task then waits for 
//                   the next transfer.  Once the next transfer begins, data from
//                   the initiator is placed into the initiator struct and sent
//                   to the responder sequence for processing to determine 
//                   what data to respond with.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import AXI4_SLAVE_pkg_hdl::*;
`include "src/AXI4_SLAVE_macros.svh"

interface AXI4_SLAVE_driver_bfm 
  (AXI4_SLAVE_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute AXI4_SLAVE_driver_bfm partition_interface_xif

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri ACLK_i;
  tri ARESETn_i;

  // Signal list (all signals are capable of being inputs and outputs for the sake
  // of supporting both INITIATOR and RESPONDER mode operation. Expectation is that 
  // directionality in the config file was from the point-of-view of the INITIATOR

  // INITIATOR mode input signals
  tri [3:0] AWID_a_i;
  reg [3:0] AWID_a_o = 'b0;
  tri [31:0] AWADDR_a_i;
  reg [31:0] AWADDR_a_o = 'b0;
  tri [3:0] AWLEN_a_i;
  reg [3:0] AWLEN_a_o = 'b0;
  tri [2:0] AWSIZE_a_i;
  reg [2:0] AWSIZE_a_o = 'b0;
  tri [1:0] AWBURST_a_i;
  reg [1:0] AWBURST_a_o = 'b0;
  tri [1:0] AWLOCK_a_i;
  reg [1:0] AWLOCK_a_o = 'b0;
  tri [1:0] AWCACHE_a_i;
  reg [1:0] AWCACHE_a_o = 'b0;
  tri [2:0] AWPROT_a_i;
  reg [2:0] AWPROT_a_o = 'b0;
  tri  AWVALID_a_i;
  reg  AWVALID_a_o = 'b0;
  tri [3:0] WID_a_i;
  reg [3:0] WID_a_o = 'b0;
  tri [63:0] WDATA_a_i;
  reg [63:0] WDATA_a_o = 'b0;
  tri [3:0] WSTRB_a_i;
  reg [3:0] WSTRB_a_o = 'b0;
  tri  WLAST_a_i;
  reg  WLAST_a_o = 'b0;
  tri  WVALID_a_i;
  reg  WVALID_a_o = 'b0;
  tri  BREADY_a_i;
  reg  BREADY_a_o = 'b0;
  tri [3:0] ARID_a_i;
  reg [3:0] ARID_a_o = 'b0;
  tri [31:0] ARADDR_a_i;
  reg [31:0] ARADDR_a_o = 'b0;
  tri [3:0] ARLEN_a_i;
  reg [3:0] ARLEN_a_o = 'b0;
  tri [2:0] ARSIZE_a_i;
  reg [2:0] ARSIZE_a_o = 'b0;
  tri [1:0] ARBURST_a_i;
  reg [1:0] ARBURST_a_o = 'b0;
  tri [1:0] ARLOCK_a_i;
  reg [1:0] ARLOCK_a_o = 'b0;
  tri [1:0] ARCACHE_a_i;
  reg [1:0] ARCACHE_a_o = 'b0;
  tri [2:0] ARPROT_a_i;
  reg [2:0] ARPROT_a_o = 'b0;
  tri  ARVALID_a_i;
  reg  ARVALID_a_o = 'b0;
  tri  RREADY_a_i;
  reg  RREADY_a_o = 'b0;

  // INITIATOR mode output signals
  tri  AWREADY_a_i;
  reg  AWREADY_a_o = 'b0;
  tri  WREADY_a_i;
  reg  WREADY_a_o = 'b0;
  tri [3:0] BID_a_i;
  reg [3:0] BID_a_o = 'b0;
  tri [1:0] BRESP_a_i;
  reg [1:0] BRESP_a_o = 'b0;
  tri  BVALID_a_i;
  reg  BVALID_a_o = 'b0;
  tri  ARREADY_a_i;
  reg  ARREADY_a_o = 'b0;
  tri [3:0] RID_a_i;
  reg [3:0] RID_a_o = 'b0;
  tri [63:0] RDATA_a_i;
  reg [63:0] RDATA_a_o = 'b0;
  tri [1:0] RRESP_a_i;
  reg [1:0] RRESP_a_o = 'b0;
  tri  RLAST_a_i;
  reg  RLAST_a_o = 'b0;
  tri  RVALID_a_i;
  reg  RVALID_a_o = 'b0;
  tri  wr_rsp_en_i;
  reg  wr_rsp_en_o = 'b0;
  tri  rd_rsp_en_i;
  reg  rd_rsp_en_o = 'b0;

  // Bi-directional signals
  

  assign ACLK_i = bus.ACLK;
  assign ARESETn_i = bus.ARESETn;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)
  assign AWID_a_i = bus.AWID_a;
  assign bus.AWID_a = (initiator_responder == RESPONDER) ? AWID_a_o : 'bz;
  assign AWADDR_a_i = bus.AWADDR_a;
  assign bus.AWADDR_a = (initiator_responder == RESPONDER) ? AWADDR_a_o : 'bz;
  assign AWLEN_a_i = bus.AWLEN_a;
  assign bus.AWLEN_a = (initiator_responder == RESPONDER) ? AWLEN_a_o : 'bz;
  assign AWSIZE_a_i = bus.AWSIZE_a;
  assign bus.AWSIZE_a = (initiator_responder == RESPONDER) ? AWSIZE_a_o : 'bz;
  assign AWBURST_a_i = bus.AWBURST_a;
  assign bus.AWBURST_a = (initiator_responder == RESPONDER) ? AWBURST_a_o : 'bz;
  assign AWLOCK_a_i = bus.AWLOCK_a;
  assign bus.AWLOCK_a = (initiator_responder == RESPONDER) ? AWLOCK_a_o : 'bz;
  assign AWCACHE_a_i = bus.AWCACHE_a;
  assign bus.AWCACHE_a = (initiator_responder == RESPONDER) ? AWCACHE_a_o : 'bz;
  assign AWPROT_a_i = bus.AWPROT_a;
  assign bus.AWPROT_a = (initiator_responder == RESPONDER) ? AWPROT_a_o : 'bz;
  assign AWVALID_a_i = bus.AWVALID_a;
  assign bus.AWVALID_a = (initiator_responder == RESPONDER) ? AWVALID_a_o : 'bz;
  assign WID_a_i = bus.WID_a;
  assign bus.WID_a = (initiator_responder == RESPONDER) ? WID_a_o : 'bz;
  assign WDATA_a_i = bus.WDATA_a;
  assign bus.WDATA_a = (initiator_responder == RESPONDER) ? WDATA_a_o : 'bz;
  assign WSTRB_a_i = bus.WSTRB_a;
  assign bus.WSTRB_a = (initiator_responder == RESPONDER) ? WSTRB_a_o : 'bz;
  assign WLAST_a_i = bus.WLAST_a;
  assign bus.WLAST_a = (initiator_responder == RESPONDER) ? WLAST_a_o : 'bz;
  assign WVALID_a_i = bus.WVALID_a;
  assign bus.WVALID_a = (initiator_responder == RESPONDER) ? WVALID_a_o : 'bz;
  assign BREADY_a_i = bus.BREADY_a;
  assign bus.BREADY_a = (initiator_responder == RESPONDER) ? BREADY_a_o : 'bz;
  assign ARID_a_i = bus.ARID_a;
  assign bus.ARID_a = (initiator_responder == RESPONDER) ? ARID_a_o : 'bz;
  assign ARADDR_a_i = bus.ARADDR_a;
  assign bus.ARADDR_a = (initiator_responder == RESPONDER) ? ARADDR_a_o : 'bz;
  assign ARLEN_a_i = bus.ARLEN_a;
  assign bus.ARLEN_a = (initiator_responder == RESPONDER) ? ARLEN_a_o : 'bz;
  assign ARSIZE_a_i = bus.ARSIZE_a;
  assign bus.ARSIZE_a = (initiator_responder == RESPONDER) ? ARSIZE_a_o : 'bz;
  assign ARBURST_a_i = bus.ARBURST_a;
  assign bus.ARBURST_a = (initiator_responder == RESPONDER) ? ARBURST_a_o : 'bz;
  assign ARLOCK_a_i = bus.ARLOCK_a;
  assign bus.ARLOCK_a = (initiator_responder == RESPONDER) ? ARLOCK_a_o : 'bz;
  assign ARCACHE_a_i = bus.ARCACHE_a;
  assign bus.ARCACHE_a = (initiator_responder == RESPONDER) ? ARCACHE_a_o : 'bz;
  assign ARPROT_a_i = bus.ARPROT_a;
  assign bus.ARPROT_a = (initiator_responder == RESPONDER) ? ARPROT_a_o : 'bz;
  assign ARVALID_a_i = bus.ARVALID_a;
  assign bus.ARVALID_a = (initiator_responder == RESPONDER) ? ARVALID_a_o : 'bz;
  assign RREADY_a_i = bus.RREADY_a;
  assign bus.RREADY_a = (initiator_responder == RESPONDER) ? RREADY_a_o : 'bz;


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.
  assign bus.AWREADY_a = (initiator_responder == INITIATOR) ? AWREADY_a_o : 'bz;
  assign AWREADY_a_i = bus.AWREADY_a;
  assign bus.WREADY_a = (initiator_responder == INITIATOR) ? WREADY_a_o : 'bz;
  assign WREADY_a_i = bus.WREADY_a;
  assign bus.BID_a = (initiator_responder == INITIATOR) ? BID_a_o : 'bz;
  assign BID_a_i = bus.BID_a;
  assign bus.BRESP_a = (initiator_responder == INITIATOR) ? BRESP_a_o : 'bz;
  assign BRESP_a_i = bus.BRESP_a;
  assign bus.BVALID_a = (initiator_responder == INITIATOR) ? BVALID_a_o : 'bz;
  assign BVALID_a_i = bus.BVALID_a;
  assign bus.ARREADY_a = (initiator_responder == INITIATOR) ? ARREADY_a_o : 'bz;
  assign ARREADY_a_i = bus.ARREADY_a;
  assign bus.RID_a = (initiator_responder == INITIATOR) ? RID_a_o : 'bz;
  assign RID_a_i = bus.RID_a;
  assign bus.RDATA_a = (initiator_responder == INITIATOR) ? RDATA_a_o : 'bz;
  assign RDATA_a_i = bus.RDATA_a;
  assign bus.RRESP_a = (initiator_responder == INITIATOR) ? RRESP_a_o : 'bz;
  assign RRESP_a_i = bus.RRESP_a;
  assign bus.RLAST_a = (initiator_responder == INITIATOR) ? RLAST_a_o : 'bz;
  assign RLAST_a_i = bus.RLAST_a;
  assign bus.RVALID_a = (initiator_responder == INITIATOR) ? RVALID_a_o : 'bz;
  assign RVALID_a_i = bus.RVALID_a;
  assign bus.wr_rsp_en = (initiator_responder == INITIATOR) ? wr_rsp_en_o : 'bz;
  assign wr_rsp_en_i = bus.wr_rsp_en;
  assign bus.rd_rsp_en = (initiator_responder == INITIATOR) ? rd_rsp_en_o : 'bz;
  assign rd_rsp_en_i = bus.rd_rsp_en;

  // Proxy handle to UVM driver
  AXI4_SLAVE_pkg::AXI4_SLAVE_driver   proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in AXI4_SLAVE_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from AXI4_SLAVE_driver to this BFM
  // ****************************************************************************
  `AXI4_SLAVE_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by AXI4_SLAVE_driver and AXI4_SLAVE_driver_bfm
  // to communicate initiator driven data to AXI4_SLAVE_driver_bfm.           
  `AXI4_SLAVE_INITIATOR_STRUCT
    AXI4_SLAVE_initiator_s initiator_struct;
  // Responder macro used by AXI4_SLAVE_driver and AXI4_SLAVE_driver_bfm
  // to communicate Responder driven data to AXI4_SLAVE_driver_bfm.
  `AXI4_SLAVE_RESPONDER_STRUCT
    AXI4_SLAVE_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( negedge ARESETn_i )
     begin
       // RESPONDER mode output signals
       AWID_a_o <= 'b0;
       AWADDR_a_o <= 'b0;
       AWLEN_a_o <= 'b0;
       AWSIZE_a_o <= 'b0;
       AWBURST_a_o <= 'b0;
       AWLOCK_a_o <= 'b0;
       AWCACHE_a_o <= 'b0;
       AWPROT_a_o <= 'b0;
       AWVALID_a_o <= 'b0;
       WID_a_o <= 'b0;
       WDATA_a_o <= 'b0;
       WSTRB_a_o <= 'b0;
       WLAST_a_o <= 'b0;
       WVALID_a_o <= 'b0;
       BREADY_a_o <= 'b0;
       ARID_a_o <= 'b0;
       ARADDR_a_o <= 'b0;
       ARLEN_a_o <= 'b0;
       ARSIZE_a_o <= 'b0;
       ARBURST_a_o <= 'b0;
       ARLOCK_a_o <= 'b0;
       ARCACHE_a_o <= 'b0;
       ARPROT_a_o <= 'b0;
       ARVALID_a_o <= 'b0;
       RREADY_a_o <= 'b0;
       // INITIATOR mode output signals
       AWREADY_a_o <= 'b0;
       WREADY_a_o <= 'b0;
       BID_a_o <= 'b0;
       BRESP_a_o <= 'b0;
       BVALID_a_o <= 'b0;
       ARREADY_a_o <= 'b0;
       RID_a_o <= 'b0;
       RDATA_a_o <= 'b0;
       RRESP_a_o <= 'b0;
       RLAST_a_o <= 'b0;
       RVALID_a_o <= 'b0;
       wr_rsp_en_o <= 'b0;
       rd_rsp_en_o <= 'b0;
       // Bi-directional signals
 
     end    
// pragma uvmf custom reset_condition_and_response end

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the driver BFM.  It is called by the driver within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the driver BFM needs to be aware of the new configuration 
  // variables.
  //

  function void configure(AXI4_SLAVE_configuration_s AXI4_SLAVE_configuration_arg); // pragma tbx xtf  
    initiator_responder = AXI4_SLAVE_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction                                                                             

// pragma uvmf custom initiate_and_get_response begin
// ****************************************************************************
// UVMF_CHANGE_ME
// This task is used by an initator.  The task first initiates a transfer then
// waits for the responder to complete the transfer.
    task initiate_and_get_response( 
       // This argument passes transaction variables used by an initiator
       // to perform the initial part of a protocol transfer.  The values
       // come from a sequence item created in a sequence.
       input AXI4_SLAVE_initiator_s AXI4_SLAVE_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output AXI4_SLAVE_responder_s AXI4_SLAVE_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the AXI4_SLAVE_initiator_struct:
       //   bit [31:0] awaddr ;
       //   awid_e awid ;
       //   bit [7:0] awlen ;
       //   awsize_e awsize ;
       //   awburst_e awburst ;
       //   awlock_e awlock ;
       //   awcache_e awcache ;
       //   bit [3:0] awqos ;
       //   awprot_e awprot ;
       //   endian_e endian ;
       //   bit [31:0] wdata ;
       //   bit [3:0] wstrb ;
       //   bit wlast ;
       //   bit [3:0] wuser ;
       //   bid_e bid ;
       //   bresp_e bresp ;
       //   bit [3:0] buser ;
       //   arid_e arid ;
       //   bit [31:0] araddr ;
       //   bit [7:0] arlen ;
       //   arsize_e arsize ;
       //   arburst_e arburst ;
       //   arlock_e arlock ;
       //   arcache_e arcache ;
       //   arprot_e arprot ;
       //   bit arregion ;
       //   bit [3:0] arqos ;
       //   rid_e rid ;
       //   bit [31:0] rdata ;
       //   bit rlast ;
       //   bit rvalid ;
       //   rresp_e rresp ;
       //   bit [3:0] ruser ;
       //   int no_of_wait_states ;
       //   tx_type_e tx_type ;
       //   transfer_type_e transfer_type ;
       //   int wait_count_write_address_channel ;
       //   int wait_count_write_data_channel ;
       //   int wait_count_write_response_channel ;
       //   int wait_count_read_address_channel ;
       //   int wait_count_read_data_channel ;
       //   int outstanding_write_tx ;
       //   int outstanding_read_tx ;
       // Members within the AXI4_SLAVE_responder_struct:
       //   bit [31:0] awaddr ;
       //   awid_e awid ;
       //   bit [7:0] awlen ;
       //   awsize_e awsize ;
       //   awburst_e awburst ;
       //   awlock_e awlock ;
       //   awcache_e awcache ;
       //   bit [3:0] awqos ;
       //   awprot_e awprot ;
       //   endian_e endian ;
       //   bit [31:0] wdata ;
       //   bit [3:0] wstrb ;
       //   bit wlast ;
       //   bit [3:0] wuser ;
       //   bid_e bid ;
       //   bresp_e bresp ;
       //   bit [3:0] buser ;
       //   arid_e arid ;
       //   bit [31:0] araddr ;
       //   bit [7:0] arlen ;
       //   arsize_e arsize ;
       //   arburst_e arburst ;
       //   arlock_e arlock ;
       //   arcache_e arcache ;
       //   arprot_e arprot ;
       //   bit arregion ;
       //   bit [3:0] arqos ;
       //   rid_e rid ;
       //   bit [31:0] rdata ;
       //   bit rlast ;
       //   bit rvalid ;
       //   rresp_e rresp ;
       //   bit [3:0] ruser ;
       //   int no_of_wait_states ;
       //   tx_type_e tx_type ;
       //   transfer_type_e transfer_type ;
       //   int wait_count_write_address_channel ;
       //   int wait_count_write_data_channel ;
       //   int wait_count_write_response_channel ;
       //   int wait_count_read_address_channel ;
       //   int wait_count_read_data_channel ;
       //   int outstanding_write_tx ;
       //   int outstanding_read_tx ;
       initiator_struct = AXI4_SLAVE_initiator_struct;
       //
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge ACLK_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available initiator input and inout signals listed.
       //    Initiator input signals
       //      AXI4_SLAVE_responder_struct.xyz = AWID_a_i;  //    [3:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWADDR_a_i;  //    [31:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWLEN_a_i;  //    [3:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWSIZE_a_i;  //    [2:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWBURST_a_i;  //    [1:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWLOCK_a_i;  //    [1:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWCACHE_a_i;  //    [1:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWPROT_a_i;  //    [2:0] 
       //      AXI4_SLAVE_responder_struct.xyz = AWVALID_a_i;  //     
       //      AXI4_SLAVE_responder_struct.xyz = WID_a_i;  //    [3:0] 
       //      AXI4_SLAVE_responder_struct.xyz = WDATA_a_i;  //    [63:0] 
       //      AXI4_SLAVE_responder_struct.xyz = WSTRB_a_i;  //    [3:0] 
       //      AXI4_SLAVE_responder_struct.xyz = WLAST_a_i;  //     
       //      AXI4_SLAVE_responder_struct.xyz = WVALID_a_i;  //     
       //      AXI4_SLAVE_responder_struct.xyz = BREADY_a_i;  //     
       //      AXI4_SLAVE_responder_struct.xyz = ARID_a_i;  //    [3:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARADDR_a_i;  //    [31:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARLEN_a_i;  //    [3:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARSIZE_a_i;  //    [2:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARBURST_a_i;  //    [1:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARLOCK_a_i;  //    [1:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARCACHE_a_i;  //    [1:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARPROT_a_i;  //    [2:0] 
       //      AXI4_SLAVE_responder_struct.xyz = ARVALID_a_i;  //     
       //      AXI4_SLAVE_responder_struct.xyz = RREADY_a_i;  //     
       //    Initiator inout signals
       //    How to assign a signal from an initiator struct member named xyz.   
       //    All available initiator output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Initiator output signals
       //      AWREADY_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //      WREADY_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //      BID_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //    [3:0] 
       //      BRESP_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //    [1:0] 
       //      BVALID_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //      ARREADY_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //      RID_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //    [3:0] 
       //      RDATA_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //    [63:0] 
       //      RRESP_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //    [1:0] 
       //      RLAST_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //      RVALID_a_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //      wr_rsp_en_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //      rd_rsp_en_o <= AXI4_SLAVE_initiator_struct.xyz;  //     
       //    Initiator inout signals
    // Initiate a transfer using the data received.
    @(posedge ACLK_i);
    @(posedge ACLK_i);
    // Wait for the responder to complete the transfer then place the responder data into 
    // AXI4_SLAVE_responder_struct.
    @(posedge ACLK_i);
    @(posedge ACLK_i);
    responder_struct = AXI4_SLAVE_responder_struct;
  endtask        
// pragma uvmf custom initiate_and_get_response end

// pragma uvmf custom respond_and_wait_for_next_transfer begin
// ****************************************************************************
// The first_transfer variable is used to prevent completing a transfer in the 
// first call to this task.  For the first call to this task, there is not
// current transfer to complete.
bit first_transfer=1;

// UVMF_CHANGE_ME
// This task is used by a responder.  The task first completes the current 
// transfer in progress then waits for the initiator to start the next transfer.
  task respond_and_wait_for_next_transfer( 
       // This argument is used to send data received from the initiator
       // back to the sequence item.  The sequence determines how to respond.
       output AXI4_SLAVE_initiator_s AXI4_SLAVE_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input AXI4_SLAVE_responder_s AXI4_SLAVE_responder_struct 
       );// pragma tbx xtf   
  // Variables within the AXI4_SLAVE_initiator_struct:
  //   bit [31:0] awaddr ;
  //   awid_e awid ;
  //   bit [7:0] awlen ;
  //   awsize_e awsize ;
  //   awburst_e awburst ;
  //   awlock_e awlock ;
  //   awcache_e awcache ;
  //   bit [3:0] awqos ;
  //   awprot_e awprot ;
  //   endian_e endian ;
  //   bit [31:0] wdata ;
  //   bit [3:0] wstrb ;
  //   bit wlast ;
  //   bit [3:0] wuser ;
  //   bid_e bid ;
  //   bresp_e bresp ;
  //   bit [3:0] buser ;
  //   arid_e arid ;
  //   bit [31:0] araddr ;
  //   bit [7:0] arlen ;
  //   arsize_e arsize ;
  //   arburst_e arburst ;
  //   arlock_e arlock ;
  //   arcache_e arcache ;
  //   arprot_e arprot ;
  //   bit arregion ;
  //   bit [3:0] arqos ;
  //   rid_e rid ;
  //   bit [31:0] rdata ;
  //   bit rlast ;
  //   bit rvalid ;
  //   rresp_e rresp ;
  //   bit [3:0] ruser ;
  //   int no_of_wait_states ;
  //   tx_type_e tx_type ;
  //   transfer_type_e transfer_type ;
  //   int wait_count_write_address_channel ;
  //   int wait_count_write_data_channel ;
  //   int wait_count_write_response_channel ;
  //   int wait_count_read_address_channel ;
  //   int wait_count_read_data_channel ;
  //   int outstanding_write_tx ;
  //   int outstanding_read_tx ;
  // Variables within the AXI4_SLAVE_responder_struct:
  //   bit [31:0] awaddr ;
  //   awid_e awid ;
  //   bit [7:0] awlen ;
  //   awsize_e awsize ;
  //   awburst_e awburst ;
  //   awlock_e awlock ;
  //   awcache_e awcache ;
  //   bit [3:0] awqos ;
  //   awprot_e awprot ;
  //   endian_e endian ;
  //   bit [31:0] wdata ;
  //   bit [3:0] wstrb ;
  //   bit wlast ;
  //   bit [3:0] wuser ;
  //   bid_e bid ;
  //   bresp_e bresp ;
  //   bit [3:0] buser ;
  //   arid_e arid ;
  //   bit [31:0] araddr ;
  //   bit [7:0] arlen ;
  //   arsize_e arsize ;
  //   arburst_e arburst ;
  //   arlock_e arlock ;
  //   arcache_e arcache ;
  //   arprot_e arprot ;
  //   bit arregion ;
  //   bit [3:0] arqos ;
  //   rid_e rid ;
  //   bit [31:0] rdata ;
  //   bit rlast ;
  //   bit rvalid ;
  //   rresp_e rresp ;
  //   bit [3:0] ruser ;
  //   int no_of_wait_states ;
  //   tx_type_e tx_type ;
  //   transfer_type_e transfer_type ;
  //   int wait_count_write_address_channel ;
  //   int wait_count_write_data_channel ;
  //   int wait_count_write_response_channel ;
  //   int wait_count_read_address_channel ;
  //   int wait_count_read_data_channel ;
  //   int outstanding_write_tx ;
  //   int outstanding_read_tx ;
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge ACLK_i);
       //    
       //    How to assign a initiator struct member, named xyz, from a signal.   
       //    All available responder input and inout signals listed.
       //    Responder input signals
       //      AXI4_SLAVE_initiator_struct.xyz = AWREADY_a_i;  //     
       //      AXI4_SLAVE_initiator_struct.xyz = WREADY_a_i;  //     
       //      AXI4_SLAVE_initiator_struct.xyz = BID_a_i;  //    [3:0] 
       //      AXI4_SLAVE_initiator_struct.xyz = BRESP_a_i;  //    [1:0] 
       //      AXI4_SLAVE_initiator_struct.xyz = BVALID_a_i;  //     
       //      AXI4_SLAVE_initiator_struct.xyz = ARREADY_a_i;  //     
       //      AXI4_SLAVE_initiator_struct.xyz = RID_a_i;  //    [3:0] 
       //      AXI4_SLAVE_initiator_struct.xyz = RDATA_a_i;  //    [63:0] 
       //      AXI4_SLAVE_initiator_struct.xyz = RRESP_a_i;  //    [1:0] 
       //      AXI4_SLAVE_initiator_struct.xyz = RLAST_a_i;  //     
       //      AXI4_SLAVE_initiator_struct.xyz = RVALID_a_i;  //     
       //      AXI4_SLAVE_initiator_struct.xyz = wr_rsp_en_i;  //     
       //      AXI4_SLAVE_initiator_struct.xyz = rd_rsp_en_i;  //     
       //    Responder inout signals
       //    How to assign a signal, named xyz, from an responder struct member.   
       //    All available responder output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Responder output signals
       //      AWID_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [3:0] 
       //      AWADDR_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [31:0] 
       //      AWLEN_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [3:0] 
       //      AWSIZE_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [2:0] 
       //      AWBURST_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [1:0] 
       //      AWLOCK_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [1:0] 
       //      AWCACHE_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [1:0] 
       //      AWPROT_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [2:0] 
       //      AWVALID_a_o <= AXI4_SLAVE_responder_struct.xyz;  //     
       //      WID_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [3:0] 
       //      WDATA_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [63:0] 
       //      WSTRB_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [3:0] 
       //      WLAST_a_o <= AXI4_SLAVE_responder_struct.xyz;  //     
       //      WVALID_a_o <= AXI4_SLAVE_responder_struct.xyz;  //     
       //      BREADY_a_o <= AXI4_SLAVE_responder_struct.xyz;  //     
       //      ARID_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [3:0] 
       //      ARADDR_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [31:0] 
       //      ARLEN_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [3:0] 
       //      ARSIZE_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [2:0] 
       //      ARBURST_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [1:0] 
       //      ARLOCK_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [1:0] 
       //      ARCACHE_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [1:0] 
       //      ARPROT_a_o <= AXI4_SLAVE_responder_struct.xyz;  //    [2:0] 
       //      ARVALID_a_o <= AXI4_SLAVE_responder_struct.xyz;  //     
       //      RREADY_a_o <= AXI4_SLAVE_responder_struct.xyz;  //     
       //    Responder inout signals
    
  @(posedge ACLK_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the AXI4_SLAVE_responder_struct.
    @(posedge ACLK_i);
    // Reply using data recieved in the transaction handle.
    @(posedge ACLK_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the AXI4_SLAVE_initiator_struct.
    @(posedge ACLK_i);
    @(posedge ACLK_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

// reset task added
task wait_for_system_reset();
    @(negedge ARESETn_i);
   // `uvm_info(name,$sformatf("SYSTEM RESET ACTIVATED"),UVM_NONE) //NOTE: commented
   bus.AWREADY_a <= 0;
   bus.WREADY_a  <= 0;
   bus.RVALID_a <= 0;
    bus.RLAST_a   <= 0;
    bus.BVALID_a   <= 0;
   bus.ARREADY_a  <= 0;
    bus.BID_a     <= 'bx;
   bus.BRESP_a    <= 'b0;
 //  BUSER_a_i    <= 'b0;   NOTE:commented 
    bus.RID_a     <= 'bx;
    bus.RDATA_a   <= 'b0;
   bus.RRESP_a    <= 'b0;
  //  RUSER_a_i   <= 'b0;   NOTE: commented
    @(posedge ARESETn_i);
  //  `uvm_info(name,$sformatf("SYSTEM RESET DE-ACTIVATED"),UVM_NONE)//NOTE: commented
  endtask 
 

// pragma uvmf custom external begin
// pragma uvmf custom external end


//NOTE: added wrtie _address_phase task wichi is called in AXI_SLAVE_driver.svh

//-------------------------------------------------------
// Task: axi_write_address_phase
// Sampling the signals that are associated with write_address_channel
//-------------------------------------------------------

  task axi4_write_address_phase(inout axi4_write_transfer_char_s data_write_packet);
    @(posedge ACLK_i);
   // `uvm_info(name,"INSIDE WRITE_ADDRESS_PHASE",UVM_LOW)  //NOTE: commented

    // Ready can be HIGH even before we start to check 
    // based on wait_cycles variable
    // Can make awready to zero 
   bus.AWREADY_a  <= 0;

    do begin
      @(posedge ACLK_i);
    end while(AWVALID_a_i===0);

    `uvm_info("SLAVE_DRIVER_WADDR_PHASE", $sformatf("outside of awvalid"), UVM_MEDIUM);
    
 //   if(axi4_slave_drv_proxy_h.axi4_slave_write_addr_fifo_h.is_full()) begin
 //     `uvm_error("UVM_TLM_FIFO","FIFO is now FULL!")
 //   end 
  

  /*   NOTE: commented
   // Sample the values
         mem_awid 	[i]	  = awid  	;	
	 mem_waddr	[i] 	= awaddr	;
	 mem_wlen 	[i]	  = awlen	  ;	
	 mem_wsize	[i] 	= awsize	;	
	 mem_wburst [i]   = awburst ;	
	 mem_wqos   [i]   = awqos   ;	
   
   data_write_packet.awid    = mem_awid   [i] ;
   data_write_packet.awaddr  = mem_waddr  [i] ;
   data_write_packet.awlen   = mem_wlen   [i] ;
   data_write_packet.awsize  = mem_wsize  [i] ;
   data_write_packet.awburst = mem_wburst [i] ;
   data_write_packet.awqos   = mem_wqos   [i] ;
   
   `uvm_info("struct_pkt_debug",$sformatf("struct_pkt_wr_addr_phase = \n %0p",data_write_packet),UVM_HIGH)

   i = i+1;

   // based on the wait_cycles we can choose to drive the awready
    `uvm_info(name,$sformatf("Before DRIVING WRITE ADDRS WAIT STATES :: %0d",data_write_packet.no_of_wait_states),UVM_HIGH);
    repeat(data_write_packet.no_of_wait_states)begin
      `uvm_info(name,$sformatf("DRIVING_WRITE_ADDRS_WAIT_STATES :: %0d",data_write_packet.no_of_wait_states),UVM_HIGH);
      @(posedge aclk);
      awready<=0;
    end
    awready <= 1;
   */


  endtask: axi4_write_address_phase 







//NOTE added data_phase

// Task: axi4_write_data_phase
  // This task will sample the write data signals
  //-------------------------------------------------------
  task axi4_write_data_phase (inout axi4_write_transfer_char_s data_write_packet, input axi4_transfer_cfg_s cfg_packet);
    static reg [7:0]i =0;
    @(posedge ACLK_i);
   /*  NoTE coometed
   `uvm_info(name,$sformatf("data_write_packet=\n%p",data_write_packet),UVM_HIGH)  //NOTE coomented
    `uvm_info(name,$sformatf("cfg_packet=\n%p",cfg_packet),UVM_HIGH)
    `uvm_info(name,$sformatf("INSIDE WRITE DATA CHANNEL"),UVM_NONE)    */
    
    bus.WREADY_a <= 0;

   do begin
     @(posedge ACLK_i);
   end while(WVALID_a_i === 1'b0);

   // based on the wait_cycles we can choose to drive the wready
    `uvm_info("SLAVE_BFM_WDATA_PHASE",$sformatf("Before DRIVING WRITE DATA WAIT STATES :: %0d",data_write_packet.no_of_wait_states),UVM_HIGH);
    repeat(data_write_packet.no_of_wait_states)begin
  //    `uvm_info(name,$sformatf("DRIVING_WRITE_DATA_WAIT_STATES :: %0d",data_write_packet.no_of_wait_states),UVM_HIGH);
      @(posedge ACLK_i);
     bus.WREADY_a <=0;
    end

    bus.WREADY_a <= 1 ;

   /*    //NOTE: COmmented
    if(cfg_packet.qos_mode_type == ONLY_WRITE_QOS_MODE_ENABLE || cfg_packet.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE) begin 
      forever begin
        do begin
          @(posedge ACLK_i);
        end while(WVALID_a_i === 1'b0);

        data_write_packet.wdata[i] = wdata;
        data_write_packet.wstrb[i] = wstrb;
        i++;  
        if(wlast === 1'b1)begin
          i=0;
          break;
        end
      end
    end
    else begin
      for(int s = 0;s<(mem_wlen[a]+1);s = s+1)begin
        do begin
          @(posedge aclk);
        end while(wvalid === 1'b0);
        `uvm_info("SLAVE_DEBUG",$sformatf("mem_length = %0d",mem_wlen[a]),UVM_HIGH)
         data_write_packet.wdata[s]=wdata;
         `uvm_info("slave_wdata",$sformatf("sampled_slave_wdata[%0d] = %0h",s,data_write_packet.wdata[s]),UVM_HIGH);
         data_write_packet.wstrb[s]=wstrb;
         `uvm_info("slave_wstrb",$sformatf("sampled_slave_wstrb[%0d] = %0d",s,data_write_packet.wstrb[s]),UVM_HIGH);
         
         // Used to sample the wlast at the end of transfer
         // and come out of the loop if wlast == 1
         if(s == mem_wlen[a]) begin
           mem_wlast[a] = wlast;
           `uvm_info("slave_wlast",$sformatf("slave1_wlast = %0b",wlast),UVM_HIGH);
           data_write_packet.wlast = wlast;
           if(!data_write_packet.wlast)begin
             @(posedge aclk);
             wready<=0;
             break;
           end
           `uvm_info("slave_wlast",$sformatf("slave_wlast = %0b ,a=%0d",wlast,a),UVM_HIGH);
           `uvm_info("slave_wlast",$sformatf("sampled_slave_wlast = %0b",data_write_packet.wlast),UVM_HIGH);
         end
       end
      `uvm_info(name,$sformatf("OUTSIDE WRITE DATA CHANNEL"),UVM_NONE)
      a++;
    end
*/
   @(posedge ACLK_i);
   bus.WREADY_a <= 0;

  endtask : axi4_write_data_phase



//NOTE: added respone_phse

 //-------------------------------------------------------
  // Task: axi4_write_response_phase
  // This task will drive the write response signals
  //-------------------------------------------------------
  
  task axi4_write_response_phase(inout axi4_write_transfer_char_s data_write_packet,
    axi4_transfer_cfg_s struct_cfg,bit[3:0] bid_local);
    
    int j;
    @(posedge ACLK_i);

    /*   //NOTE: commented
    if((struct_cfg.qos_mode_type == ONLY_WRITE_QOS_MODE_ENABLE) || (struct_cfg.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE)) begin
      bid <= data_write_packet.bid; 
      bresp <= data_write_packet.bresp;
      buser <= data_write_packet.buser;
      bvalid <= 1;
    end
    else if((struct_cfg.slave_response_mode == ONLY_WRITE_RESP_OUT_OF_ORDER) || (struct_cfg.slave_response_mode == WRITE_READ_RESP_OUT_OF_ORDER)) begin 
      bid <= bid_local; 
      data_write_packet.bid <= bid_local; 
      bresp <= data_write_packet.bresp;
      buser <= data_write_packet.buser;
      bvalid <= 1;
    end
    else begin 
     data_write_packet.bid <= mem_awid[j]; 
     `uvm_info("DEBUG_BRESP",$sformatf("BID = %0d",data_write_packet.bid),UVM_HIGH)
     `uvm_info(name,"INSIDE WRITE_RESPONSE_PHASE",UVM_LOW)

     bid  <= mem_awid[j];
     `uvm_info("DEBUG_BRESP",$sformatf("MEM_BID[%0d] = %0d",j,mem_awid[j]),UVM_HIGH)
     `uvm_info("DEBUG_BRESP_WLAST",$sformatf("wlast = %0d,j=%0d",mem_wlast[j],j),UVM_HIGH)
     while(mem_wlast[j]!=1) begin
       @(posedge aclk);
     end
     bresp <= data_write_packet.bresp;
     buser<=data_write_packet.buser;
     bvalid <= 1;
     j++;
     `uvm_info("DEBUG_BRESP",$sformatf("BID = %0d",bid),UVM_HIGH)
   end
    
    while(bready === 0) begin
      @(posedge aclk);
      data_write_packet.wait_count_write_response_channel++;
      `uvm_info(name,$sformatf("inside_detect_bready = %0d",bready),UVM_HIGH)
    end
    `uvm_info(name,$sformatf("After_loop_of_Detecting_bready = %0d",bready),UVM_HIGH)
    bvalid <= 1'b0;
  */
  endtask : axi4_write_response_phase


endinterface
  
