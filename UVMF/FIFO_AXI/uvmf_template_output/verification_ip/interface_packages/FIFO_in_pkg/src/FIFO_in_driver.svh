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
class FIFO_in_driver   extends uvmf_driver_base #(
                   .CONFIG_T(FIFO_in_configuration   ),
                   .BFM_BIND_T(virtual FIFO_in_driver_bfm   ),
                   .REQ(FIFO_in_transaction   ),
                   .RSP(FIFO_in_transaction   ));

  `uvm_component_utils( FIFO_in_driver )
//*******************************************************************
// Macros that define structs located in FIFO_in_macros.svh
//*******************************************************************
// Initiator macro used by FIFO_in_driver and FIFO_in_driver_bfm
// to communicate initiator driven data to FIFO_in_driver_bfm.           
`FIFO_in_INITIATOR_STRUCT
  FIFO_in_initiator_s FIFO_in_initiator_struct;
//*******************************************************************
// Responder macro used by FIFO_in_driver and FIFO_in_driver_bfm
// to communicate Responder driven data to FIFO_in_driver_bfm.
`FIFO_in_RESPONDER_STRUCT
  FIFO_in_responder_s FIFO_in_responder_struct;

// pragma uvmf custom class_item_additional begin
// pragma uvmf custom class_item_additional end

// ****************************************************************************
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent=null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// This function sends configuration object variables to the driver BFM 
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
    bfm.proxy = this; 
  endfunction

// **************************************************************************** 
// This task is called by the run_phase in uvmf_driver_base.              
  virtual task access( inout REQ txn );
// pragma uvmf custom access begin
    if (configuration.initiator_responder==RESPONDER) begin
      // Complete current transfer and wait for next transfer
      bfm.respond_and_wait_for_next_transfer( 
          FIFO_in_initiator_struct, 
          txn.to_responder_struct() 
          );
      // Unpack information about initiated transfer received by this responder
      txn.from_initiator_struct(FIFO_in_initiator_struct);
    end else begin    
      // Initiate a transfer and get response
      bfm.initiate_and_get_response( 
          txn.to_initiator_struct(), 
          FIFO_in_responder_struct 
          );
      // Unpack transfer response information received by this initiator
      txn.from_responder_struct(FIFO_in_responder_struct);
    end
// Added by ksiddhan

 if(txn.write_en)
       begin
            if(txn.pkt_type_enum==write_phase_pkt)
                write_addr_phase_pkt();
        else 
             if(txn.pkt_type_enum==read_phase_pkt)
               read_addr_phase_pkt();
       end

        
       if (txn.read_en==1'b1) 
        begin
         bus.rd_en<= txn.read_en;
        end

 endtask

/* task reset_fifo(txn);

  @(posedge bus.clk) 
    
   begin
    bus.rst <= txn.rst;
   end

 endtask */

 task read_add_phase_pkt();
  
  bit[127:0] read_addr_pkt;

  read_addr_pkt = {txn.SOP,
              txn.txn_id,
	            txn.addr,
	            txn.len,
	            txn.size,
	            txn.burst,
	            txn.lock,
	            txn.cache,
	            txn.prot,
	            txn.strobe,
	            8'b0,
              txn.EOP,
              48'h0};

   @(posedge bus.clk);
      begin
       bus.rd_data    <= read_addr_pkt;
       bus.rd_en    <= txn.read_en;
      end
  `uvm_info("DRIVER", $psprintf("The BFM has the following parameters: rdata = %0d", bus.rd_data),UVM_NONE)

  endtask

 task write_addr_phase_pkt();

  parameter WIDTH = (2**3)*8;
  bit [127:0] write_addr_pkt;
//  bit [WIDTH-1:0] data;

//  data = txn.wdata;

  write_addr_pkt = {txn.SOP,
              txn.txn_id,
	            txn.addr,
	            txn.len,
	            txn.size,
	            txn.burst,
	            txn.lock,
	            txn.cache,
	            txn.prot,
	            txn.strobe,
	            txn.wdata,
              txn.EOP};
   
  @(posedge bus.clk);
      begin
       bus.wr_data    <= write_addr_pkt;
       bus.wr_en    <= txn.write_en;
      end
  `uvm_info("DRIVER", $psprintf("The BFM has the following parameters: wdata = %0d", bus.wr_data),UVM_NONE)
//end of lines by ksiddhan
// pragma uvmf custom access end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

