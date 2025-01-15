//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an AXI4_SLAVE
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class AXI4_SLAVE_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( AXI4_SLAVE_transaction )

  bit [31:0] awaddr ;
  awid_e awid ;
  bit [7:0] awlen ;
  awsize_e awsize ;
  awburst_e awburst ;
  awlock_e awlock ;
  awcache_e awcache ;
  bit [3:0] awqos ;
  awprot_e awprot ;
  endian_e endian ;
  bit [31:0] wdata ;
  bit [3:0] wstrb ;
  bit wlast ;
  bit [3:0] wuser ;
  bid_e bid ;
  rand bresp_e bresp ;
  rand bit [3:0] buser ;
  rand arid_e arid ;
  rand bit [31:0] araddr ;
  rand bit [7:0] arlen ;
  rand arsize_e arsize ;
  rand arburst_e arburst ;
  rand arlock_e arlock ;
  rand arcache_e arcache ;
  rand arprot_e arprot ;
  bit arregion ;
  bit [3:0] arqos ;
  rand rid_e rid ;
  rand bit [31:0] rdata ;
  bit rlast ;
  bit rvalid ;
  rand rresp_e rresp ;
  rand bit [3:0] ruser ;
  rand int no_of_wait_states ;
  tx_type_e tx_type ;
  transfer_type_e transfer_type ;
  int wait_count_write_address_channel ;
  int wait_count_write_data_channel ;
  int wait_count_write_response_channel ;
  int wait_count_read_address_channel ;
  int wait_count_read_data_channel ;
  int outstanding_write_tx ;
  int outstanding_read_tx ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in AXI4_SLAVE_macros.svh

  //*******************************************************************
  // Monitor macro used by AXI4_SLAVE_monitor and AXI4_SLAVE_monitor_bfm
  // This struct is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_MONITOR_STRUCT
    AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a AXI4_SLAVE_monitor_s
  // structure.  The function returns the handle to the AXI4_SLAVE_monitor_struct.
  // This function is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by AXI4_SLAVE_driver and AXI4_SLAVE_driver_bfm
  // to communicate initiator driven data to AXI4_SLAVE_driver_bfm.
  // This struct is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_INITIATOR_STRUCT
    AXI4_SLAVE_initiator_s AXI4_SLAVE_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a AXI4_SLAVE_initiator_s
  // structure.  The function returns the handle to the AXI4_SLAVE_initiator_struct.
  // This function is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by AXI4_SLAVE_driver and AXI4_SLAVE_driver_bfm
  // to communicate Responder driven data to AXI4_SLAVE_driver_bfm.
  // This struct is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_RESPONDER_STRUCT
    AXI4_SLAVE_responder_s AXI4_SLAVE_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a AXI4_SLAVE_responder_s
  // structure.  The function returns the handle to the AXI4_SLAVE_responder_struct.
  // This function is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in AXI4_SLAVE_macros.svh
  `AXI4_SLAVE_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("awaddr:0x%x awid:0x%x awlen:0x%x awsize:0x%x awburst:0x%x awlock:0x%x awcache:0x%x awqos:0x%x awprot:0x%x endian:0x%x wdata:0x%x wstrb:0x%x wlast:0x%x wuser:0x%x bid:0x%x bresp:0x%x buser:0x%x arid:0x%x araddr:0x%x arlen:0x%x arsize:0x%x arburst:0x%x arlock:0x%x arcache:0x%x arprot:0x%x arregion:0x%x arqos:0x%x rid:0x%x rdata:0x%x rlast:0x%x rvalid:0x%x rresp:0x%x ruser:0x%x no_of_wait_states:0x%x tx_type:0x%x transfer_type:0x%x wait_count_write_address_channel:0x%x wait_count_write_data_channel:0x%x wait_count_write_response_channel:0x%x wait_count_read_address_channel:0x%x wait_count_read_data_channel:0x%x outstanding_write_tx:0x%x outstanding_read_tx:0x%x ",awaddr,awid,awlen,awsize,awburst,awlock,awcache,awqos,awprot,endian,wdata,wstrb,wlast,wuser,bid,bresp,buser,arid,araddr,arlen,arsize,arburst,arlock,arcache,arprot,arregion,arqos,rid,rdata,rlast,rvalid,rresp,ruser,no_of_wait_states,tx_type,transfer_type,wait_count_write_address_channel,wait_count_write_data_channel,wait_count_write_response_channel,wait_count_read_address_channel,wait_count_read_data_channel,outstanding_write_tx,outstanding_read_tx);
    // pragma uvmf custom convert2string end
  endfunction

  //*******************************************************************
  // FUNCTION: do_print()
  // This function is automatically called when the .print() function
  // is called on this class.
  //
  virtual function void do_print(uvm_printer printer);
    // pragma uvmf custom do_print begin
    // UVMF_CHANGE_ME : Current contents of do_print allows for the use of UVM 1.1d, 1.2 or P1800.2.
    // Update based on your own printing preference according to your preferred UVM version
    $display(convert2string());
    // pragma uvmf custom do_print end
  endfunction

  //*******************************************************************
  // FUNCTION: do_compare()
  // This function is automatically called when the .compare() function
  // is called on this class.
  //
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    AXI4_SLAVE_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.awaddr == RHS.awaddr)
            &&(this.awid == RHS.awid)
            &&(this.awlen == RHS.awlen)
            &&(this.awsize == RHS.awsize)
            &&(this.awburst == RHS.awburst)
            &&(this.awlock == RHS.awlock)
            &&(this.awcache == RHS.awcache)
            &&(this.awqos == RHS.awqos)
            &&(this.awprot == RHS.awprot)
            &&(this.endian == RHS.endian)
            &&(this.wdata == RHS.wdata)
            &&(this.wstrb == RHS.wstrb)
            &&(this.wlast == RHS.wlast)
            &&(this.wuser == RHS.wuser)
            &&(this.bid == RHS.bid)
            &&(this.bresp == RHS.bresp)
            &&(this.buser == RHS.buser)
            &&(this.arid == RHS.arid)
            &&(this.araddr == RHS.araddr)
            &&(this.arlen == RHS.arlen)
            &&(this.arsize == RHS.arsize)
            &&(this.arburst == RHS.arburst)
            &&(this.arlock == RHS.arlock)
            &&(this.arcache == RHS.arcache)
            &&(this.arprot == RHS.arprot)
            &&(this.arregion == RHS.arregion)
            &&(this.arqos == RHS.arqos)
            &&(this.rid == RHS.rid)
            &&(this.rdata == RHS.rdata)
            &&(this.rlast == RHS.rlast)
            &&(this.rvalid == RHS.rvalid)
            &&(this.rresp == RHS.rresp)
            &&(this.ruser == RHS.ruser)
            &&(this.no_of_wait_states == RHS.no_of_wait_states)
            &&(this.tx_type == RHS.tx_type)
            &&(this.transfer_type == RHS.transfer_type)
            &&(this.wait_count_write_address_channel == RHS.wait_count_write_address_channel)
            &&(this.wait_count_write_data_channel == RHS.wait_count_write_data_channel)
            &&(this.wait_count_write_response_channel == RHS.wait_count_write_response_channel)
            &&(this.wait_count_read_address_channel == RHS.wait_count_read_address_channel)
            &&(this.wait_count_read_data_channel == RHS.wait_count_read_data_channel)
            &&(this.outstanding_write_tx == RHS.outstanding_write_tx)
            &&(this.outstanding_read_tx == RHS.outstanding_read_tx)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    AXI4_SLAVE_transaction  RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.awaddr = RHS.awaddr;
    this.awid = RHS.awid;
    this.awlen = RHS.awlen;
    this.awsize = RHS.awsize;
    this.awburst = RHS.awburst;
    this.awlock = RHS.awlock;
    this.awcache = RHS.awcache;
    this.awqos = RHS.awqos;
    this.awprot = RHS.awprot;
    this.endian = RHS.endian;
    this.wdata = RHS.wdata;
    this.wstrb = RHS.wstrb;
    this.wlast = RHS.wlast;
    this.wuser = RHS.wuser;
    this.bid = RHS.bid;
    this.bresp = RHS.bresp;
    this.buser = RHS.buser;
    this.arid = RHS.arid;
    this.araddr = RHS.araddr;
    this.arlen = RHS.arlen;
    this.arsize = RHS.arsize;
    this.arburst = RHS.arburst;
    this.arlock = RHS.arlock;
    this.arcache = RHS.arcache;
    this.arprot = RHS.arprot;
    this.arregion = RHS.arregion;
    this.arqos = RHS.arqos;
    this.rid = RHS.rid;
    this.rdata = RHS.rdata;
    this.rlast = RHS.rlast;
    this.rvalid = RHS.rvalid;
    this.rresp = RHS.rresp;
    this.ruser = RHS.ruser;
    this.no_of_wait_states = RHS.no_of_wait_states;
    this.tx_type = RHS.tx_type;
    this.transfer_type = RHS.transfer_type;
    this.wait_count_write_address_channel = RHS.wait_count_write_address_channel;
    this.wait_count_write_data_channel = RHS.wait_count_write_data_channel;
    this.wait_count_write_response_channel = RHS.wait_count_write_response_channel;
    this.wait_count_read_address_channel = RHS.wait_count_read_address_channel;
    this.wait_count_read_data_channel = RHS.wait_count_read_data_channel;
    this.outstanding_write_tx = RHS.outstanding_write_tx;
    this.outstanding_read_tx = RHS.outstanding_read_tx;
    // pragma uvmf custom do_copy end
  endfunction

  // ****************************************************************************
  // FUNCTION: add_to_wave()
  // This function is used to display variables in this class in the waveform 
  // viewer.  The start_time and end_time variables must be set before this 
  // function is called.  If the start_time and end_time variables are not set
  // the transaction will be hidden at 0ns on the waveform display.
  // 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    `ifdef QUESTA
    if (transaction_view_h == 0) begin
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"AXI4_SLAVE_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,awaddr,"awaddr");
    $add_attribute(transaction_view_h,awid,"awid");
    $add_attribute(transaction_view_h,awlen,"awlen");
    $add_attribute(transaction_view_h,awsize,"awsize");
    $add_attribute(transaction_view_h,awburst,"awburst");
    $add_attribute(transaction_view_h,awlock,"awlock");
    $add_attribute(transaction_view_h,awcache,"awcache");
    $add_attribute(transaction_view_h,awqos,"awqos");
    $add_attribute(transaction_view_h,awprot,"awprot");
    $add_attribute(transaction_view_h,endian,"endian");
    $add_attribute(transaction_view_h,wdata,"wdata");
    $add_attribute(transaction_view_h,wstrb,"wstrb");
    $add_attribute(transaction_view_h,wlast,"wlast");
    $add_attribute(transaction_view_h,wuser,"wuser");
    $add_attribute(transaction_view_h,bid,"bid");
    $add_attribute(transaction_view_h,bresp,"bresp");
    $add_attribute(transaction_view_h,buser,"buser");
    $add_attribute(transaction_view_h,arid,"arid");
    $add_attribute(transaction_view_h,araddr,"araddr");
    $add_attribute(transaction_view_h,arlen,"arlen");
    $add_attribute(transaction_view_h,arsize,"arsize");
    $add_attribute(transaction_view_h,arburst,"arburst");
    $add_attribute(transaction_view_h,arlock,"arlock");
    $add_attribute(transaction_view_h,arcache,"arcache");
    $add_attribute(transaction_view_h,arprot,"arprot");
    $add_attribute(transaction_view_h,arregion,"arregion");
    $add_attribute(transaction_view_h,arqos,"arqos");
    $add_attribute(transaction_view_h,rid,"rid");
    $add_attribute(transaction_view_h,rdata,"rdata");
    $add_attribute(transaction_view_h,rlast,"rlast");
    $add_attribute(transaction_view_h,rvalid,"rvalid");
    $add_attribute(transaction_view_h,rresp,"rresp");
    $add_attribute(transaction_view_h,ruser,"ruser");
    $add_attribute(transaction_view_h,no_of_wait_states,"no_of_wait_states");
    $add_attribute(transaction_view_h,tx_type,"tx_type");
    $add_attribute(transaction_view_h,transfer_type,"transfer_type");
    $add_attribute(transaction_view_h,wait_count_write_address_channel,"wait_count_write_address_channel");
    $add_attribute(transaction_view_h,wait_count_write_data_channel,"wait_count_write_data_channel");
    $add_attribute(transaction_view_h,wait_count_write_response_channel,"wait_count_write_response_channel");
    $add_attribute(transaction_view_h,wait_count_read_address_channel,"wait_count_read_address_channel");
    $add_attribute(transaction_view_h,wait_count_read_data_channel,"wait_count_read_data_channel");
    $add_attribute(transaction_view_h,outstanding_write_tx,"outstanding_write_tx");
    $add_attribute(transaction_view_h,outstanding_read_tx,"outstanding_read_tx");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

