//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the AXI4_SLAVE package.
//   These macros include packed struct definitions.  These structs are
//   used to pass data between classes, hvl, and BFM's, hdl.  Use of 
//   structs are more efficient and simpler to modify.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_struct
//      and from_struct methods defined in the macros below that are used in  
//      the AXI4_SLAVE_configuration class.
//
  `define AXI4_SLAVE_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } AXI4_SLAVE_configuration_s;

  `define AXI4_SLAVE_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function AXI4_SLAVE_configuration_s to_struct();\
    AXI4_SLAVE_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( AXI4_SLAVE_configuration_struct );\
  endfunction

  `define AXI4_SLAVE_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(AXI4_SLAVE_configuration_s AXI4_SLAVE_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = AXI4_SLAVE_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the AXI4_SLAVE_transaction class.
//
  `define AXI4_SLAVE_MONITOR_STRUCT typedef struct packed  { \
  bit [31:0] awaddr ; \
  awid_e awid ; \
  bit [7:0] awlen ; \
  awsize_e awsize ; \
  awburst_e awburst ; \
  awlock_e awlock ; \
  awcache_e awcache ; \
  bit [3:0] awqos ; \
  awprot_e awprot ; \
  endian_e endian ; \
  bit [31:0] wdata ; \
  bit [3:0] wstrb ; \
  bit wlast ; \
  bit [3:0] wuser ; \
  bid_e bid ; \
  bresp_e bresp ; \
  bit [3:0] buser ; \
  arid_e arid ; \
  bit [31:0] araddr ; \
  bit [7:0] arlen ; \
  arsize_e arsize ; \
  arburst_e arburst ; \
  arlock_e arlock ; \
  arcache_e arcache ; \
  arprot_e arprot ; \
  bit arregion ; \
  bit [3:0] arqos ; \
  rid_e rid ; \
  bit [31:0] rdata ; \
  bit rlast ; \
  bit rvalid ; \
  rresp_e rresp ; \
  bit [3:0] ruser ; \
  int no_of_wait_states ; \
  tx_type_e tx_type ; \
  transfer_type_e transfer_type ; \
  int wait_count_write_address_channel ; \
  int wait_count_write_data_channel ; \
  int wait_count_write_response_channel ; \
  int wait_count_read_address_channel ; \
  int wait_count_read_data_channel ; \
  int outstanding_write_tx ; \
  int outstanding_read_tx ; \
     } AXI4_SLAVE_monitor_s;

  `define AXI4_SLAVE_TO_MONITOR_STRUCT_FUNCTION \
  virtual function AXI4_SLAVE_monitor_s to_monitor_struct();\
    AXI4_SLAVE_monitor_struct = \
            { \
            this.awaddr , \
            this.awid , \
            this.awlen , \
            this.awsize , \
            this.awburst , \
            this.awlock , \
            this.awcache , \
            this.awqos , \
            this.awprot , \
            this.endian , \
            this.wdata , \
            this.wstrb , \
            this.wlast , \
            this.wuser , \
            this.bid , \
            this.bresp , \
            this.buser , \
            this.arid , \
            this.araddr , \
            this.arlen , \
            this.arsize , \
            this.arburst , \
            this.arlock , \
            this.arcache , \
            this.arprot , \
            this.arregion , \
            this.arqos , \
            this.rid , \
            this.rdata , \
            this.rlast , \
            this.rvalid , \
            this.rresp , \
            this.ruser , \
            this.no_of_wait_states , \
            this.tx_type , \
            this.transfer_type , \
            this.wait_count_write_address_channel , \
            this.wait_count_write_data_channel , \
            this.wait_count_write_response_channel , \
            this.wait_count_read_address_channel , \
            this.wait_count_read_data_channel , \
            this.outstanding_write_tx , \
            this.outstanding_read_tx  \
            };\
    return ( AXI4_SLAVE_monitor_struct);\
  endfunction\

  `define AXI4_SLAVE_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct);\
            {\
            this.awaddr , \
            this.awid , \
            this.awlen , \
            this.awsize , \
            this.awburst , \
            this.awlock , \
            this.awcache , \
            this.awqos , \
            this.awprot , \
            this.endian , \
            this.wdata , \
            this.wstrb , \
            this.wlast , \
            this.wuser , \
            this.bid , \
            this.bresp , \
            this.buser , \
            this.arid , \
            this.araddr , \
            this.arlen , \
            this.arsize , \
            this.arburst , \
            this.arlock , \
            this.arcache , \
            this.arprot , \
            this.arregion , \
            this.arqos , \
            this.rid , \
            this.rdata , \
            this.rlast , \
            this.rvalid , \
            this.rresp , \
            this.ruser , \
            this.no_of_wait_states , \
            this.tx_type , \
            this.transfer_type , \
            this.wait_count_write_address_channel , \
            this.wait_count_write_data_channel , \
            this.wait_count_write_response_channel , \
            this.wait_count_read_address_channel , \
            this.wait_count_read_data_channel , \
            this.outstanding_write_tx , \
            this.outstanding_read_tx  \
            } = AXI4_SLAVE_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the AXI4_SLAVE_transaction class.
//      Also update the comments in the driver BFM.
//
  `define AXI4_SLAVE_INITIATOR_STRUCT typedef struct packed  { \
  bit [31:0] awaddr ; \
  awid_e awid ; \
  bit [7:0] awlen ; \
  awsize_e awsize ; \
  awburst_e awburst ; \
  awlock_e awlock ; \
  awcache_e awcache ; \
  bit [3:0] awqos ; \
  awprot_e awprot ; \
  endian_e endian ; \
  bit [31:0] wdata ; \
  bit [3:0] wstrb ; \
  bit wlast ; \
  bit [3:0] wuser ; \
  bid_e bid ; \
  bresp_e bresp ; \
  bit [3:0] buser ; \
  arid_e arid ; \
  bit [31:0] araddr ; \
  bit [7:0] arlen ; \
  arsize_e arsize ; \
  arburst_e arburst ; \
  arlock_e arlock ; \
  arcache_e arcache ; \
  arprot_e arprot ; \
  bit arregion ; \
  bit [3:0] arqos ; \
  rid_e rid ; \
  bit [31:0] rdata ; \
  bit rlast ; \
  bit rvalid ; \
  rresp_e rresp ; \
  bit [3:0] ruser ; \
  int no_of_wait_states ; \
  tx_type_e tx_type ; \
  transfer_type_e transfer_type ; \
  int wait_count_write_address_channel ; \
  int wait_count_write_data_channel ; \
  int wait_count_write_response_channel ; \
  int wait_count_read_address_channel ; \
  int wait_count_read_data_channel ; \
  int outstanding_write_tx ; \
  int outstanding_read_tx ; \
     } AXI4_SLAVE_initiator_s;

  `define AXI4_SLAVE_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function AXI4_SLAVE_initiator_s to_initiator_struct();\
    AXI4_SLAVE_initiator_struct = \
           {\
           this.awaddr , \
           this.awid , \
           this.awlen , \
           this.awsize , \
           this.awburst , \
           this.awlock , \
           this.awcache , \
           this.awqos , \
           this.awprot , \
           this.endian , \
           this.wdata , \
           this.wstrb , \
           this.wlast , \
           this.wuser , \
           this.bid , \
           this.bresp , \
           this.buser , \
           this.arid , \
           this.araddr , \
           this.arlen , \
           this.arsize , \
           this.arburst , \
           this.arlock , \
           this.arcache , \
           this.arprot , \
           this.arregion , \
           this.arqos , \
           this.rid , \
           this.rdata , \
           this.rlast , \
           this.rvalid , \
           this.rresp , \
           this.ruser , \
           this.no_of_wait_states , \
           this.tx_type , \
           this.transfer_type , \
           this.wait_count_write_address_channel , \
           this.wait_count_write_data_channel , \
           this.wait_count_write_response_channel , \
           this.wait_count_read_address_channel , \
           this.wait_count_read_data_channel , \
           this.outstanding_write_tx , \
           this.outstanding_read_tx  \
           };\
    return ( AXI4_SLAVE_initiator_struct);\
  endfunction

  `define AXI4_SLAVE_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(AXI4_SLAVE_initiator_s AXI4_SLAVE_initiator_struct);\
           {\
           this.awaddr , \
           this.awid , \
           this.awlen , \
           this.awsize , \
           this.awburst , \
           this.awlock , \
           this.awcache , \
           this.awqos , \
           this.awprot , \
           this.endian , \
           this.wdata , \
           this.wstrb , \
           this.wlast , \
           this.wuser , \
           this.bid , \
           this.bresp , \
           this.buser , \
           this.arid , \
           this.araddr , \
           this.arlen , \
           this.arsize , \
           this.arburst , \
           this.arlock , \
           this.arcache , \
           this.arprot , \
           this.arregion , \
           this.arqos , \
           this.rid , \
           this.rdata , \
           this.rlast , \
           this.rvalid , \
           this.rresp , \
           this.ruser , \
           this.no_of_wait_states , \
           this.tx_type , \
           this.transfer_type , \
           this.wait_count_write_address_channel , \
           this.wait_count_write_data_channel , \
           this.wait_count_write_response_channel , \
           this.wait_count_read_address_channel , \
           this.wait_count_read_data_channel , \
           this.outstanding_write_tx , \
           this.outstanding_read_tx  \
           } = AXI4_SLAVE_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the AXI4_SLAVE_transaction class.
//      Also update the comments in the driver BFM.
//
  `define AXI4_SLAVE_RESPONDER_STRUCT typedef struct packed  { \
  bit [31:0] awaddr ; \
  awid_e awid ; \
  bit [7:0] awlen ; \
  awsize_e awsize ; \
  awburst_e awburst ; \
  awlock_e awlock ; \
  awcache_e awcache ; \
  bit [3:0] awqos ; \
  awprot_e awprot ; \
  endian_e endian ; \
  bit [31:0] wdata ; \
  bit [3:0] wstrb ; \
  bit wlast ; \
  bit [3:0] wuser ; \
  bid_e bid ; \
  bresp_e bresp ; \
  bit [3:0] buser ; \
  arid_e arid ; \
  bit [31:0] araddr ; \
  bit [7:0] arlen ; \
  arsize_e arsize ; \
  arburst_e arburst ; \
  arlock_e arlock ; \
  arcache_e arcache ; \
  arprot_e arprot ; \
  bit arregion ; \
  bit [3:0] arqos ; \
  rid_e rid ; \
  bit [31:0] rdata ; \
  bit rlast ; \
  bit rvalid ; \
  rresp_e rresp ; \
  bit [3:0] ruser ; \
  int no_of_wait_states ; \
  tx_type_e tx_type ; \
  transfer_type_e transfer_type ; \
  int wait_count_write_address_channel ; \
  int wait_count_write_data_channel ; \
  int wait_count_write_response_channel ; \
  int wait_count_read_address_channel ; \
  int wait_count_read_data_channel ; \
  int outstanding_write_tx ; \
  int outstanding_read_tx ; \
     } AXI4_SLAVE_responder_s;

  `define AXI4_SLAVE_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function AXI4_SLAVE_responder_s to_responder_struct();\
    AXI4_SLAVE_responder_struct = \
           {\
           this.awaddr , \
           this.awid , \
           this.awlen , \
           this.awsize , \
           this.awburst , \
           this.awlock , \
           this.awcache , \
           this.awqos , \
           this.awprot , \
           this.endian , \
           this.wdata , \
           this.wstrb , \
           this.wlast , \
           this.wuser , \
           this.bid , \
           this.bresp , \
           this.buser , \
           this.arid , \
           this.araddr , \
           this.arlen , \
           this.arsize , \
           this.arburst , \
           this.arlock , \
           this.arcache , \
           this.arprot , \
           this.arregion , \
           this.arqos , \
           this.rid , \
           this.rdata , \
           this.rlast , \
           this.rvalid , \
           this.rresp , \
           this.ruser , \
           this.no_of_wait_states , \
           this.tx_type , \
           this.transfer_type , \
           this.wait_count_write_address_channel , \
           this.wait_count_write_data_channel , \
           this.wait_count_write_response_channel , \
           this.wait_count_read_address_channel , \
           this.wait_count_read_data_channel , \
           this.outstanding_write_tx , \
           this.outstanding_read_tx  \
           };\
    return ( AXI4_SLAVE_responder_struct);\
  endfunction

  `define AXI4_SLAVE_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(AXI4_SLAVE_responder_s AXI4_SLAVE_responder_struct);\
           {\
           this.awaddr , \
           this.awid , \
           this.awlen , \
           this.awsize , \
           this.awburst , \
           this.awlock , \
           this.awcache , \
           this.awqos , \
           this.awprot , \
           this.endian , \
           this.wdata , \
           this.wstrb , \
           this.wlast , \
           this.wuser , \
           this.bid , \
           this.bresp , \
           this.buser , \
           this.arid , \
           this.araddr , \
           this.arlen , \
           this.arsize , \
           this.arburst , \
           this.arlock , \
           this.arcache , \
           this.arprot , \
           this.arregion , \
           this.arqos , \
           this.rid , \
           this.rdata , \
           this.rlast , \
           this.rvalid , \
           this.rresp , \
           this.ruser , \
           this.no_of_wait_states , \
           this.tx_type , \
           this.transfer_type , \
           this.wait_count_write_address_channel , \
           this.wait_count_write_data_channel , \
           this.wait_count_write_response_channel , \
           this.wait_count_read_address_channel , \
           this.wait_count_read_data_channel , \
           this.outstanding_write_tx , \
           this.outstanding_read_tx  \
           } = AXI4_SLAVE_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
