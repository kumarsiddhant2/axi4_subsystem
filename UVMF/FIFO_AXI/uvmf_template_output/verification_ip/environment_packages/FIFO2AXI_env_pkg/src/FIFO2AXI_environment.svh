//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class FIFO2AXI_environment #(
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
  ) extends uvmf_environment_base #(
    .CONFIG_T( FIFO2AXI_env_configuration #(
                      .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH),
                      .FIFO_ADDR_WIDTH(FIFO_ADDR_WIDTH),
                      .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
                      .AXI_WID_WIDTH(AXI_WID_WIDTH),
                      .AXI_LEN_WIDTH(AXI_LEN_WIDTH),
                      .AXI_SIZE_WIDTH(AXI_SIZE_WIDTH),
                      .AXI_BURST_WIDTH(AXI_BURST_WIDTH),
                      .AXI_LOCK_WIDTH(AXI_LOCK_WIDTH),
                      .AXI_CACHE_WIDTH(AXI_CACHE_WIDTH),
                      .AXI_PROT_WIDTH(AXI_PROT_WIDTH),
                      .AXI_STRB_WIDTH(AXI_STRB_WIDTH)
                      )
  ));
  `uvm_component_param_utils( FIFO2AXI_environment #(
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
                              ))



  uvm_analysis_port #(FIFO_in_transaction) FIFO_agent_ap;


  typedef FIFO_in_agent  FIFO_agent_t;
  FIFO_agent_t FIFO_agent;

  typedef AXI4_SLAVE_agent  AXI4_SLAVE_agent_t;
  AXI4_SLAVE_agent_t AXI4_SLAVE_agent;




  typedef FIFO2AXI_predictor #(
                .CONFIG_T(CONFIG_T)
                ) FIFO2AXI_pred_t;
  FIFO2AXI_pred_t FIFO2AXI_pred;

  typedef uvmf_in_order_scoreboard #(.T(AXI4_SLAVE_transaction))  FIFO2AXI_in_order_sb_t;
  FIFO2AXI_in_order_sb_t FIFO2AXI_in_order_sb;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(FIFO2AXI_env_configuration#(
                      .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH),
                      .FIFO_ADDR_WIDTH(FIFO_ADDR_WIDTH),
                      .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
                      .AXI_WID_WIDTH(AXI_WID_WIDTH),
                      .AXI_LEN_WIDTH(AXI_LEN_WIDTH),
                      .AXI_SIZE_WIDTH(AXI_SIZE_WIDTH),
                      .AXI_BURST_WIDTH(AXI_BURST_WIDTH),
                      .AXI_LOCK_WIDTH(AXI_LOCK_WIDTH),
                      .AXI_CACHE_WIDTH(AXI_CACHE_WIDTH),
                      .AXI_PROT_WIDTH(AXI_PROT_WIDTH),
                      .AXI_STRB_WIDTH(AXI_STRB_WIDTH)
                      ))) FIFO2AXI_vsqr_t;
  FIFO2AXI_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    FIFO_agent_ap = new("FIFO_agent_ap",this);
    FIFO_agent = FIFO_agent_t::type_id::create("FIFO_agent",this);
    FIFO_agent.set_config(configuration.FIFO_agent_config);
    AXI4_SLAVE_agent = AXI4_SLAVE_agent_t::type_id::create("AXI4_SLAVE_agent",this);
    AXI4_SLAVE_agent.set_config(configuration.AXI4_SLAVE_agent_config);
    FIFO2AXI_pred = FIFO2AXI_pred_t::type_id::create("FIFO2AXI_pred",this);
    FIFO2AXI_pred.configuration = configuration;
    FIFO2AXI_in_order_sb = FIFO2AXI_in_order_sb_t::type_id::create("FIFO2AXI_in_order_sb",this);

    vsqr = FIFO2AXI_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    FIFO_agent.monitored_ap.connect(FIFO2AXI_pred.FIFO_agent_ae);
    FIFO2AXI_pred.FIFO2AXI_sb_ap.connect(FIFO2AXI_in_order_sb.expected_analysis_export);
    AXI4_SLAVE_agent.monitored_ap.connect(FIFO2AXI_in_order_sb.actual_analysis_export);
    FIFO_agent.monitored_ap.connect(FIFO_agent_ap);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.FIFO2AXI_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

