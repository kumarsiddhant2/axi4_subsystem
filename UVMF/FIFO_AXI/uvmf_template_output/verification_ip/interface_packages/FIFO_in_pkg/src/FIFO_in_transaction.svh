//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an FIFO_in
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class FIFO_in_transaction  extends uvmf_transaction_base;

  parameter ADDR_WIDTH=32;
  parameter DATA_WIDTH = (2**3) * 8;
  

  typedef enum {read_phase_pkt, write_phase_pkt} pkt_type;
  bit [7:0] sop = 8'h1010_1010;
  bit [7:0] eop = 8'h0101_0011; 

  rand bit [3:0] txn_id ;
  rand bit [ADDR_WIDTH-1:0] addr ;
  rand bit [3:0] len ;
  rand bit [2:0] size ;
  rand bit [1:0] burst ;
  rand bit [1:0] lock ;
  rand bit [1:0] cache ;
  rand bit [2:0] prot ;
  rand bit [3:0] strobe ;
  rand bit [DATA_WIDTH-1:0] wdata ;
//  rand bit [DATA_WIDTH-1:0] rdata ;
  bit [7:0] rdata ;
 
  rand bit write_en;
  rand bit read_en;
  bit fifo_full;
  bit fifo_empty;
  pkt_type pkt_type_enum;

  `uvm_object_utils_begin( FIFO_in_transaction )
  `uvm_field_int(sop,UVM_DEFAULT)
  `uvm_field_int(eop,UVM_DEFAULT)
  `uvm_field_int(txn_id,UVM_DEFAULT)
  `uvm_field_enum(pkt_type,pkt_type_enum,UVM_DEFAULT)
  `uvm_field_int(addr,UVM_DEFAULT)
  `uvm_field_int(len,UVM_DEFAULT)
  `uvm_field_int(size,UVM_DEFAULT)
  `uvm_field_int(burst,UVM_DEFAULT)
  `uvm_field_int(lock,UVM_DEFAULT)
  `uvm_field_int(cache,UVM_DEFAULT)
  `uvm_field_int(prot,UVM_DEFAULT)
  `uvm_field_int(strobe,UVM_DEFAULT)
  `uvm_field_int(wdata,UVM_DEFAULT)
  `uvm_field_int(write_en,UVM_DEFAULT)
  `uvm_field_int(read_en,UVM_DEFAULT)
  `uvm_field_int(fifo_full,UVM_DEFAULT)
  `uvm_field_int(fifo_empty,UVM_DEFAULT)
  `uvm_field_int(rdata,UVM_DEFAULT)
  `uvm_object_utils_end

  //Constraints for the transaction variables:

   // dummy cpu provied the alligned address

         constraint alligned_addr { addr%32==0;}

      // size of wdata

        constraint size_of_data { wdata ==len+1;}

    //4kb boundary condition
 
        constraint boundary_addr_check { addr % 4096 + (2**size * (len + 1)) <= 4096;}  

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in FIFO_in_macros.svh

  //*******************************************************************
  // Monitor macro used by FIFO_in_monitor and FIFO_in_monitor_bfm
  // This struct is defined in FIFO_in_macros.svh
  `FIFO_in_MONITOR_STRUCT
    FIFO_in_monitor_s FIFO_in_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a FIFO_in_monitor_s
  // structure.  The function returns the handle to the FIFO_in_monitor_struct.
  // This function is defined in FIFO_in_macros.svh
  `FIFO_in_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in FIFO_in_macros.svh
  `FIFO_in_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by FIFO_in_driver and FIFO_in_driver_bfm
  // to communicate initiator driven data to FIFO_in_driver_bfm.
  // This struct is defined in FIFO_in_macros.svh
  `FIFO_in_INITIATOR_STRUCT
    FIFO_in_initiator_s FIFO_in_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a FIFO_in_initiator_s
  // structure.  The function returns the handle to the FIFO_in_initiator_struct.
  // This function is defined in FIFO_in_macros.svh
  `FIFO_in_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in FIFO_in_macros.svh
  `FIFO_in_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by FIFO_in_driver and FIFO_in_driver_bfm
  // to communicate Responder driven data to FIFO_in_driver_bfm.
  // This struct is defined in FIFO_in_macros.svh
  `FIFO_in_RESPONDER_STRUCT
    FIFO_in_responder_s FIFO_in_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a FIFO_in_responder_s
  // structure.  The function returns the handle to the FIFO_in_responder_struct.
  // This function is defined in FIFO_in_macros.svh
  `FIFO_in_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in FIFO_in_macros.svh
  `FIFO_in_FROM_RESPONDER_STRUCT_FUNCTION 
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
    return $sformatf("sop:0x%x txn_id:0x%x addr:0x%x len:0x%x size:0x%x burst:0x%x lock:0x%x cache:0x%x prot:0x%x strobe:0x%x wdata:0x%x rdata:0x%x eop:0x%x ",sop,txn_id,addr,len,size,burst,lock,cache,prot,strobe,wdata,rdata,eop);
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
    FIFO_in_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.sop == RHS.sop)
            &&(this.txn_id == RHS.txn_id)
            &&(this.addr == RHS.addr)
            &&(this.len == RHS.xlen)
            &&(this.size == RHS.xsize)
            &&(this.burst == RHS.burst)
            &&(this.lock == RHS.lock)
            &&(this.cache == RHS.cache)
            &&(this.prot == RHS.prot)
            &&(this.strobe == RHS.strobe)
            &&(this.wdata == RHS.wdata)
            &&(this.rdata == RHS.rdata)
            &&(this.eop == RHS.eop)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    FIFO_in_transaction  RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.sop = RHS.sop;
    this.txn_id = RHS.txn_id;
    this.addr = RHS.addr;
    this.len = RHS.len;
    this.size = RHS.size;
    this.burst = RHS.burst;
    this.lock = RHS.lock;
    this.cache = RHS.cache;
    this.prot = RHS.prot;
    this.strobe = RHS.strobe;
    this.wdata = RHS.wdata;
    this.rdata = RHS.rdata;
    this.eop = RHS.eop;
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
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"FIFO_in_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,sop,"sop");
    $add_attribute(transaction_view_h,txn_id,"txn_id");
    $add_attribute(transaction_view_h,addr,"addr");
    $add_attribute(transaction_view_h,len,"len");
    $add_attribute(transaction_view_h,size,"size");
    $add_attribute(transaction_view_h,burst,"burst");
    $add_attribute(transaction_view_h,lock,"lock");
    $add_attribute(transaction_view_h,cache,"cache");
    $add_attribute(transaction_view_h,prot,"prot");
    $add_attribute(transaction_view_h,strobe,"strobe");
    $add_attribute(transaction_view_h,wdata,"wdata");
    $add_attribute(transaction_view_h,rdata,"rdata");
    $add_attribute(transaction_view_h,eop,"eop");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

