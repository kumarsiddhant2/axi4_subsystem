//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: THis is the configuration for the FIFO2AXI environment.
//  it contains configuration classes for each agent.  It also contains
//  environment level configuration variables.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class FIFO2AXI_env_configuration #(
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
             )
extends uvmf_environment_configuration_base;

  `uvm_object_param_utils( FIFO2AXI_env_configuration #(
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


//Constraints for the configuration variables:


  covergroup FIFO2AXI_configuration_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    // pragma uvmf custom covergroup end
  endgroup


    typedef FIFO_in_configuration FIFO_agent_config_t;
    rand FIFO_agent_config_t FIFO_agent_config;

    typedef AXI4_SLAVE_configuration AXI4_SLAVE_agent_config_t;
    rand AXI4_SLAVE_agent_config_t AXI4_SLAVE_agent_config;




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
// This function constructs the configuration object for each agent in the environment.
//
  function new( string name = "" );
    super.new( name );


    FIFO_agent_config = FIFO_agent_config_t::type_id::create("FIFO_agent_config");
    AXI4_SLAVE_agent_config = AXI4_SLAVE_agent_config_t::type_id::create("AXI4_SLAVE_agent_config");


    FIFO2AXI_configuration_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that configuration variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")

  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
// FUNCTION : set_vsqr()
// This function is used to assign the vsqr handle.
  virtual function void set_vsqr( FIFO2AXI_vsqr_t vsqr);
     this.vsqr = vsqr;
  endfunction : set_vsqr

// ****************************************************************************
// FUNCTION: post_randomize()
// This function is automatically called after the randomize() function 
// is executed.
//
  function void post_randomize();
    super.post_randomize();
    // pragma uvmf custom post_randomize begin
    // pragma uvmf custom post_randomize end
  endfunction
  
// ****************************************************************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for
// logfile reporting. This function concatenates the convert2string result for
// each agent configuration in this configuration class.
//
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    return {
     
     "\n", FIFO_agent_config.convert2string,
     "\n", AXI4_SLAVE_agent_config.convert2string


       };
    // pragma uvmf custom convert2string end
  endfunction
// ****************************************************************************
// FUNCTION: initialize();
// This function configures each interface agents configuration class.  The 
// sim level determines the active/passive state of the agent.  The environment_path
// identifies the hierarchy down to and including the instantiation name of the
// environment for this configuration class.  Each instance of the environment 
// has its own configuration class.  The string interface names are used by 
// the agent configurations to identify the virtual interface handle to pull from
// the uvm_config_db.  
//
  function void initialize(uvmf_sim_level_t sim_level, 
                                      string environment_path,
                                      string interface_names[],
                                      uvm_reg_block register_model = null,
                                      uvmf_active_passive_t interface_activity[] = {}
                                     );

    super.initialize(sim_level, environment_path, interface_names, register_model, interface_activity);



  // Interface initialization for local agents
     FIFO_agent_config.initialize( interface_activity[0], {environment_path,".FIFO_agent"}, interface_names[0]);
     FIFO_agent_config.initiator_responder = INITIATOR;
     // FIFO_agent_config.has_coverage = 1;
     AXI4_SLAVE_agent_config.initialize( interface_activity[1], {environment_path,".AXI4_SLAVE_agent"}, interface_names[1]);
     AXI4_SLAVE_agent_config.initiator_responder = RESPONDER;
     // AXI4_SLAVE_agent_config.has_coverage = 1;





  // pragma uvmf custom initialize begin
  // pragma uvmf custom initialize end

  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

