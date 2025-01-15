//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the FIFO_in signal monitoring.
//      It is accessed by the uvm FIFO_in monitor through a virtual
//      interface handle in the FIFO_in configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type FIFO_in_if.
//
//     Input signals from the FIFO_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the FIFO_in bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import FIFO_in_pkg_hdl::*;
`include "src/FIFO_in_macros.svh"


interface FIFO_in_monitor_bfm 
  ( FIFO_in_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute FIFO_in_monitor_bfm partition_interface_xif                                  

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


  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`FIFO_in_MONITOR_STRUCT
  FIFO_in_monitor_s FIFO_in_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `FIFO_in_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clk_i;
  tri rst_i;
  tri  wr_en_i;
  tri  rd_en_i;
  tri [127:0] wr_data_i;
  tri [127:0] rd_data_i;
  tri  full_i;
  tri  empty_i;
  assign clk_i = bus.clk;
  assign rst_i = bus.rst;
  assign wr_en_i = bus.wr_en;
  assign rd_en_i = bus.rd_en;
  assign wr_data_i = bus.wr_data;
  assign rd_data_i = bus.rd_data;
  assign full_i = bus.full;
  assign empty_i = bus.empty;

  // Proxy handle to UVM monitor
  FIFO_in_pkg::FIFO_in_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clk_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( rst_i === 0 ) ;                                                              
    @(posedge clk_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clk_i);  
                                                                   
    repeat (count-1) @(posedge clk_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;                                                                                   
    forever begin                                                                        
      @(posedge clk_i);  
      do_monitor( FIFO_in_monitor_struct );
                                                                 
 
      proxy.notify_transaction( FIFO_in_monitor_struct );
 
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(FIFO_in_configuration_s FIFO_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = FIFO_in_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output FIFO_in_monitor_s FIFO_in_monitor_struct);
    //
    // Available struct members:
    //     //    FIFO_in_monitor_struct.sop
    //     //    FIFO_in_monitor_struct.txn_id
    //     //    FIFO_in_monitor_struct.addr
    //     //    FIFO_in_monitor_struct.len
    //     //    FIFO_in_monitor_struct.size
    //     //    FIFO_in_monitor_struct.burst
    //     //    FIFO_in_monitor_struct.lock
    //     //    FIFO_in_monitor_struct.cache
    //     //    FIFO_in_monitor_struct.prot
    //     //    FIFO_in_monitor_struct.strobe
    //     //    FIFO_in_monitor_struct.wdata
    //     //    FIFO_in_monitor_struct.rdata
    //     //    FIFO_in_monitor_struct.eop
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clk_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      FIFO_in_monitor_struct.xyz = wr_en_i;  //     
    //      FIFO_in_monitor_struct.xyz = rd_en_i;  //     
    //      FIFO_in_monitor_struct.xyz = wr_data_i;  //    [127:0] 
    //      FIFO_in_monitor_struct.xyz = rd_data_i;  //    [127:0] 
    //      FIFO_in_monitor_struct.xyz = full_i;  //     
    //      FIFO_in_monitor_struct.xyz = empty_i;  //     
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
    @(posedge clk_i);
    wait(bus.wr_en || bus.rd_en)
     //   FIFO_in_monitor_struct.wr_en = bus.wr_en;
        FIFO_in_monitor_struct.wdata = bus.wr_data;
        
        if(bus.rd_en) begin
     //     FIFO_in_monitor_struct.rd_en = bus.rd_en;
    @(posedge clk_i);
    FIFO_in_monitor_struct.rdata = bus.rd_data;
//    FIFO_in_monitor_struct.fifo_full = bus.full;
//    FIFO_in_monitor_struct.fifo_empty = bus.empty;
    @(posedge clk_i);
    @(posedge clk_i);
end
    // pragma uvmf custom do_monitor end
`uvm_info("MONITOR", $psprintf("The BFM has the following parameters: wdata = %0d, rdata = %0d", bus.wr_data, bus.rd_data),UVM_NONE)
endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

