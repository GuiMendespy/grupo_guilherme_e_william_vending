########################################################################
# Formality Verification Script
########################################################################

########################################################################
# General Settings
########################################################################
set hdlin_dwroot /Tools/synopsys/syn/X-2025.06-SP2

########################################################################
# Search Path
########################################################################
set search_path " \
	/home/william.costa/Maquina_De_Vendas_CIExpert/. \
	/Tools/synopsys/syn/X-2025.06-SP2/libraries/syn \
	/Tools/synopsys/syn/X-2025.06-SP2/dw/syn_ver \
	/Tools/synopsys/syn/X-2025.06-SP2/dw/sim_ver \
	/home/william.costa/Maquina_De_Vendas_CIExpert/. \
	/home/william.costa/Maquina_De_Vendas_CIExpert/rtl \
	/home/william.costa/Maquina_De_Vendas_CIExpert/synth \
	/Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm/ "

#########################################################################
# Synopsys Auto Setup Mode
#########################################################################
set synopsys_auto_setup true

#########################################################################
# SVF Guide File
#########################################################################
set_svf synth/reports/default.svf

########################################################################
# Read Technology Libraries
########################################################################
define_design_lib -r -path ./work WORK 
read_db -technology_library saed32rvt_tt1p05v25c.db

########################################################################
# Read Reference Design (RTL) - Container 'r'
########################################################################
set hdlin_sverilog_std 2017
set hdlin_vhdl_std 2008
set hdlin_vrlg_std 2005

read_sverilog -r -libname WORK rtl/vending_pkg.sv
read_sverilog -r -libname WORK rtl/comparator.sv
read_sverilog -r -libname WORK rtl/subtractor.sv
read_sverilog -r -libname WORK rtl/memory.sv
read_sverilog -r -libname WORK rtl/credit_reg.sv
read_sverilog -r -libname WORK rtl/control_unit.sv
read_sverilog -r -libname WORK rtl/vending_top.sv

set_top r:/WORK/vending_top

########################################################################
# Read Implementation Design (Netlist) - Container 'i'
########################################################################
read_verilog -i -libname WORK synth/vending_top_syn.v
set_top i:/WORK/vending_top

########################################################################
# Matching Stage (Pareamento explícito entre RTL e Netlist)
########################################################################
match

########################################################################
# Verification Stage (Verificação de Equivalência Formal)
########################################################################
set verify_success [verify]

########################################################################
# Report Generation (Executado SEMPRE)
########################################################################
set REPORTS_DIR "fm/reports"
file mkdir ${REPORTS_DIR}

# Relatórios dos Pontos de Comparação
report_status           > ${REPORTS_DIR}/formality_status.rpt
report_status           > ${REPORTS_DIR}/formality_svf_resumo.rpt
report_passing_points   > ${REPORTS_DIR}/formality_passing.rpt
report_failing_points   > ${REPORTS_DIR}/formality_failing.rpt
report_unmatched_points > ${REPORTS_DIR}/formality_unmatched.rpt

# Relatórios das Diretrizes do SVF (Design Compiler)

report_svf_operation -status accepted > ${REPORTS_DIR}/formality_svf_accepted.rpt
report_svf_operation -status rejected > ${REPORTS_DIR}/formality_svf_rejected.rpt
report_svf_operation -status accepted -summary >> ${REPORTS_DIR}/formality_svf_resumo.rpt
report_svf_operation -status rejected -summary >> ${REPORTS_DIR}/formality_svf_resumo.rpt
# Se a verificação falhar, salva a sessão automaticamente para debug na GUI
if { !$verify_success } {
    save_session -replace ${REPORTS_DIR}/vending_top_failing
}
exit