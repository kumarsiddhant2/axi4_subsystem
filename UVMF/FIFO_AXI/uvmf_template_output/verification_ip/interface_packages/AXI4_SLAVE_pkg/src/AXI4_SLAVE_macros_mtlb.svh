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
  bit [31:0] _awaddr ; \
  awid_e _awid ; \
  bit [7:0] _awlen ; \
  awsize_e _awsize ; \
  awburst_e _awburst ; \
  awlock_e _awlock ; \
  awcache_e _awcache ; \
  bit [3:0] _awqos ; \
  awprot_e _awprot ; \
  endian_e _endian ; \
  bit [31:0] _wdata ; \
  bit [3:0] _wstrb ; \
  bit _wlast ; \
  bit [3:0] _wuser ; \
  bid_e _bid ; \
  bresp_e _bresp ; \
  bit [3:0] _buser ; \
  arid_e _arid ; \
  bit [31:0] _araddr ; \
  bit [7:0] _arlen ; \
  arsize_e _arsize ; \
  arburst_e _arburst ; \
  arlock_e _arlock ; \
  arcache_e _arcache ; \
  arprot_e _arprot ; \
  bit _arregion ; \
  bit [3:0] _arqos ; \
  rid_e _rid ; \
  bit [31:0] _rdata ; \
  bit _rlast ; \
  bit _rvalid ; \
  rresp_e _rresp ; \
  bit [3:0] _ruser ; \
  int _no_of_wait_states ; \
  tx_type_e _tx_type ; \
  transfer_type_e _transfer_type ; \
  int _wait_count_write_address_channel ; \
  int _wait_count_write_data_channel ; \
  int _wait_count_write_response_channel ; \
  int _wait_count_read_address_channel ; \
  int _wait_count_read_data_channel ; \
  int _outstanding_write_tx ; \
  int _outstanding_read_tx ; \
     } AXI4_SLAVE_monitor_s;

  `define AXI4_SLAVE_TO_MONITOR_STRUCT_FUNCTION \
  virtual function AXI4_SLAVE_monitor_s to_monitor_struct();\
    AXI4_SLAVE_monitor_struct = \
            { \
            this._awaddr , \
            this._awid , \
            this._awlen , \
            this._awsize , \
            this._awburst , \
            this._awlock , \
            this._awcache , \
            this._awqos , \
            this._awprot , \
            this._endian , \
            this._wdata , \
            this._wstrb , \
            this._wlast , \
            this._wuser , \
            this._bid , \
            this._bresp , \
            this._buser , \
            this._arid , \
            this._araddr , \
            this._arlen , \
            this._arsize , \
            this._arburst , \
            this._arlock , \
            this._arcache , \
            this._arprot , \
            this._arregion , \
            this._arqos , \
            this._rid , \
            this._rdata , \
            this._rlast , \
            this._rvalid , \
            this._rresp , \
            this._ruser , \
            this._no_of_wait_states , \
            this._tx_type , \
            this._transfer_type , \
            this._wait_count_write_address_channel , \
            this._wait_count_write_data_channel , \
            this._wait_count_write_response_channel , \
            this._wait_count_read_address_channel , \
            this._wait_count_read_data_channel , \
            this._outstanding_write_tx , \
            this._outstanding_read_tx  \
            };\
    return ( AXI4_SLAVE_monitor_struct);\
  endfunction\

  `define AXI4_SLAVE_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct);\
            {\
            this._awaddr , \
            this._awid , \
            this._awlen , \
            this._awsize , \
            this._awburst , \
            this._awlock , \
            this._awcache , \
            this._awqos , \
            this._awprot , \
            this._endian , \
            this._wdata , \
            this._wstrb , \
            this._wlast , \
            this._wuser , \
            this._bid , \
            this._bresp , \
            this._buser , \
            this._arid , \
            this._araddr , \
            this._arlen , \
            this._arsize , \
            this._arburst , \
            this._arlock , \
            this._arcache , \
            this._arprot , \
            this._arregion , \
            this._arqos , \
            this._rid , \
            this._rdata , \
            this._rlast , \
            this._rvalid , \
            this._rresp , \
            this._ruser , \
            this._no_of_wait_states , \
            this._tx_type , \
            this._transfer_type , \
            this._wait_count_write_address_channel , \
            this._wait_count_write_data_channel , \
            this._wait_count_write_response_channel , \
            this._wait_count_read_address_channel , \
            this._wait_count_read_data_channel , \
            this._outstanding_write_tx , \
            this._outstanding_read_tx  \
            } = AXI4_SLAVE_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the AXI4_SLAVE_transaction class.
//      Also update the comments in the driver BFM.
//
  `define AXI4_SLAVE_INITIATOR_STRUCT typedef struct packed  { \
  bit [31:0] _awaddr ; \
  awid_e _awid ; \
  bit [7:0] _awlen ; \
  awsize_e _awsize ; \
  awburst_e _awburst ; \
  awlock_e _awlock ; \
  awcache_e _awcache ; \
  bit [3:0] _awqos ; \
  awprot_e _awprot ; \
  endian_e _endian ; \
  bit [31:0] _wdata ; \
  bit [3:0] _wstrb ; \
  bit _wlast ; \
  bit [3:0] _wuser ; \
  bid_e _bid ; \
  bresp_e _bresp ; \
  bit [3:0] _buser ; \
  arid_e _arid ; \
  bit [31:0] _araddr ; \
  bit [7:0] _arlen ; \
  arsize_e _arsize ; \
  arburst_e _arburst ; \
  arlock_e _arlock ; \
  arcache_e _arcache ; \
  arprot_e _arprot ; \
  bit _arregion ; \
  bit [3:0] _arqos ; \
  rid_e _rid ; \
  bit [31:0] _rdata ; \
  bit _rlast ; \
  bit _rvalid ; \
  rresp_e _rresp ; \
  bit [3:0] _ruser ; \
  int _no_of_wait_states ; \
  tx_type_e _tx_type ; \
  transfer_type_e _transfer_type ; \
  int _wait_count_write_address_channel ; \
  int _wait_count_write_data_channel ; \
  int _wait_count_write_response_channel ; \
  int _wait_count_read_address_channel ; \
  int _wait_count_read_data_channel ; \
  int _outstanding_write_tx ; \
  int _outstanding_read_tx ; \
     } AXI4_SLAVE_initiator_s;

  `define AXI4_SLAVE_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function AXI4_SLAVE_initiator_s to_initiator_struct();\
    AXI4_SLAVE_initiator_struct = \
           {\
           this._awaddr , \
           this._awid , \
           this._awlen , \
           this._awsize , \
           this._awburst , \
           this._awlock , \
           this._awcache , \
           this._awqos , \
           this._awprot , \
           this._endian , \
           this._wdata , \
           this._wstrb , \
           this._wlast , \
           this._wuser , \
           this._bid , \
           this._bresp , \
           this._buser , \
           this._arid , \
           this._araddr , \
           this._arlen , \
           this._arsize , \
           this._arburst , \
           this._arlock , \
           this._arcache , \
           this._arprot , \
           this._arregion , \
           this._arqos , \
           this._rid , \
           this._rdata , \
           this._rlast , \
           this._rvalid , \
           this._rresp , \
           this._ruser , \
           this._no_of_wait_states , \
           this._tx_type , \
           this._transfer_type , \
           this._wait_count_write_address_channel , \
           this._wait_count_write_data_channel , \
           this._wait_count_write_response_channel , \
           this._wait_count_read_address_channel , \
           this._wait_count_read_data_channel , \
           this._outstanding_write_tx , \
           this._outstanding_read_tx  \
           };\
    return ( AXI4_SLAVE_initiator_struct);\
  endfunction

  `define AXI4_SLAVE_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(AXI4_SLAVE_initiator_s AXI4_SLAVE_initiator_struct);\
           {\
           this._awaddr , \
           this._awid , \
           this._awlen , \
           this._awsize , \
           this._awburst , \
           this._awlock , \
           this._awcache , \
           this._awqos , \
           this._awprot , \
           this._endian , \
           this._wdata , \
           this._wstrb , \
           this._wlast , \
           this._wuser , \
           this._bid , \
           this._bresp , \
           this._buser , \
           this._arid , \
           this._araddr , \
           this._arlen , \
           this._arsize , \
           this._arburst , \
           this._arlock , \
           this._arcache , \
           this._arprot , \
           this._arregion , \
           this._arqos , \
           this._rid , \
           this._rdata , \
           this._rlast , \
           this._rvalid , \
           this._rresp , \
           this._ruser , \
           this._no_of_wait_states , \
           this._tx_type , \
           this._transfer_type , \
           this._wait_count_write_address_channel , \
           this._wait_count_write_data_channel , \
           this._wait_count_write_response_channel , \
           this._wait_count_read_address_channel , \
           this._wait_count_read_data_channel , \
           this._outstanding_write_tx , \
           this._outstanding_read_tx  \
           } = AXI4_SLAVE_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the AXI4_SLAVE_transaction class.
//      Also update the comments in the driver BFM.
//
  `define AXI4_SLAVE_RESPONDER_STRUCT typedef struct packed  { \
  bit [31:0] _awaddr ; \
  awid_e _awid ; \
  bit [7:0] _awlen ; \
  awsize_e _awsize ; \
  awburst_e _awburst ; \
  awlock_e _awlock ; \
  awcache_e _awcache ; \
  bit [3:0] _awqos ; \
  awprot_e _awprot ; \
  endian_e _endian ; \
  bit [31:0] _wdata ; \
  bit [3:0] _wstrb ; \
  bit _wlast ; \
  bit [3:0] _wuser ; \
  bid_e _bid ; \
  bresp_e _bresp ; \
  bit [3:0] _buser ; \
  arid_e _arid ; \
  bit [31:0] _araddr ; \
  bit [7:0] _arlen ; \
  arsize_e _arsize ; \
  arburst_e _arburst ; \
  arlock_e _arlock ; \
  arcache_e _arcache ; \
  arprot_e _arprot ; \
  bit _arregion ; \
  bit [3:0] _arqos ; \
  rid_e _rid ; \
  bit [31:0] _rdata ; \
  bit _rlast ; \
  bit _rvalid ; \
  rresp_e _rresp ; \
  bit [3:0] _ruser ; \
  int _no_of_wait_states ; \
  tx_type_e _tx_type ; \
  transfer_type_e _transfer_type ; \
  int _wait_count_write_address_channel ; \
  int _wait_count_write_data_channel ; \
  int _wait_count_write_response_channel ; \
  int _wait_count_read_address_channel ; \
  int _wait_count_read_data_channel ; \
  int _outstanding_write_tx ; \
  int _outstanding_read_tx ; \
     } AXI4_SLAVE_responder_s;

  `define AXI4_SLAVE_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function AXI4_SLAVE_responder_s to_responder_struct();\
    AXI4_SLAVE_responder_struct = \
           {\
           this._awaddr , \
           this._awid , \
           this._awlen , \
           this._awsize , \
           this._awburst , \
           this._awlock , \
           this._awcache , \
           this._awqos , \
           this._awprot , \
           this._endian , \
           this._wdata , \
           this._wstrb , \
           this._wlast , \
           this._wuser , \
           this._bid , \
           this._bresp , \
           this._buser , \
           this._arid , \
           this._araddr , \
           this._arlen , \
           this._arsize , \
           this._arburst , \
           this._arlock , \
           this._arcache , \
           this._arprot , \
           this._arregion , \
           this._arqos , \
           this._rid , \
           this._rdata , \
           this._rlast , \
           this._rvalid , \
           this._rresp , \
           this._ruser , \
           this._no_of_wait_states , \
           this._tx_type , \
           this._transfer_type , \
           this._wait_count_write_address_channel , \
           this._wait_count_write_data_channel , \
           this._wait_count_write_response_channel , \
           this._wait_count_read_address_channel , \
           this._wait_count_read_data_channel , \
           this._outstanding_write_tx , \
           this._outstanding_read_tx  \
           };\
    return ( AXI4_SLAVE_responder_struct);\
  endfunction

  `define AXI4_SLAVE_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(AXI4_SLAVE_responder_s AXI4_SLAVE_responder_struct);\
           {\
           this._awaddr , \
           this._awid , \
           this._awlen , \
           this._awsize , \
           this._awburst , \
           this._awlock , \
           this._awcache , \
           this._awqos , \
           this._awprot , \
           this._endian , \
           this._wdata , \
           this._wstrb , \
           this._wlast , \
           this._wuser , \
           this._bid , \
           this._bresp , \
           this._buser , \
           this._arid , \
           this._araddr , \
           this._arlen , \
           this._arsize , \
           this._arburst , \
           this._arlock , \
           this._arcache , \
           this._arprot , \
           this._arregion , \
           this._arqos , \
           this._rid , \
           this._rdata , \
           this._rlast , \
           this._rvalid , \
           this._rresp , \
           this._ruser , \
           this._no_of_wait_states , \
           this._tx_type , \
           this._transfer_type , \
           this._wait_count_write_address_channel , \
           this._wait_count_write_data_channel , \
           this._wait_count_write_response_channel , \
           this._wait_count_read_address_channel , \
           this._wait_count_read_data_channel , \
           this._outstanding_write_tx , \
           this._outstanding_read_tx  \
           } = AXI4_SLAVE_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
