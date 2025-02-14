//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the FIFO_in transaction and sends it 
// to the UVM driver.
//
// This sequence constructs and randomizes a FIFO_in_transaction.
// 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class FIFO_in_random_sequence 
  extends FIFO_in_sequence_base ;

  `uvm_object_utils( FIFO_in_random_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  //*****************************************************************
  function new(string name = "");
    super.new(name);
  endfunction: new

  // ****************************************************************************
  // TASK : body()
  // This task is automatically executed when this sequence is started using the 
  // start(sequencerHandle) task.
  //
  task body();
  
      // Construct the transaction
      req=FIFO_in_transaction::type_id::create("req");
      start_item(req);
      // Randomize the transaction
      if(!req.randomize()) `uvm_fatal("SEQ", "FIFO_in_random_sequence::body()-FIFO_in_transaction randomization failed")
      // Send the transaction to the FIFO_in_driver_bfm via the sequencer and FIFO_in_driver.
      finish_item(req);
      `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)

  endtask

endclass: FIFO_in_random_sequence

// pragma uvmf custom external begin
// pragma uvmf custom external end

