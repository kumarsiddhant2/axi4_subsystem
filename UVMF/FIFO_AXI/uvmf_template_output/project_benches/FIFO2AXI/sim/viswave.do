 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { FIFO_agent }
wave add uvm_test_top.environment.FIFO_agent.FIFO_agent_monitor.txn_stream -radix string -tag F0
wave group FIFO_agent_bus
wave add -group FIFO_agent_bus hdl_top.FIFO_agent_bus.* -radix hexadecimal -tag F0
wave group FIFO_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { AXI4_SLAVE_agent }
wave add uvm_test_top.environment.AXI4_SLAVE_agent.AXI4_SLAVE_agent_monitor.txn_stream -radix string -tag F0
wave group AXI4_SLAVE_agent_bus
wave add -group AXI4_SLAVE_agent_bus hdl_top.AXI4_SLAVE_agent_bus.* -radix hexadecimal -tag F0
wave group AXI4_SLAVE_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

