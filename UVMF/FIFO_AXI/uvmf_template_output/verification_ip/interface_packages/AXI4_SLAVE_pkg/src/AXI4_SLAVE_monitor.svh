//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class receives AXI4_SLAVE transactions observed by the
//     AXI4_SLAVE monitor BFM and broadcasts them through the analysis port
//     on the agent. It accesses the monitor BFM through the monitor
//     task. This UVM component captures transactions
//     for viewing in the waveform viewer if the
//     enable_transaction_viewing flag is set in the configuration.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class AXI4_SLAVE_monitor  extends uvmf_monitor_base #(
                    .CONFIG_T(AXI4_SLAVE_configuration  ),
                    .BFM_BIND_T(virtual AXI4_SLAVE_monitor_bfm  ),
                    .TRANS_T(AXI4_SLAVE_transaction  ));

  `uvm_component_utils( AXI4_SLAVE_monitor )

// Structure used to pass data from monitor BFM to monitor class in agent.
// Use to_monitor_struct function to pack transaction variables into structure.
// Use from_monitor_struct function to unpack transaction variables from structure.
`AXI4_SLAVE_MONITOR_STRUCT

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
// ****************************************************************************
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// This function sends configuration object variables to the monitor BFM 
// using the configuration struct.
//
   virtual function void configure(input CONFIG_T cfg);
      bfm.configure( cfg.to_struct() );

   endfunction

// ****************************************************************************
// This function places a handle to this class in the proxy variable in the
// monitor BFM.  This allows the monitor BFM to call the notify_transaction
// function within this class.
//
   virtual function void set_bfm_proxy_handle();
      bfm.proxy = this;   endfunction

// ***************************************************************************              
  virtual task run_phase(uvm_phase phase);                                                   
  // Start monitor BFM thread and don't call super.run() in order to                       
  // override the default monitor proxy 'pull' behavior with the more                      
  // emulation-friendly BFM 'push' approach using the notify_transaction                   
  // function below                                                                        
  bfm.start_monitoring();     

//NOTE: calling the tasks
   bfm.wait_for_aresetn();
  fork 
    axi4_slave_write_address();
    axi4_slave_write_data();
    axi4_slave_write_response();
  join


  endtask                                                                                    
  
// **************************************************************************  
  
// This function is called by the monitor BFM.  It receives data observed by the
// monitor BFM.  Data is passed using the AXI4_SLAVE_monitor_struct.          
 virtual function void notify_transaction(input AXI4_SLAVE_monitor_s AXI4_SLAVE_monitor_struct);
 
 
    trans = new("trans");
    trans.from_monitor_struct(AXI4_SLAVE_monitor_struct);
    trans.start_time = time_stamp;                                                          
    trans.end_time = $time;                                                                 
    time_stamp = trans.end_time;
 
    analyze(trans);                                                                         
  endfunction  


// pragma uvmf custom external begin
// pragma uvmf custom external end


//NOTE: Added the task which is called inside runphse



// Task : axi4_slave_write_address
// Description: converting,sampling and again converting 
//--------------------------------------------------------------------------------------------
task axi4_slave_write_address();
  forever begin

      axi4_transfer_cfg_s        struct_cfg;
  //  axi4_slave_tx              req_wr_clone_packet;        //commmented
     AXI4_SLAVE_transaction       req_wr_clone_packet;       //added

  //  axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h, struct_cfg);    //commented
  //  bfm.axi4_slave_write_address_sampling(struct_write_packet,struct_cfg);       //commented
      bfm.axi4_slave_write_address_sampling(AXI4_SLAVE_MONITOR_STRUCT,struct_cfg);
 //   axi4_slave_seq_item_converter::to_write_class(struct_write_packet,req_wr);        //commented
     
    axi4_slave_write_address_fifo_h.write(req_wr);

//    $cast(req_wr_clone_packet,req_wr.clone());        commneted
//    `uvm_info(get_type_name(),$sformatf("Packet received from axi4_slave_write_address_sampling is %s",req_wr_clone_packet.sprint()),UVM_HIGH)    commneted

    axi4_slave_write_address_analysis_port.write(req_wr_clone_packet );     
    // axi4_slave_write_address_analysis_port.write(AXI4_SLAVE_transaction); added commented

  end
endtask
//--------------------------------------------------------------------------------------------
// Task: axi4_slave_write_data
//  Gets the struct packet samples the data, convert it to req and drives to analysis port
//--------------------------------------------------------------------------------------------

task axi4_slave_write_data();
  forever begin
     

    axi4_transfer_cfg_s        struct_cfg;
//    axi4_slave_tx             req_wr_clone_packet;         //commented
//    axi4_slave_tx             local_write_addr_packet;       //commented
    
//    axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h, struct_cfg);           //commented
//    axi4_slave_mon_bfm_h.axi4_slave_write_data_sampling(struct_write_packet,struct_cfg);   //commented
     bfm.axi4_slave_write_data_sampling( AXI4_SLAVE_MONITOR_STRUCT,struct_cfg);                                             //addeed bfm handle
//    axi4_slave_seq_item_converter::to_write_class(struct_write_packet,req_wr);           //commented
    
    //Getting the write address packet
    axi4_slave_write_address_fifo_h.get(local_write_addr_packet);
 //   `uvm_info(get_type_name(),$sformatf("ADDR_Packet received from fifo is \n %s",local_write_addr_packet.sprint()),UVM_HIGH)      //commented
    
    //Combining write address and write data packets
//    axi4_slave_seq_item_converter::to_write_addr_data_class(local_write_addr_packet,struct_write_packet,req_wr);    //commented

    axi4_slave_write_data_fifo_h.write(req_wr);

    //clone and publish the clone to the analysis port 
/*    $cast(req_wr_clone_packet,req_wr.clone());
    `uvm_info(get_type_name(),$sformatf("Packet received from axi4_slave_write_data is \n %s",req_wr_clone_packet.sprint()),UVM_HIGH)   */

    axi4_slave_write_data_analysis_port.write(req_wr);
  end

endtask
//--------------------------------------------------------------------------------------------
// Task: axi4_slave_write_response
//  Gets the struct packet samples the data, convert it to req and drives to analysis port
//--------------------------------------------------------------------------------------------

task axi4_slave_write_response();

  forever begin
        axi4_transfer_cfg_s        struct_cfg;
  //  axi4_slave_tx             axi4_slave_tx_clone_packet;       //commented
  //  axi4_slave_tx             local_write_addr_data_packet;      //commented`

//    axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h, struct_cfg);    //commented
 //   bfm.axi4_write_response_sampling(struct_write_packet,struct_cfg);               // commented 
     bfm.axi4_write_response_sampling(AXI4_SLAVE_MONITOR_STRUCT,struct_cfg);               // added
//    axi4_slave_seq_item_converter::to_write_class(struct_write_packet,req_wr);    //commented
    
    //Getting the write address packet
    axi4_slave_write_data_fifo_h.get(local_write_addr_data_packet);
    
 /*   //Combining write address and write data packets
    axi4_slave_seq_item_converter::to_write_addr_data_resp_class(local_write_addr_data_packet,struct_write_packet,req_wr);

    //clone and publish the clone to the analysis port 
    $cast(axi4_slave_tx_clone_packet,req_wr.clone());
    `uvm_info(get_type_name(),$sformatf("Packet received from axi4_slave_write_response is \n %s",axi4_slave_tx_clone_packet.sprint()),UVM_HIGH);   */
    
    axi4_slave_write_response_analysis_port.write(req_wr_clone_packet);
  end
endtask

endclass

















