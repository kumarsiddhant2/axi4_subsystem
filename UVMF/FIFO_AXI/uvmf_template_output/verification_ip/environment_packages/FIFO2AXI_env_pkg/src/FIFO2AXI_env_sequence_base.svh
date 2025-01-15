//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains environment level sequences that will
//    be reused from block to top level simulations.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class FIFO2AXI_env_sequence_base #( 
      type CONFIG_T,
      bit FIFO_DATA_WIDTH = 128,
      bit FIFO_ADDR_WIDTH = 32,
      bit AXI_ADDR_WIDTH = 32,
      bit AXI_WID_WIDTH = 4,
      bit AXI_LEN_WIDTH = 4,
      bit AXI_SIZE_WIDTH = 3,
      bit AXI_BURST_WIDTH = 2,
      bit AXI_LOCK_WIDTH = 2,
      bit AXI_CACHE_WIDTH = 2,
      bit AXI_PROT_WIDTH = 3,
      bit AXI_STRB_WIDTH = 4
      ) extends uvmf_virtual_sequence_base #(.CONFIG_T(CONFIG_T));


  `uvm_object_param_utils( FIFO2AXI_env_sequence_base #(
                           CONFIG_T,
                           FIFO_DATA_WIDTH,
                           FIFO_ADDR_WIDTH,
                           AXI_ADDR_WIDTH,
                           AXI_WID_WIDTH,
                           AXI_LEN_WIDTH,
                           AXI_SIZE_WIDTH,
                           AXI_BURST_WIDTH,
                           AXI_LOCK_WIDTH,
                           AXI_CACHE_WIDTH,
                           AXI_PROT_WIDTH,
                           AXI_STRB_WIDTH
                           ) );

  
// This FIFO2AXI_env_sequence_base contains a handle to a FIFO2AXI_env_configuration object 
// named configuration.  This configuration variable contains a handle to each 
// sequencer within each agent within this environment and any sub-environments.
// The configuration object handle is automatically assigned in the pre_body in the
// base class of this sequence.  The configuration handle is retrieved from the
// virtual sequencer that this sequence is started on.
// Available sequencer handles within the environment configuration:

  // Initiator agent sequencers in FIFO2AXI_environment:
    // configuration.FIFO_agent_config.sequencer

  // Responder agent sequencers in FIFO2AXI_environment:
    // configuration.AXI4_SLAVE_agent_config.sequencer


    typedef FIFO_in_random_sequence FIFO_agent_random_sequence_t;
    FIFO_agent_random_sequence_t FIFO_agent_rand_seq;



// This example shows how to use the environment sequence base for sub-environments
// It can only be used on environments generated with UVMF_2022.3 and later.
// Environment sequences generated with UVMF_2022.1 and earlier do not have the required 
//    environment level virtual sequencer


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  function new(string name = "" );
    super.new(name);
    FIFO_agent_rand_seq = FIFO_agent_random_sequence_t::type_id::create("FIFO_agent_rand_seq");


  endfunction

  virtual task body();

  
    if ( configuration.FIFO_agent_config.sequencer != null )
       repeat (25) FIFO_agent_rand_seq.start(configuration.FIFO_agent_config.sequencer);


  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

