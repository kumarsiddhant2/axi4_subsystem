//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class passes transactions between the sequencer
//        and the BFM driver interface.  It accesses the driver BFM 
//        through the bfm handle. This driver
//        passes transactions to the driver BFM through the access
//        task.  
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class AXI4_SLAVE_driver   extends uvmf_driver_base #(
                   .CONFIG_T(AXI4_SLAVE_configuration   ),
                   .BFM_BIND_T(virtual AXI4_SLAVE_driver_bfm   ),
                   .REQ(AXI4_SLAVE_transaction   ),
                   .RSP(AXI4_SLAVE_transaction   ));

  `uvm_component_utils( AXI4_SLAVE_driver )
//*******************************************************************
// Macros that define structs located in AXI4_SLAVE_macros.svh
//*******************************************************************
// Initiator macro used by AXI4_SLAVE_driver and AXI4_SLAVE_driver_bfm
// to communicate initiator driven data to AXI4_SLAVE_driver_bfm.           
`AXI4_SLAVE_INITIATOR_STRUCT
  AXI4_SLAVE_initiator_s AXI4_SLAVE_initiator_struct;
//*******************************************************************
// Responder macro used by AXI4_SLAVE_driver and AXI4_SLAVE_driver_bfm
// to communicate Responder driven data to AXI4_SLAVE_driver_bfm.
`AXI4_SLAVE_RESPONDER_STRUCT
  AXI4_SLAVE_responder_s AXI4_SLAVE_responder_struct;

// pragma uvmf custom class_item_additional begin
// pragma uvmf custom class_item_additional end

// ****************************************************************************
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent=null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// Ths function sends configuration object variables to the driver BFM 
// using the configuration struct.
//
  virtual function void configure(input CONFIG_T cfg);
      bfm.configure( cfg.to_struct() );
  endfunction

// ****************************************************************************
// This function places a handle to this class in the proxy variable in the
// driver BFM.  This allows the driver BFM to call tasks and function within this class.
//
  virtual function void set_bfm_proxy_handle();
    bfm.proxy = this;  endfunction

// **************************************************************************** 
// This task is called by the run_phase in uvmf_driver_base.              
  virtual task access( inout REQ txn );
// pragma uvmf custom access begin
    if (configuration.initiator_responder==RESPONDER) begin
      // Complete current transfer and wait for next transfer
      bfm.respond_and_wait_for_next_transfer( 
          AXI4_SLAVE_initiator_struct, 
          txn.to_responder_struct() 
          );

        bfm.wait_for_system_reset();      //NOTE:Added
       //added 
          fork 
           axi4_write_task();
           //axi4_read_task();
         join

      // Unpack information about initiated transfer received by this responder
      txn.from_initiator_struct(AXI4_SLAVE_initiator_struct);
    end else begin    
      // Initiate a transfer and get response
      bfm.initiate_and_get_response( 
          txn.to_initiator_struct(), 
          AXI4_SLAVE_responder_struct 
          );
      // Unpack transfer response information received by this initiator
      txn.from_responder_struct(AXI4_SLAVE_responder_struct);
    end
// pragma uvmf custom access end
//  axi4_slave_drv_bfm_h.wait_for_system_reset();  //NOTE: commented  
  endtask

// pragma uvmf custom external begin
// pragma uvmf custom external end

// added write and read task 

task axi4_write_task();
  
  forever begin
    
    process addr_tx;
    process data_tx;
    process response_tx;

//NOTE: commented
/*    axi_write_seq_item_port.get_next_item(req_wr);

    // writting the req into write data and response fifo's
    axi4_slave_write_data_in_fifo_h.put(req_wr);
    axi4_slave_write_response_fifo_h.put(req_wr);      */  
    
    fork
    begin : WRITE_ADDRESS_CHANNEL
      
//      axi4_slave_tx              local_slave_addr_tx;       commented
      axi4_write_transfer_char_s struct_write_packet;
      axi4_transfer_cfg_s        struct_cfg;
//      bit[3:0]                   local_awid;                //commented
    
      //returns status of address thread
      addr_tx=process::self();
      
//NOTE: need to check 
/*      //Converting transactions into struct data type
      axi4_slave_seq_item_converter::from_write_class(req_wr,struct_write_packet);
      `uvm_info(get_type_name(), $sformatf("from_write_class:: struct_write_packet = \n %0p",struct_write_packet), UVM_HIGH); 

     //Converting configurations into struct config type
     axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h,struct_cfg);
     `uvm_info(get_type_name(), $sformatf("from_write_class:: struct_cfg =  \n %0p",struct_cfg),UVM_HIGH);
 */   

     //write address_task
//     axi4_slave_drv_bfm_h.axi4_write_address_phase(struct_write_packet);  NOTE: commented line and calling phase task using bfm handle

     bfm.axi4_write_address_phase(AXI4_SLAVE_initiator_struct);     //NOTE added bfm handle

//NOTE : commented 
/* 
     if(axi4_slave_agent_cfg_h.slave_response_mode == WRITE_READ_RESP_OUT_OF_ORDER || axi4_slave_agent_cfg_h.slave_response_mode == ONLY_WRITE_RESP_OUT_OF_ORDER) begin
       if(response_id_queue.size() == 0) begin
         response_id_queue.push_back(struct_write_packet.awid);
       end
       else begin
         // condition to check if the same id's are coming back to back
         if(struct_write_packet.awid == response_id_queue[$]) begin
           drive_id_cont = 1'b1;
           local_awid = response_id_queue.pop_back();
           response_id_cont_queue.push_back(local_awid);
           response_id_cont_queue.push_back(struct_write_packet.awid);
         end
         else begin
           response_id_queue.push_back(struct_write_packet.awid);
         end
       end
     end

     //Converting struct into transaction data type
     axi4_slave_seq_item_converter::to_write_class(struct_write_packet,local_slave_addr_tx);

     if((axi4_slave_agent_cfg_h.qos_mode_type == ONLY_WRITE_QOS_MODE_ENABLE) || (axi4_slave_agent_cfg_h.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE)) begin
        qos_queue.push_front(local_slave_addr_tx);
      end
     
     `uvm_info("DEBUG_SLAVE_WRITE_ADDR_PROXY", $sformatf("AFTER :: Received req packet \n %s",local_slave_addr_tx.sprint()), UVM_NONE);
     
     // putting write address data into address fifo
     if(axi4_slave_write_addr_fifo_h.is_full) begin
       `uvm_error(get_type_name(),$sformatf("WRITE_ADDR_THREAD::Cannot put into FIFO as WRITE_FIFO is FULL"));
     end
     else begin
       axi4_slave_write_addr_fifo_h.put(local_slave_addr_tx);
     end
     wr_addr_cnt++;
   */

   end
 
  begin : WRITE_DATA_CHANNEL

    //  axi4_slave_tx              local_slave_data_tx;     //commented
      axi4_write_transfer_char_s struct_write_packet;
      axi4_transfer_cfg_s        struct_cfg;   
      
      //returns status of write data thread
      data_tx=process::self();

/*      // Trying to get the write key 
            semaphore_write_key.get(1);

      //getting the data from write data fifo
      axi4_slave_write_data_in_fifo_h.get(local_slave_data_tx);
      
      //Converting transactions into struct data type
      axi4_slave_seq_item_converter::from_write_class(local_slave_data_tx,struct_write_packet);
      `uvm_info(get_type_name(), $sformatf("from_write_class:: struct_write_packet = \n %0p",struct_write_packet), UVM_HIGH); 

      //Converting configurations into struct config type
     axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h,struct_cfg);
      `uvm_info(get_type_name(), $sformatf("from_write_class:: struct_cfg =  \n %0p",struct_cfg),UVM_HIGH);

*/
      // write data_task
      axi4_slave_drv_bfm_h.axi4_write_data_phase(struct_write_packet,struct_cfg );  
 //     `uvm_info("DEBUG_SLAVE_WDATA_PROXY", $sformatf("AFTER :: Reciving struct pkt from bfm \n%p",struct_write_packet), UVM_HIGH);
     
      
 /*     //Converting struct into transaction data type
      axi4_slave_seq_item_converter::to_write_class(struct_write_packet,local_slave_data_tx);


     `uvm_info("DEBUG_SLAVE_WDATA_PROXY_TO_CLASS", $sformatf("AFTER TO CLASS :: Received req packet \n %s", local_slave_data_tx.sprint()), UVM_NONE);

     //putting the write data into write data out fifo 
      axi4_slave_write_data_out_fifo_h.put(local_slave_data_tx);

      //putting back the semaphore key
      semaphore_write_key.put(1);   
      
      */
    
    end
  
  begin : WRITE_RESPONSE_CHANNEL

/*      axi4_slave_tx              local_slave_addr_tx;
      axi4_slave_tx              local_slave_data_tx;
      axi4_slave_tx              local_slave_response_tx;
      axi4_slave_tx              packet;
      axi4_slave_tx              qos_value_check_1;
      axi4_write_transfer_char_s struct_write_packet;
      axi4_transfer_cfg_s        struct_cfg;
      bit[3:0]                   bid_local;
      int                        end_wrap_addr;
      bit                        slave_err;
 */     
      //returns status of response thread
      response_tx=process::self();

      data_tx.await();
      
      //getting the key from semaphore 
/*      semaphore_rsp_write_key.get(1);

      if((axi4_slave_agent_cfg_h.qos_mode_type == ONLY_WRITE_QOS_MODE_ENABLE) || (axi4_slave_agent_cfg_h.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE)) begin
        qos_value_check_1 = qos_queue[$];
        for(int i=0;i<qos_queue.size();i++) begin
          if(qos_queue[i].awqos >= qos_value_check_1.awqos) begin
            qos_value_check_1 = qos_queue[i];
            queue_index = i;
          end
        end
        local_slave_response_tx = qos_queue[queue_index];
        qos_queue.delete(queue_index);
      end
      else begin 
        if(axi4_slave_write_response_fifo_h.is_empty) begin
          `uvm_error(get_type_name(),$sformatf("WRITE_RESP_THREAD::Cannot get write resp data from FIFO as WRITE_RESP_FIFO is EMPTY"));
        end
        else begin
          //getting the data from response fifo
          axi4_slave_write_response_fifo_h.get(local_slave_response_tx);
        end
      end

      
      //Converting transactions into struct data type
      axi4_slave_seq_item_converter::from_write_class(local_slave_response_tx,struct_write_packet);
      `uvm_info(get_type_name(), $sformatf("from_write_class:: struct_write_packet = \n %0p",struct_write_packet), UVM_HIGH); 

      //Converting configurations into struct config type
      axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h,struct_cfg);
      `uvm_info(get_type_name(), $sformatf("from_write_class:: struct_cfg =  \n %0p",struct_cfg),UVM_HIGH);

      //check for fifo empty if not get the data 
      if((axi4_slave_agent_cfg_h.qos_mode_type == ONLY_WRITE_QOS_MODE_ENABLE) || (axi4_slave_agent_cfg_h.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE)) begin
        local_slave_addr_tx = local_slave_response_tx;
        struct_write_packet.bid = awid_queue_for_qos.pop_front();
      end
      else begin
        if(axi4_slave_write_addr_fifo_h.is_empty) begin
          `uvm_info("DEBUG_FIFO",$sformatf("fifo_size = %0d",axi4_slave_write_addr_fifo_h.size()),UVM_HIGH)
          `uvm_error(get_type_name(),$sformatf("WRITE_RESP_THREAD::Cannot get write addr data from FIFO as WRITE_ADDR_FIFO is EMPTY"));
        end
        else begin
         axi4_slave_write_addr_fifo_h.get(local_slave_addr_tx);
         `uvm_info("DEBUG_FIFO",$sformatf("fifo_size = %0d",axi4_slave_write_addr_fifo_h.size()),UVM_HIGH)
         `uvm_info("DEBUG_FIFO",$sformatf("fifo_used =%0d",axi4_slave_write_addr_fifo_h.used()),UVM_HIGH)
        end
      end

      if(local_slave_addr_tx.awburst == WRITE_FIXED) begin
        end_wrap_addr =  local_slave_addr_tx.awaddr + ((2**local_slave_addr_tx.awsize));
      end
      if(local_slave_addr_tx.awburst == WRITE_INCR) begin
        end_wrap_addr =  local_slave_addr_tx.awaddr + ((local_slave_addr_tx.awlen+1)*(2**local_slave_addr_tx.awsize));
      end
      if(local_slave_addr_tx.awburst == WRITE_WRAP) begin
         end_wrap_addr = local_slave_addr_tx.awaddr - int'(local_slave_addr_tx.awaddr%((local_slave_addr_tx.awlen+1)*(2**local_slave_addr_tx.awsize)));
         end_wrap_addr = end_wrap_addr + ((local_slave_addr_tx.awlen+1)*(2**local_slave_addr_tx.awsize));
      end
      `uvm_info("get_type_name",$sformatf("end_addr=%0h",end_wrap_addr),UVM_HIGH);

      `uvm_info("slave_driver_proxy",$sformatf("min_tx=%0d",axi4_slave_agent_cfg_h.get_minimum_transactions),UVM_HIGH)
      if(axi4_slave_agent_cfg_h.slave_response_mode == WRITE_READ_RESP_OUT_OF_ORDER || axi4_slave_agent_cfg_h.slave_response_mode == ONLY_WRITE_RESP_OUT_OF_ORDER) begin
        wait(axi4_slave_write_data_out_fifo_h.size > axi4_slave_agent_cfg_h.get_minimum_transactions); //begin
          `uvm_info("slave_driver_proxy",$sformatf("fifo_size = %0d",axi4_slave_write_data_out_fifo_h.used()),UVM_HIGH)
          if(drive_id_cont == 1) begin
            bid_local = response_id_cont_queue.pop_front(); 
            `uvm_info("slave_driver_proxy",$sformatf("bid_local = %0d",bid_local),UVM_HIGH)
            `uvm_info("slave_driver_proxy",$sformatf("drive_id_cont = %0d",drive_id_cont),UVM_HIGH)
            if(response_id_cont_queue.size()==0) drive_id_cont = 1'b0;
          end
          else begin
            response_id_queue.shuffle();
            bid_local = response_id_queue.pop_front(); 
            `uvm_info("slave_driver_proxy",$sformatf("bid_local = %0d",bid_local),UVM_HIGH)
          end
          if(axi4_slave_agent_cfg_h.read_data_mode == SLAVE_MEM_MODE || axi4_slave_agent_cfg_h.read_data_mode == SLAVE_ERR_RESP_MODE) begin
             if(!((local_slave_addr_tx.awaddr inside {[axi4_slave_agent_cfg_h.min_address :
               axi4_slave_agent_cfg_h.max_address]}) && (end_wrap_addr inside
               {[axi4_slave_agent_cfg_h.min_address : axi4_slave_agent_cfg_h.max_address]}))) begin
               struct_write_packet.bresp = WRITE_SLVERR;
               slave_err = 1;
             end
          end

	  */
          // write response_task
          bfm.axi4_write_response_phase(struct_write_packet,struct_cfg,bid_local);
   /*       `uvm_info("DEBUG_SLAVE_WDATA_PROXY", $sformatf("AFTER :: Reciving struct pkt from bfm \n %p",struct_write_packet), UVM_HIGH);
      //  end
      end
      else begin
       if(axi4_slave_agent_cfg_h.read_data_mode == SLAVE_MEM_MODE || axi4_slave_agent_cfg_h.read_data_mode == SLAVE_ERR_RESP_MODE) begin
          if(!((local_slave_addr_tx.awaddr inside {[axi4_slave_agent_cfg_h.min_address :
            axi4_slave_agent_cfg_h.max_address]}) && (end_wrap_addr inside
            {[axi4_slave_agent_cfg_h.min_address : axi4_slave_agent_cfg_h.max_address]}))) begin
            struct_write_packet.bresp = WRITE_SLVERR;
            slave_err = 1;
          end
        end
        // write response_task
        axi4_slave_drv_bfm_h.axi4_write_response_phase(struct_write_packet,struct_cfg,bid_local);
        `uvm_info("DEBUG_SLAVE_WDATA_PROXY", $sformatf("AFTER :: Reciving struct pkt from bfm \n %p",struct_write_packet), UVM_HIGH);
      end

      //Converting struct into transaction data type
      axi4_slave_seq_item_converter::to_write_class(struct_write_packet,local_slave_response_tx);

     `uvm_info("DEBUG_SLAVE_WDATA_PROXY_TO_CLASS", $sformatf("AFTER TO CLASS :: Received req packet \n %s", local_slave_response_tx.sprint()), UVM_NONE);
     

      axi4_slave_write_data_out_fifo_h.get(local_slave_data_tx);

     //Calling combined data packet from converter class
     axi4_slave_seq_item_converter::tx_write_packet(local_slave_addr_tx,local_slave_data_tx,local_slave_response_tx,packet);
     `uvm_info("DEBUG_SLAVE_WDATA_PROXY", $sformatf("AFTER :: COMBINED WRITE CHANNEL PACKET \n%s",packet.sprint()), UVM_NONE);

     //calling task memory write to store the data into slave memory
     if(axi4_slave_agent_cfg_h.read_data_mode == SLAVE_MEM_MODE && ~slave_err) begin
       task_memory_write(packet);
     end
     wr_resp_cnt++;
     if(wr_addr_cnt == wr_resp_cnt) begin
       completed_initial_txn=1;
     end
     
     semaphore_rsp_write_key.put(1);
     */

   end
 
  join_any

  //checking the status of write address thread
  addr_tx.await();
  `uvm_info("SLAVE_STATUS_CHECK",$sformatf("AFTER_FORK_JOIN_ANY:: SLAVE_ADDRESS_CHANNEL_STATUS =\n %s",addr_tx.status()),UVM_MEDIUM)
  `uvm_info("SLAVE_STATUS_CHECK",$sformatf("AFTER_FORK_JOIN_ANY:: SLAVE_WDATA_CHANNEL_STATUS = \n %s",data_tx.status()),UVM_MEDIUM)
  `uvm_info("SLAVE_STATUS_CHECK",$sformatf("AFTER_FORK_JOIN_ANY:: SLAVE_WRESP_CHANNEL_STATUS = \n%s",response_tx.status()),UVM_MEDIUM)
   
   //axi_write_seq_item_port.item_done();

 end
 
 endtask : axi4_write_task




/*
//-------------------------------------------------------
// task axi4 read task
//-------------------------------------------------------
task AXI4_SLAVE_driver::axi4_read_task();
  
  forever begin
    
    //Declaring the process for read address channel and read data channel for status check 
    process rd_addr;
    process rd_data;

    axi_read_seq_item_port.get_next_item(req_rd);
    

    //putting the data into read data fifo
    axi4_slave_read_data_in_fifo_h.put(req_rd);

    fork
    begin : READ_ADDRESS_CHANNEL
      
      axi4_slave_tx              local_slave_tx;
      axi4_read_transfer_char_s struct_read_packet;
      axi4_read_transfer_char_s oor_struct_read_packet;
      axi4_transfer_cfg_s       struct_cfg;
      
      //returns status of address thread
      rd_addr = process::self();
      
      //Converting transactions into struct data type
      axi4_slave_seq_item_converter::from_read_class(req_rd,struct_read_packet);
      `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_read_packet = \n %0p",struct_read_packet), UVM_HIGH); 
      
      //Converting configurations into struct config type
      axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h,struct_cfg);
      `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_cfg =  \n %0p",struct_cfg),UVM_HIGH);
      
      //read address_task
      axi4_slave_drv_bfm_h.axi4_read_address_phase(struct_read_packet,struct_cfg);


     // Storing data for enabling out_of_order feature
     if(axi4_slave_agent_cfg_h.slave_response_mode == WRITE_READ_RESP_OUT_OF_ORDER || axi4_slave_agent_cfg_h.slave_response_mode == ONLY_READ_RESP_OUT_OF_ORDER) begin
       if(rd_response_id_queue.size() == 0) begin
         rd_response_id_queue.push_back(struct_read_packet);
       end
       else begin
         // condition to check if the same id's are coming back to back
         oor_struct_read_packet = rd_response_id_queue[$];
         if(struct_read_packet.arid == oor_struct_read_packet.arid) begin
           drive_rd_id_cont = 1'b1;
           oor_struct_read_packet = rd_response_id_queue.pop_back();
           rd_response_id_cont_queue.push_back(oor_struct_read_packet);
           rd_response_id_cont_queue.push_back(struct_read_packet);
         end
         else begin
           rd_response_id_queue.push_back(struct_read_packet);
         end
       end
     end
      
     //Converting struct into transaction data type
     axi4_slave_seq_item_converter::to_read_class(struct_read_packet,local_slave_tx);
     `uvm_info("DEBUG_SLAVE_READ_ADDR_PROXY", $sformatf(" to_class_raddr_phase_slave_proxy  \n %p",struct_read_packet), UVM_HIGH);

     if((axi4_slave_agent_cfg_h.qos_mode_type == ONLY_READ_QOS_MODE_ENABLE) || (axi4_slave_agent_cfg_h.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE)) begin
        qos_read_queue.push_front(local_slave_tx);
      end
     
     //Putting back the sampled read address data into fifo
     axi4_slave_read_addr_fifo_h.put(local_slave_tx);
     `uvm_info("DEBUG_SLAVE_READ_ADDR_PROXY", $sformatf("AFTER :: Received req packet \n %s",local_slave_tx.sprint()), UVM_NONE);
    
   end
  
   begin : READ_DATA_CHANNEL
    
     axi4_slave_tx              local_slave_rdata_tx;
     axi4_slave_tx              local_slave_raddr_tx;
     axi4_slave_tx              local_slave_addr_chk_tx;
     axi4_slave_tx              qos_value_check_1;
     axi4_slave_tx              packet;
     axi4_read_transfer_char_s  struct_read_packet;
     axi4_transfer_cfg_s        struct_cfg;
     int                        total_bytes;

     //returns status of data thread
     rd_data = process::self();


     //Waiting for the read address thread to complete
     rd_addr.await();

     //Getting the key from semaphore
     semaphore_read_key.get(1);

     if((axi4_slave_agent_cfg_h.qos_mode_type == ONLY_READ_QOS_MODE_ENABLE) || (axi4_slave_agent_cfg_h.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE)) begin
       if(axi4_slave_agent_cfg_h.read_data_mode == SLAVE_MEM_MODE) begin 
         wait(completed_initial_txn==1);
       end
       if(qos_wait_enable) begin
         wait(qos_read_queue.size>=2);
       end
       qos_wait_enable = 1'b0;
       qos_value_check_1 = qos_read_queue[$];
       for(int i=0;i<qos_read_queue.size();i++) begin
         if(qos_read_queue[i].arqos >= qos_value_check_1.arqos) begin
           qos_value_check_1 = qos_read_queue[i];
           read_queue_index = i;
         end
       end
       //Getting the data from read data fifo
       //axi4_slave_read_data_in_fifo_h.get(local_slave_rdata_tx);
       //local_slave_rdata_tx.rid = rid_e'(qos_read_queue[read_queue_index].arid);
       local_slave_rdata_tx =  qos_read_queue[read_queue_index];
       qos_read_queue.delete(read_queue_index);
     end
     else begin
       //Getting the data from read data fifo
       axi4_slave_read_data_in_fifo_h.get(local_slave_rdata_tx);
     end

     if(((axi4_slave_agent_cfg_h.read_data_mode == RANDOM_DATA_MODE) || (write_read_mode_h == ONLY_READ_DATA)) && (axi4_slave_agent_cfg_h.read_data_mode !== SLAVE_MEM_MODE)) begin
       

       //Converting transactions into struct data type
       axi4_slave_seq_item_converter::from_read_class(local_slave_rdata_tx,struct_read_packet);
       `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_read_packet = \n %0p",struct_read_packet), UVM_HIGH); 
 
       //Converting configurations into struct config type
       axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h,struct_cfg);
       `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_cfg =  \n %0p",struct_cfg),UVM_HIGH);
       
       //Task to check the out_of_order enable and updates the read structure 
       if((axi4_slave_agent_cfg_h.slave_response_mode == ONLY_READ_RESP_OUT_OF_ORDER) || (axi4_slave_agent_cfg_h.slave_response_mode == WRITE_READ_RESP_OUT_OF_ORDER) ) begin
         out_of_order_for_reads(struct_read_packet);
         `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_read_packet = \n %0p",struct_read_packet), UVM_HIGH); 
       end
       
       //read data task
       axi4_slave_drv_bfm_h.axi4_read_data_phase(struct_read_packet,struct_cfg,axi4_slave_agent_cfg_h.slave_response_mode);
       `uvm_info("DEBUG_SLAVE_RDATA_PROXY", $sformatf("AFTER :: READ CHANNEL PACKET \n %p",struct_read_packet), UVM_HIGH);
     end
     else if (axi4_slave_agent_cfg_h.read_data_mode == SLAVE_MEM_MODE || axi4_slave_agent_cfg_h.read_data_mode == SLAVE_ERR_RESP_MODE && write_read_mode_h != ONLY_READ_DATA) begin

       wait(completed_initial_txn==1);
       //Converting transactions into struct data type
       axi4_slave_seq_item_converter::from_read_class(local_slave_rdata_tx,struct_read_packet);
       `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_read_packet = \n %0p",struct_read_packet), UVM_HIGH); 
 
       //Converting configurations into struct config type
       axi4_slave_cfg_converter::from_class(axi4_slave_agent_cfg_h,struct_cfg);
       `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_cfg =  \n %0p",struct_cfg),UVM_HIGH);

       if((axi4_slave_agent_cfg_h.slave_response_mode == ONLY_READ_RESP_OUT_OF_ORDER) || (axi4_slave_agent_cfg_h.slave_response_mode == WRITE_READ_RESP_OUT_OF_ORDER) ) begin
         out_of_order_for_reads(struct_read_packet);
         `uvm_info(get_type_name(), $sformatf("from_read_class:: struct_read_packet = \n %0p",struct_read_packet), UVM_HIGH); 
       end

     if((axi4_slave_agent_cfg_h.qos_mode_type == ONLY_READ_QOS_MODE_ENABLE) || (axi4_slave_agent_cfg_h.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE)) begin
        local_slave_addr_chk_tx = local_slave_rdata_tx;
      end
      else begin
        axi4_slave_read_addr_fifo_h.peek(local_slave_addr_chk_tx);
      end
      total_bytes = (local_slave_addr_chk_tx.arlen+1)*(2**(local_slave_addr_chk_tx.arsize));
      if(local_slave_addr_chk_tx.araddr inside {[axi4_slave_agent_cfg_h.min_address : axi4_slave_agent_cfg_h.max_address]}) begin : ADDR_INSIDE_SLAVE_MEM_RANGE
        if(local_slave_addr_chk_tx.arburst == READ_FIXED) begin
          task_memory_read(local_slave_addr_chk_tx,struct_read_packet);
          if(crossed_read_addr) begin 
            for(int depth=0;depth<(local_slave_addr_chk_tx.arlen+1);depth++) begin
              struct_read_packet.rresp[depth] = READ_SLVERR; 
            end
          end
          else begin 
            struct_read_packet.rresp = READ_OKAY;
          end
          //read data task
          axi4_slave_drv_bfm_h.axi4_read_data_phase(struct_read_packet,struct_cfg,axi4_slave_agent_cfg_h.slave_response_mode);
          `uvm_info("DEBUG_SLAVE_RDATA_PROXY", $sformatf("AFTER :: READ_CHANNEL_PACKET \n%p",struct_read_packet), UVM_NONE);
        end
        else if(local_slave_addr_chk_tx.arburst == READ_WRAP || local_slave_addr_chk_tx.arburst == READ_INCR) begin
          if(axi4_slave_mem_h.is_slave_addr_exists(local_slave_addr_chk_tx.araddr)) begin 
            task_memory_read(local_slave_addr_chk_tx,struct_read_packet);
            for(int j=0,int loc=0;j<total_bytes;j++) begin
              if((local_slave_addr_chk_tx.araddr+j)==crossed_read_addr) begin
                loc = j/STROBE_WIDTH;
                for(int depth=0;depth<(local_slave_addr_chk_tx.arlen+1);depth++) begin
                  if(depth > loc) struct_read_packet.rresp[depth] = READ_SLVERR;
                  else struct_read_packet.rresp[depth] = READ_OKAY;
                end
                break;
              end
            end
            //read data task
            axi4_slave_drv_bfm_h.axi4_read_data_phase(struct_read_packet,struct_cfg,axi4_slave_agent_cfg_h.slave_response_mode);
            `uvm_info("DEBUG_SLAVE_RDATA_PROXY", $sformatf("AFTER :: READ_CHANNEL_PACKET \n%p",struct_read_packet), UVM_NONE);
          end
          else begin
            axi4_slave_agent_cfg_h.user_rdata = (local_slave_addr_chk_tx.arsize ==
            READ_1_BYTE)?32'ha:((local_slave_addr_chk_tx.arsize ==
            READ_2_BYTES)?32'haa:((local_slave_addr_chk_tx.arsize ==
            READ_4_BYTES)?32'hdead_beaf:{DATA_WIDTH{16'habcd}}));
            for(int i=0;i<local_slave_addr_chk_tx.arlen+1;i++) begin
              struct_read_packet.rdata[i] =  axi4_slave_agent_cfg_h.user_rdata;
            end
            //read data task
            axi4_slave_drv_bfm_h.axi4_read_data_phase(struct_read_packet,struct_cfg,axi4_slave_agent_cfg_h.slave_response_mode);
            `uvm_info("DEBUG_SLAVE_RDATA_PROXY", $sformatf("AFTER :: READ_CHANNEL_PACKET \n%p",struct_read_packet), UVM_HIGH);
            `uvm_error("AXI4_SLAVE_DRIVER_PROXY",$sformatf("ADDRESS trying to read DOESN'T EXIST in the slave memory... READING DEFAULT VALUES...."));
          end
        end
      end
      else begin : ADDR_NOT_INSIDE_SLAVE_MEM_RANGE
        for(int depth=0;depth<(((axi4_slave_agent_cfg_h.slave_response_mode == WRITE_READ_RESP_OUT_OF_ORDER)
          || (axi4_slave_agent_cfg_h.slave_response_mode == ONLY_READ_RESP_OUT_OF_ORDER) ||
          (axi4_slave_agent_cfg_h.qos_mode_type == ONLY_READ_QOS_MODE_ENABLE) ||
          (axi4_slave_agent_cfg_h.qos_mode_type == WRITE_READ_QOS_MODE_ENABLE))  ? (struct_read_packet.arlen+1) : (local_slave_addr_chk_tx.arlen+1));depth++) begin
          struct_read_packet.rresp[depth] = READ_SLVERR; 
        end

        //read data task
        axi4_slave_drv_bfm_h.axi4_read_data_phase(struct_read_packet,struct_cfg,axi4_slave_agent_cfg_h.slave_response_mode);
        `uvm_info("DEBUG_SLAVE_RDATA_PROXY", $sformatf("AFTER :: READ CHANNEL PACKET \n %p",struct_read_packet), UVM_HIGH);
      end
     end
     //Calling converter class for reads to convert struct to req
     axi4_slave_seq_item_converter::to_read_class(struct_read_packet,local_slave_rdata_tx);
     `uvm_info("DEBUG_SLAVE_RDATA_PROXY", $sformatf("AFTER :: READ CHANNEL PACKET \n %s",local_slave_rdata_tx.sprint()), UVM_NONE);

     //Getting teh sampled read address from read address fifo
     axi4_slave_read_addr_fifo_h.get(local_slave_raddr_tx);
    
     //Calling the Combined coverter class to combine read address and read data packet
     axi4_slave_seq_item_converter::tx_read_packet(local_slave_raddr_tx,local_slave_rdata_tx,packet);
     `uvm_info("DEBUG_SLAVE_RDATA_PROXY", $sformatf("AFTER :: COMBINED READ CHANNEL PACKET \n%s",packet.sprint()), UVM_NONE);
     
     //Putting back the key
     semaphore_read_key.put(1);
   end
  join_any
 
  //Check the status of read address thread
  rd_addr.await();
  `uvm_info("SLAVE_STATUS_CHECK",$sformatf("AFTER_FORK_JOIN_ANY:: SLAVE_READ_CHANNEL_STATUS = \n %s",rd_addr.status()),UVM_MEDIUM)
  `uvm_info("SLAVE_STATUS_CHECK",$sformatf("AFTER_FORK_JOIN_ANY:: SLAVE_RDATA_CHANNEL_STATUS = \n %s",rd_data.status()),UVM_MEDIUM)

  axi_read_seq_item_port.item_done();
end

endtask : axi4_read_task



*/


endclass
