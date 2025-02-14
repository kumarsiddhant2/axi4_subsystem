//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import FIFO2AXI_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #9ns;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1; 
    #200ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  FIFO_in_if  FIFO_agent_bus(
     // pragma uvmf custom FIFO_agent_bus_connections begin
     .clk(clk), .rst(rst)
     // pragma uvmf custom FIFO_agent_bus_connections end
     );
  AXI4_SLAVE_if  AXI4_SLAVE_agent_bus(
     // pragma uvmf custom AXI4_SLAVE_agent_bus_connections begin
     .ACLK(clk), .ARESETn(rst)
     // pragma uvmf custom AXI4_SLAVE_agent_bus_connections end
     );
  FIFO_in_monitor_bfm  FIFO_agent_mon_bfm(FIFO_agent_bus);
  AXI4_SLAVE_monitor_bfm  AXI4_SLAVE_agent_mon_bfm(AXI4_SLAVE_agent_bus);
  FIFO_in_driver_bfm  FIFO_agent_drv_bfm(FIFO_agent_bus);
  AXI4_SLAVE_driver_bfm  AXI4_SLAVE_agent_drv_bfm(AXI4_SLAVE_agent_bus);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
  verilog_dut         dut_verilog(   .clk(clk), .rst(rst), .in_signal(vhdl_to_verilog_signal), .out_signal(verilog_to_vhdl_signal));
  vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));
  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual FIFO_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , FIFO_agent_BFM , FIFO_agent_mon_bfm ); 
    uvm_config_db #( virtual AXI4_SLAVE_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , AXI4_SLAVE_agent_BFM , AXI4_SLAVE_agent_mon_bfm ); 
    uvm_config_db #( virtual FIFO_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , FIFO_agent_BFM , FIFO_agent_drv_bfm  );
    uvm_config_db #( virtual AXI4_SLAVE_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , AXI4_SLAVE_agent_BFM , AXI4_SLAVE_agent_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

