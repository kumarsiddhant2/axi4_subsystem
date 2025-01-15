# Tcl do file for compile of FIFO_in interface

# pragma uvmf custom additional begin
# pragma uvmf custom additional end


vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/FIFO_in_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/FIFO_in_pkg/FIFO_in_filelist_hdl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/FIFO_in_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/FIFO_in_pkg/FIFO_in_filelist_hvl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/FIFO_in_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/FIFO_in_pkg/FIFO_in_filelist_xrtl.f