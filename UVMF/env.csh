#--------------------------------------------------------------------------------------------
#  env file to source all paths
#--------------------------------------------------------------------------------------------

alias python_c '/hwetools/work_area/frontend/siddhant/UVMF/UVMF_2023.3/scripts/uvmf_bcr.py'
alias python_g '/hwetools/work_area/frontend/siddhant/UVMF/UVMF_2023.3/scripts/yaml2uvmf.py'
source /home/share/questa.csh

setenv QUESTA_HOME "/home/share/questa"

setenv UVMF_HOME "/hwetools/work_area/frontend/siddhant/UVMF/UVMF_2023.3"


setenv UVMF_VIP_LIBRARY_HOME "`pwd`/../../../verification_ip"
#setenv UVMF_VIP_LIBRARY_HOME "/hwetools/work_area/frontend/siddhant/UVMF/FIFO_AXI/uvmf_template_output/verification_ip"
setenv UVMF_PROJECT_DIR "`pwd`/.."
#setenv UVMF_PROJECT_DIR "/hwetools/work_area/frontend/siddhant/UVMF/FIFO_AXI/"
echo   " PATH_OF_UVMF   :  $UVMF_HOME"
echo   " PATH_OF_VIP    :  $UVMF_VIP_LIBRARY_HOME"
echo   " PATH_OF_DIR    :  $UVMF_PROJECT_DIR"
#python $UVMF_DIR/scripts/yaml2uvmf.py -d ./yaml_config_files/ALU_in_interface.yaml
