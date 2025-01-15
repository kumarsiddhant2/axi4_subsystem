# Tcl do file for compile of AXI4_SLAVE interface

# pragma uvmf custom additional begin
# pragma uvmf custom additional end


vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg/AXI4_SLAVE_filelist_hdl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg/AXI4_SLAVE_filelist_hvl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg/AXI4_SLAVE_filelist_xrtl.f