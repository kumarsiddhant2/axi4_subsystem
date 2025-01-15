//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// Description: This file contains the top level and utility sequences
//     used by test_top. It can be extended to create derivative top
//     level sequences.
//
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//


typedef FIFO2AXI_env_configuration  FIFO2AXI_env_configuration_t;

class FIFO2AXI_bench_sequence_base extends uvmf_sequence_base #(uvm_sequence_item);

  `uvm_object_utils( FIFO2AXI_bench_sequence_base );

  // pragma uvmf custom sequences begin

// This example shows how to use the environment sequence base
// It can only be used on environments generated with UVMF_2022.3 and later.
// Environment sequences generated with UVMF_2022.1 and earlier do not have the required 
//    environment level virtual sequencer
// typedef FIFO2AXI_env_sequence_base #(
//         .CONFIG_T(FIFO2AXI_env_configuration_t)// 
//         )
//         FIFO2AXI_env_sequence_base_t;
// rand FIFO2AXI_env_sequence_base_t FIFO2AXI_env_seq;



  // UVMF_CHANGE_ME : Instantiate, construct, and start sequences as needed to create stimulus scenarios.
  // Instantiate sequences here
  typedef FIFO_in_random_sequence  FIFO_agent_random_seq_t;
  FIFO_agent_random_seq_t FIFO_agent_random_seq;
  typedef AXI4_SLAVE_responder_sequence  AXI4_SLAVE_agent_responder_seq_t;
  AXI4_SLAVE_agent_responder_seq_t AXI4_SLAVE_agent_responder_seq;
  // pragma uvmf custom sequences end

  // Sequencer handles for each active interface in the environment
  typedef FIFO_in_transaction  FIFO_agent_transaction_t;
  uvm_sequencer #(FIFO_agent_transaction_t)  FIFO_agent_sequencer; 
  typedef AXI4_SLAVE_transaction  AXI4_SLAVE_agent_transaction_t;
  uvm_sequencer #(AXI4_SLAVE_agent_transaction_t)  AXI4_SLAVE_agent_sequencer; 


  // Top level environment configuration handle
  FIFO2AXI_env_configuration_t top_configuration;

  // Configuration handles to access interface BFM's
  FIFO_in_configuration  FIFO_agent_config;
  AXI4_SLAVE_configuration  AXI4_SLAVE_agent_config;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // ****************************************************************************
  function new( string name = "" );
    super.new( name );
    // Retrieve the configuration handles from the uvm_config_db

    // Retrieve top level configuration handle
    if ( !uvm_config_db#(FIFO2AXI_env_configuration_t)::get(null,UVMF_CONFIGURATIONS, "TOP_ENV_CONFIG",top_configuration) ) begin
      `uvm_info("CFG", "*** FATAL *** uvm_config_db::get can not find TOP_ENV_CONFIG.  Are you using an older UVMF release than what was used to generate this bench?",UVM_NONE);
      `uvm_fatal("CFG", "uvm_config_db#(FIFO2AXI_env_configuration_t)::get cannot find resource TOP_ENV_CONFIG");
    end

    // Retrieve config handles for all agents
    if( !uvm_config_db #( FIFO_in_configuration )::get( null , UVMF_CONFIGURATIONS , FIFO_agent_BFM , FIFO_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( FIFO_in_configuration )::get cannot find resource FIFO_agent_BFM" )
    if( !uvm_config_db #( AXI4_SLAVE_configuration )::get( null , UVMF_CONFIGURATIONS , AXI4_SLAVE_agent_BFM , AXI4_SLAVE_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( AXI4_SLAVE_configuration )::get cannot find resource AXI4_SLAVE_agent_BFM" )

    // Assign the sequencer handles from the handles within agent configurations
    FIFO_agent_sequencer = FIFO_agent_config.get_sequencer();
    AXI4_SLAVE_agent_sequencer = AXI4_SLAVE_agent_config.get_sequencer();



    // pragma uvmf custom new begin
    // pragma uvmf custom new end

  endfunction

  // ****************************************************************************
  virtual task body();
    // pragma uvmf custom body begin

    // Construct sequences here

    // FIFO2AXI_env_seq = FIFO2AXI_env_sequence_base_t::type_id::create("FIFO2AXI_env_seq");

    FIFO_agent_random_seq     = FIFO_agent_random_seq_t::type_id::create("FIFO_agent_random_seq");
    AXI4_SLAVE_agent_responder_seq  = AXI4_SLAVE_agent_responder_seq_t::type_id::create("AXI4_SLAVE_agent_responder_seq");
    fork
      FIFO_agent_config.wait_for_reset();
      AXI4_SLAVE_agent_config.wait_for_reset();
    join
    // Start RESPONDER sequences here
    fork
      AXI4_SLAVE_agent_responder_seq.start(AXI4_SLAVE_agent_sequencer);
    join_none
    // Start INITIATOR sequences here
    fork
      repeat (25) FIFO_agent_random_seq.start(FIFO_agent_sequencer);
    join

// FIFO2AXI_env_seq.start(top_configuration.vsqr);

    // UVMF_CHANGE_ME : Extend the simulation XXX number of clocks after 
    // the last sequence to allow for the last sequence item to flow 
    // through the design.
    fork
      FIFO_agent_config.wait_for_num_clocks(400);
      AXI4_SLAVE_agent_config.wait_for_num_clocks(400);
    join

    // pragma uvmf custom body end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

