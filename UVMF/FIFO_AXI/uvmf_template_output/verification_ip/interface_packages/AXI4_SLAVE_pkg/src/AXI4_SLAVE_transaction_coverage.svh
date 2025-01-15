//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records AXI4_SLAVE transaction information using
//       a covergroup named AXI4_SLAVE_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class AXI4_SLAVE_transaction_coverage  extends uvm_subscriber #(.T(AXI4_SLAVE_transaction ));

  `uvm_component_utils( AXI4_SLAVE_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup AXI4_SLAVE_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    awaddr: coverpoint coverage_trans.awaddr;
    awid: coverpoint coverage_trans.awid;
    awlen: coverpoint coverage_trans.awlen;
    awsize: coverpoint coverage_trans.awsize;
    awburst: coverpoint coverage_trans.awburst;
    awlock: coverpoint coverage_trans.awlock;
    awcache: coverpoint coverage_trans.awcache;
    awqos: coverpoint coverage_trans.awqos;
    awprot: coverpoint coverage_trans.awprot;
    endian: coverpoint coverage_trans.endian;
    wdata: coverpoint coverage_trans.wdata;
    wstrb: coverpoint coverage_trans.wstrb;
    wlast: coverpoint coverage_trans.wlast;
    wuser: coverpoint coverage_trans.wuser;
    bid: coverpoint coverage_trans.bid;
    bresp: coverpoint coverage_trans.bresp;
    buser: coverpoint coverage_trans.buser;
    arid: coverpoint coverage_trans.arid;
    araddr: coverpoint coverage_trans.araddr;
    arlen: coverpoint coverage_trans.arlen;
    arsize: coverpoint coverage_trans.arsize;
    arburst: coverpoint coverage_trans.arburst;
    arlock: coverpoint coverage_trans.arlock;
    arcache: coverpoint coverage_trans.arcache;
    arprot: coverpoint coverage_trans.arprot;
    arregion: coverpoint coverage_trans.arregion;
    arqos: coverpoint coverage_trans.arqos;
    rid: coverpoint coverage_trans.rid;
    rdata: coverpoint coverage_trans.rdata;
    rlast: coverpoint coverage_trans.rlast;
    rvalid: coverpoint coverage_trans.rvalid;
    rresp: coverpoint coverage_trans.rresp;
    ruser: coverpoint coverage_trans.ruser;
    no_of_wait_states: coverpoint coverage_trans.no_of_wait_states;
    tx_type: coverpoint coverage_trans.tx_type;
    transfer_type: coverpoint coverage_trans.transfer_type;
    wait_count_write_address_channel: coverpoint coverage_trans.wait_count_write_address_channel;
    wait_count_write_data_channel: coverpoint coverage_trans.wait_count_write_data_channel;
    wait_count_write_response_channel: coverpoint coverage_trans.wait_count_write_response_channel;
    wait_count_read_address_channel: coverpoint coverage_trans.wait_count_read_address_channel;
    wait_count_read_data_channel: coverpoint coverage_trans.wait_count_read_data_channel;
    outstanding_write_tx: coverpoint coverage_trans.outstanding_write_tx;
    outstanding_read_tx: coverpoint coverage_trans.outstanding_read_tx;
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    AXI4_SLAVE_transaction_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that transaction variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    AXI4_SLAVE_transaction_cg.set_inst_name($sformatf("AXI4_SLAVE_transaction_cg_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    AXI4_SLAVE_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

