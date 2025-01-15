# AXI4_SLAVE interface packages source
# pragma uvmf custom additional begin
# pragma uvmf custom additional end

AXI4_SLAVE_PKG         ?= \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg/AXI4_SLAVE_filelist_hvl.f 

AXI4_SLAVE_PKG_HDL         ?= \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg/AXI4_SLAVE_filelist_hdl.f 

AXI4_SLAVE_PKG_XRTL         ?= \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg/AXI4_SLAVE_filelist_xrtl.f 

COMP_AXI4_SLAVE_PKG_TGT_0 = q_comp_AXI4_SLAVE_pkg
COMP_AXI4_SLAVE_PKG_TGT_1 = v_comp_AXI4_SLAVE_pkg
COMP_AXI4_SLAVE_PKG_TGT = $(COMP_AXI4_SLAVE_PKG_TGT_$(USE_VELOCE))

comp_AXI4_SLAVE_pkg: $(COMP_AXI4_SLAVE_PKG_TGT) 

q_comp_AXI4_SLAVE_pkg:
	$(HDL_COMP_CMD) $(AXI4_SLAVE_PKG_HDL)
	$(HVL_COMP_CMD) $(AXI4_SLAVE_PKG)
	$(HDL_COMP_CMD) $(AXI4_SLAVE_PKG_XRTL) 

v_comp_AXI4_SLAVE_pkg:
	$(HVL_COMP_CMD) $(AXI4_SLAVE_PKG_HDL)
	$(HVL_COMP_CMD) $(AXI4_SLAVE_PKG)
	$(VELANALYZE_CMD) $(AXI4_SLAVE_PKG_HDL) 
	$(VELANALYZE_HVL_CMD) $(AXI4_SLAVE_PKG) 
	$(HDL_COMP_CMD) $(AXI4_SLAVE_PKG_XRTL)

ifeq ($(MTI_VCO_MODE),64)
  GCC_COMP_ARCH = -m64
else
  GCC_COMP_ARCH = -m32
endif

export AXI4_SLAVE_IF_DPI_SRC ?= $(UVMF_VIP_LIBRARY_HOME)/interface_packages/AXI4_SLAVE_pkg/dpi

C_FILE_COMPILE_LIST_AXI4_SLAVE_pkg	?= \

O_FILE_COMPILE_LIST_AXI4_SLAVE_pkg ?= $(notdir $(C_FILE_COMPILE_LIST_AXI4_SLAVE_pkg:.c=.o))

GCC_COMP_ARGS_AXI4_SLAVE_pkg	+= -I$(AXI4_SLAVE_IF_DPI_SRC) \
	-fPIC 

GCC_COMP_ARGS_AXI4_SLAVE_pkg	+= $(AXI4_SLAVE_IF_GCC_COMP_ARGUMENTS)

GCC_LINK_ARGS_AXI4_SLAVE_pkg	+= \
	 \
 	-o .so

comp_AXI4_SLAVE_pkg_c_files:
	@echo "--------------------------------"
	@echo "Compiling Interface C source"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_COMP_ARGS_AXI4_SLAVE_pkg) $(C_FILE_COMPILE_LIST_AXI4_SLAVE_pkg)
	@echo "--------------------------------"
	@echo "Linking Interface C objects into a shared object"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_LINK_ARGS_AXI4_SLAVE_pkg) $(O_FILE_COMPILE_LIST_AXI4_SLAVE_pkg)
	@echo "--------------------------------"

