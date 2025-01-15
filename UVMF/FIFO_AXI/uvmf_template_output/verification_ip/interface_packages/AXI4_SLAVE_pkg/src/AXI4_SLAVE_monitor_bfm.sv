//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the AXI4_SLAVE signal monitoring.
//      It is accessed by the uvm AXI4_SLAVE monitor through a virtual
//      interface handle in the AXI4_SLAVE configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type AXI4_SLAVE_if.
//
//     Input signals from the AXI4_SLAVE_if are assigned to an internal input
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
//                   blocks until an operation on the AXI4_SLAVE bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import AXI4_SLAVE_pkg_hdl::*;
`include "src/AXI4_SLAVE_macros.svh"


interface AXI4_SLAVE_monitor_bfm 
  ( AXI4_SLAVE_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute AXI4_SLAVE_monitor_bfm partition_interface_xif                                  

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
`AXI4_SLAVE_MONITOR_STRUCT
  AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `AXI4_SLAVE_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri ACLK_i;
  tri ARESETn_i;
  tri [3:0] AWID_a_i;
  tri [31:0] AWADDR_a_i;
  tri [3:0] AWLEN_a_i;
  tri [2:0] AWSIZE_a_i;
  tri [1:0] AWBURST_a_i;
  tri [1:0] AWLOCK_a_i;
  tri [1:0] AWCACHE_a_i;
  tri [2:0] AWPROT_a_i;
  tri  AWVALID_a_i;
  tri  AWREADY_a_i;
  tri [3:0] WID_a_i;
  tri [63:0] WDATA_a_i;
  tri [3:0] WSTRB_a_i;
  tri  WLAST_a_i;
  tri  WVALID_a_i;
  tri  WREADY_a_i;
  tri [3:0] BID_a_i;
  tri [1:0] BRESP_a_i;
  tri  BVALID_a_i;
  tri  BREADY_a_i;
  tri [3:0] ARID_a_i;
  tri [31:0] ARADDR_a_i;
  tri [3:0] ARLEN_a_i;
  tri [2:0] ARSIZE_a_i;
  tri [1:0] ARBURST_a_i;
  tri [1:0] ARLOCK_a_i;
  tri [1:0] ARCACHE_a_i;
  tri [2:0] ARPROT_a_i;
  tri  ARVALID_a_i;
  tri  ARREADY_a_i;
  tri [3:0] RID_a_i;
  tri [63:0] RDATA_a_i;
  tri [1:0] RRESP_a_i;
  tri  RLAST_a_i;
  tri  RVALID_a_i;
  tri  RREADY_a_i;
  tri  wr_rsp_en_i;
  tri  rd_rsp_en_i;
  assign ACLK_i = bus.ACLK;
  assign ARESETn_i = bus.ARESETn;
  assign AWID_a_i = bus.AWID_a;
  assign AWADDR_a_i = bus.AWADDR_a;
  assign AWLEN_a_i = bus.AWLEN_a;
  assign AWSIZE_a_i = bus.AWSIZE_a;
  assign AWBURST_a_i = bus.AWBURST_a;
  assign AWLOCK_a_i = bus.AWLOCK_a;
  assign AWCACHE_a_i = bus.AWCACHE_a;
  assign AWPROT_a_i = bus.AWPROT_a;
  assign AWVALID_a_i = bus.AWVALID_a;
  assign AWREADY_a_i = bus.AWREADY_a;
  assign WID_a_i = bus.WID_a;
  assign WDATA_a_i = bus.WDATA_a;
  assign WSTRB_a_i = bus.WSTRB_a;
  assign WLAST_a_i = bus.WLAST_a;
  assign WVALID_a_i = bus.WVALID_a;
  assign WREADY_a_i = bus.WREADY_a;
  assign BID_a_i = bus.BID_a;
  assign BRESP_a_i = bus.BRESP_a;
  assign BVALID_a_i = bus.BVALID_a;
  assign BREADY_a_i = bus.BREADY_a;
  assign ARID_a_i = bus.ARID_a;
  assign ARADDR_a_i = bus.ARADDR_a;
  assign ARLEN_a_i = bus.ARLEN_a;
  assign ARSIZE_a_i = bus.ARSIZE_a;
  assign ARBURST_a_i = bus.ARBURST_a;
  assign ARLOCK_a_i = bus.ARLOCK_a;
  assign ARCACHE_a_i = bus.ARCACHE_a;
  assign ARPROT_a_i = bus.ARPROT_a;
  assign ARVALID_a_i = bus.ARVALID_a;
  assign ARREADY_a_i = bus.ARREADY_a;
  assign RID_a_i = bus.RID_a;
  assign RDATA_a_i = bus.RDATA_a;
  assign RRESP_a_i = bus.RRESP_a;
  assign RLAST_a_i = bus.RLAST_a;
  assign RVALID_a_i = bus.RVALID_a;
  assign RREADY_a_i = bus.RREADY_a;
  assign wr_rsp_en_i = bus.wr_rsp_en;
  assign rd_rsp_en_i = bus.rd_rsp_en;

  // Proxy handle to UVM monitor
  AXI4_SLAVE_pkg::AXI4_SLAVE_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge ACLK_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( ARESETn_i === 1 ) ;                                                              
    @(posedge ACLK_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge ACLK_i);  
                                                                   
    repeat (count-1) @(posedge ACLK_i);                                                    
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
      @(posedge ACLK_i);  
      do_monitor( AXI4_SLAVE_monitor_struct );
                                                                 
 
      proxy.notify_transaction( AXI4_SLAVE_monitor_struct );
 
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
    function void configure(AXI4_SLAVE_configuration_s AXI4_SLAVE_configuration_arg); // pragma tbx xtf  
    initiator_responder = AXI4_SLAVE_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct);
    //
    // Available struct members:
    //     //    AXI4_SLAVE_monitor_struct.awaddr
    //     //    AXI4_SLAVE_monitor_struct.awid
    //     //    AXI4_SLAVE_monitor_struct.awlen
    //     //    AXI4_SLAVE_monitor_struct.awsize
    //     //    AXI4_SLAVE_monitor_struct.awburst
    //     //    AXI4_SLAVE_monitor_struct.awlock
    //     //    AXI4_SLAVE_monitor_struct.awcache
    //     //    AXI4_SLAVE_monitor_struct.awqos
    //     //    AXI4_SLAVE_monitor_struct.awprot
    //     //    AXI4_SLAVE_monitor_struct.endian
    //     //    AXI4_SLAVE_monitor_struct.wdata
    //     //    AXI4_SLAVE_monitor_struct.wstrb
    //     //    AXI4_SLAVE_monitor_struct.wlast
    //     //    AXI4_SLAVE_monitor_struct.wuser
    //     //    AXI4_SLAVE_monitor_struct.bid
    //     //    AXI4_SLAVE_monitor_struct.bresp
    //     //    AXI4_SLAVE_monitor_struct.buser
    //     //    AXI4_SLAVE_monitor_struct.arid
    //     //    AXI4_SLAVE_monitor_struct.araddr
    //     //    AXI4_SLAVE_monitor_struct.arlen
    //     //    AXI4_SLAVE_monitor_struct.arsize
    //     //    AXI4_SLAVE_monitor_struct.arburst
    //     //    AXI4_SLAVE_monitor_struct.arlock
    //     //    AXI4_SLAVE_monitor_struct.arcache
    //     //    AXI4_SLAVE_monitor_struct.arprot
    //     //    AXI4_SLAVE_monitor_struct.arregion
    //     //    AXI4_SLAVE_monitor_struct.arqos
    //     //    AXI4_SLAVE_monitor_struct.rid
    //     //    AXI4_SLAVE_monitor_struct.rdata
    //     //    AXI4_SLAVE_monitor_struct.rlast
    //     //    AXI4_SLAVE_monitor_struct.rvalid
    //     //    AXI4_SLAVE_monitor_struct.rresp
    //     //    AXI4_SLAVE_monitor_struct.ruser
    //     //    AXI4_SLAVE_monitor_struct.no_of_wait_states
    //     //    AXI4_SLAVE_monitor_struct.tx_type
    //     //    AXI4_SLAVE_monitor_struct.transfer_type
    //     //    AXI4_SLAVE_monitor_struct.wait_count_write_address_channel
    //     //    AXI4_SLAVE_monitor_struct.wait_count_write_data_channel
    //     //    AXI4_SLAVE_monitor_struct.wait_count_write_response_channel
    //     //    AXI4_SLAVE_monitor_struct.wait_count_read_address_channel
    //     //    AXI4_SLAVE_monitor_struct.wait_count_read_data_channel
    //     //    AXI4_SLAVE_monitor_struct.outstanding_write_tx
    //     //    AXI4_SLAVE_monitor_struct.outstanding_read_tx
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge ACLK_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      AXI4_SLAVE_monitor_struct.xyz = AWID_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWADDR_a_i;  //    [31:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWLEN_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWSIZE_a_i;  //    [2:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWBURST_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWLOCK_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWCACHE_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWPROT_a_i;  //    [2:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = AWVALID_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = AWREADY_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = WID_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = WDATA_a_i;  //    [63:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = WSTRB_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = WLAST_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = WVALID_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = WREADY_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = BID_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = BRESP_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = BVALID_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = BREADY_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = ARID_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARADDR_a_i;  //    [31:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARLEN_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARSIZE_a_i;  //    [2:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARBURST_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARLOCK_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARCACHE_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARPROT_a_i;  //    [2:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = ARVALID_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = ARREADY_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = RID_a_i;  //    [3:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = RDATA_a_i;  //    [63:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = RRESP_a_i;  //    [1:0] 
    //      AXI4_SLAVE_monitor_struct.xyz = RLAST_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = RVALID_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = RREADY_a_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = wr_rsp_en_i;  //     
    //      AXI4_SLAVE_monitor_struct.xyz = rd_rsp_en_i;  //     
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
    @(posedge ACLK_i);
    @(posedge ACLK_i);
    @(posedge ACLK_i);
    @(posedge ACLK_i);
    // pragma uvmf custom do_monitor end
  endtask         
  
 
//endinterface     //commented

// pragma uvmf custom external begin
// pragma uvmf custom external end
 //-------------------------------------------------------

//NOTE: added the task which is called inside monitor.svh
// Task: wait_for_aresetn
// Waiting for the system reset to be active low
//-------------------------------------------------------

  task wait_for_aresetn();
    @(negedge ARESETn_i);
    `uvm_info("FROM SLAVE MON BFM",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
   
    @(posedge ARESETn_i);
    `uvm_info("FROM SLAVE MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

//-------------------------------------------------------
  // Task: axi4_slave_write_address_sampling
  // Used for sample the write address channel signals
  //-------------------------------------------------------
  task axi4_slave_write_address_sampling(output AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct  ,input axi4_transfer_cfg_s cfg);

    @(posedge ACLK_i);
    `uvm_info("FROM SLAVE MON BFM",$sformatf("from axi4_slave_write_address_sampling "),UVM_HIGH)

    while(AWVALID_a_i !==1 || AWREADY_a_i !==1)begin
      @(posedge ACLK_i);
      `uvm_info("FROM SLAVE MON BFM",$sformatf("Inside while loop from axi4_slave_write_address_sampling"),UVM_HIGH)
    end    
    
    `uvm_info("FROM SLAVE MON BFM",$sformatf("after while loop from axi4_slave_write_address_sampling "),UVM_HIGH)
   
    //AXI4_SLAVE_monitor_struct.awid = AWID_a_i;
    AXI4_SLAVE_monitor_struct.awid = awid_e'(AWID_a_i);
    AXI4_SLAVE_monitor_struct.awaddr = AWADDR_a_i;
    AXI4_SLAVE_monitor_struct.awlen =  AWLEN_a_i;
    AXI4_SLAVE_monitor_struct.awsize =  awsize_e'(AWSIZE_a_i);
   AXI4_SLAVE_monitor_struct.awburst = awburst_e'(AWBURST_a_i);
   AXI4_SLAVE_monitor_struct.awlock =  awlock_e'(AWLOCK_a_i);
    AXI4_SLAVE_monitor_struct.awcache =  awcache_e'(AWCACHE_a_i);
    AXI4_SLAVE_monitor_struct.awprot =  awprot_e'(AWPROT_a_i);  
   `uvm_info("FROM SLAVE MON BFM",$sformatf("after while loop from axi4_slave_write_addres"),UVM_HIGH)
  endtask

  //-------------------------------------------------------
  // Task: axi4_slave_write_data_sampling
  // Used for sample the write data channel signals
  //-------------------------------------------------------
  task axi4_slave_write_data_sampling(output AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct  ,input axi4_transfer_cfg_s cfg);
  
  forever begin
   // wait for valid and ready to be high
   do begin
   @(posedge ACLK_i);
   end while(WVALID_a_i !==1 || WREADY_a_i !==1);

   `uvm_info("FROM SLAVE MON BFM",$sformatf("Inside while loop......"),UVM_HIGH)
   AXI4_SLAVE_monitor_struct.wdata = WDATA_a_i;
   AXI4_SLAVE_monitor_struct.wstrb =  WSTRB_a_i;
   AXI4_SLAVE_monitor_struct.wlast =  WLAST_a_i;
  //  req.wuser[i] = wuser WUSER_a;   commented

   `uvm_info("FROM SLAVE MON BFM write data",$sformatf("write datapacket wdata = 'h"),UVM_HIGH)
   `uvm_info("FROM SLAVE MON BFM write data",$sformatf("write datapacket wstrb = 'h"),UVM_HIGH)
//   if(req.wlast == 1)begin
     `uvm_info("FROM SLAVE MON BFM write data",$sformatf("Inside wlast write datapacket"),UVM_HIGH)
 //  i = 0;  commented
  // break;
//   end
  
  // i++;
  end
 endtask
 
  //-------------------------------------------------------
  // Task: axi4_write_response_sampling
  // Used for sample the write response channel signals
  //-------------------------------------------------------
  task axi4_write_response_sampling(output AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct  ,input axi4_transfer_cfg_s cfg);
  @(posedge ACLK_i);
    while(BVALID_a_i !==1 || BREADY_a_i !==1)begin
    `uvm_info("FROM SLAVE MON BFM",$sformatf("values :: bvalid= & bready="),UVM_HIGH)
      @(posedge ACLK_i);
      `uvm_info("FROM SLAVE MON BFM",$sformatf("Inside while loop of write response sample"),UVM_HIGH)
    end    
    `uvm_info("FROM SLAVE MON BFM",$sformatf("after while loop of write response "),UVM_HIGH)
    
    @(posedge ACLK_i);
   AXI4_SLAVE_monitor_struct.bid      =bid_e'(BID_a_i);
   AXI4_SLAVE_monitor_struct.bresp  = bresp_e'(BRESP_a_i);  
    `uvm_info("FROM SLAVE MON BFM WRITE RESPONSE",$sformatf("write response packet"),UVM_HIGH)
  endtask


 endinterface 

  
