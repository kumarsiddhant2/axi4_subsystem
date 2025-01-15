//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the FIFO_in package.
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
//      the FIFO_in_configuration class.
//
  `define FIFO_in_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } FIFO_in_configuration_s;

  `define FIFO_in_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function FIFO_in_configuration_s to_struct();\
    FIFO_in_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( FIFO_in_configuration_struct );\
  endfunction

  `define FIFO_in_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(FIFO_in_configuration_s FIFO_in_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = FIFO_in_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the FIFO_in_transaction class.
//
  `define FIFO_in_MONITOR_STRUCT typedef struct packed  { \
  bit [7:0] _sop ; \
  bit [3:0] _txn_id ; \
  bit [31:0] _addr ; \
  bit [3:0] _len ; \
  bit [2:0] _size ; \
  bit [1:0] _burst ; \
  bit [1:0] _lock ; \
  bit [1:0] _cache ; \
  bit [2:0] _prot ; \
  bit [3:0] _strobe ; \
  bit [127:0] _wdata ; \
  bit [127:0] _rdata ; \
  bit [7:0] _eop ; \
     } FIFO_in_monitor_s;

  `define FIFO_in_TO_MONITOR_STRUCT_FUNCTION \
  virtual function FIFO_in_monitor_s to_monitor_struct();\
    FIFO_in_monitor_struct = \
            { \
            this._sop , \
            this._txn_id , \
            this._addr , \
            this._len , \
            this._size , \
            this._burst , \
            this._lock , \
            this._cache , \
            this._prot , \
            this._strobe , \
            this._wdata , \
            this._rdata , \
            this._eop  \
            };\
    return ( FIFO_in_monitor_struct);\
  endfunction\

  `define FIFO_in_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(FIFO_in_monitor_s FIFO_in_monitor_struct);\
            {\
            this._sop , \
            this._txn_id , \
            this._addr , \
            this._len , \
            this._size , \
            this._burst , \
            this._lock , \
            this._cache , \
            this._prot , \
            this._strobe , \
            this._wdata , \
            this._rdata , \
            this._eop  \
            } = FIFO_in_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the FIFO_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define FIFO_in_INITIATOR_STRUCT typedef struct packed  { \
  bit [7:0] _sop ; \
  bit [3:0] _txn_id ; \
  bit [31:0] _addr ; \
  bit [3:0] _len ; \
  bit [2:0] _size ; \
  bit [1:0] _burst ; \
  bit [1:0] _lock ; \
  bit [1:0] _cache ; \
  bit [2:0] _prot ; \
  bit [3:0] _strobe ; \
  bit [127:0] _wdata ; \
  bit [127:0] _rdata ; \
  bit [7:0] _eop ; \
     } FIFO_in_initiator_s;

  `define FIFO_in_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function FIFO_in_initiator_s to_initiator_struct();\
    FIFO_in_initiator_struct = \
           {\
           this._sop , \
           this._txn_id , \
           this._addr , \
           this._len , \
           this._size , \
           this._burst , \
           this._lock , \
           this._cache , \
           this._prot , \
           this._strobe , \
           this._wdata , \
           this._rdata , \
           this._eop  \
           };\
    return ( FIFO_in_initiator_struct);\
  endfunction

  `define FIFO_in_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(FIFO_in_initiator_s FIFO_in_initiator_struct);\
           {\
           this._sop , \
           this._txn_id , \
           this._addr , \
           this._len , \
           this._size , \
           this._burst , \
           this._lock , \
           this._cache , \
           this._prot , \
           this._strobe , \
           this._wdata , \
           this._rdata , \
           this._eop  \
           } = FIFO_in_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the FIFO_in_transaction class.
//      Also update the comments in the driver BFM.
//
  `define FIFO_in_RESPONDER_STRUCT typedef struct packed  { \
  bit [7:0] _sop ; \
  bit [3:0] _txn_id ; \
  bit [31:0] _addr ; \
  bit [3:0] _len ; \
  bit [2:0] _size ; \
  bit [1:0] _burst ; \
  bit [1:0] _lock ; \
  bit [1:0] _cache ; \
  bit [2:0] _prot ; \
  bit [3:0] _strobe ; \
  bit [127:0] _wdata ; \
  bit [127:0] _rdata ; \
  bit [7:0] _eop ; \
     } FIFO_in_responder_s;

  `define FIFO_in_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function FIFO_in_responder_s to_responder_struct();\
    FIFO_in_responder_struct = \
           {\
           this._sop , \
           this._txn_id , \
           this._addr , \
           this._len , \
           this._size , \
           this._burst , \
           this._lock , \
           this._cache , \
           this._prot , \
           this._strobe , \
           this._wdata , \
           this._rdata , \
           this._eop  \
           };\
    return ( FIFO_in_responder_struct);\
  endfunction

  `define FIFO_in_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(FIFO_in_responder_s FIFO_in_responder_struct);\
           {\
           this._sop , \
           this._txn_id , \
           this._addr , \
           this._len , \
           this._size , \
           this._burst , \
           this._lock , \
           this._cache , \
           this._prot , \
           this._strobe , \
           this._wdata , \
           this._rdata , \
           this._eop  \
           } = FIFO_in_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
