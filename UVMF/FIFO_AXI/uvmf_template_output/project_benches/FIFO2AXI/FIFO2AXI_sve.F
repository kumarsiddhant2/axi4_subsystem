
// UVM
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv

// Common UVMF files
-f ${UVMF_HOME}/common/common_sve.f

// BFM Files
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/FIFO_in_pkg/FIFO_in_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/AXI4_SLAVE_pkg/AXI4_SLAVE_pkg_sve.F

// Environment Files
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/FIFO2AXI_env_pkg/FIFO2AXI_env_pkg_sve.F

// Bench Files
+incdir+./tb/tests
./tb/tests/FIFO2AXI_tests_pkg.sv

+incdir+./tb/sequences
./tb/sequences/FIFO2AXI_sequences_pkg.sv

+incdir+./tb/parameters
./tb/parameters/FIFO2AXI_parameters_pkg.sv

./tb/testbench/hdl_top.sv
./tb/testbench/hvl_top.sv

