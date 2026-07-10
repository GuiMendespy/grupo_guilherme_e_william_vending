# ============================================================
# Script de Síntese - Vending Machine (Nomes em Inglês)
# ============================================================

# ------------------------------------------------------------
# Carregar configuração da biblioteca tecnológica
# ------------------------------------------------------------
source synth/.synopsys_dc.setup

# ------------------------------------------------------------
# Ler RTL (Nomes oficiais em inglês conforme o PDF)
# ------------------------------------------------------------
analyze -format sverilog rtl/vending_pkg.sv
analyze -format sverilog rtl/comparator.sv
analyze -format sverilog rtl/subtractor.sv
analyze -format sverilog rtl/memory.sv
analyze -format sverilog rtl/credit_reg.sv
analyze -format sverilog rtl/control_unit.sv
analyze -format sverilog rtl/vending_top.sv

# ------------------------------------------------------------
# Elaborar o Bloco de Topo Oficial
# ------------------------------------------------------------
elaborate vending_top

# Definir o design atual focado no topo
current_design vending_top

# Resolver links e referências do DesignWare
link

# ------------------------------------------------------------
# Constraints (Restrições Temporais vindas de vending.sdc)
# ------------------------------------------------------------
read_sdc synth/vending.sdc

# ------------------------------------------------------------
# Verificação pré-síntese do design
# ------------------------------------------------------------
puts "\n=================================================="
puts "EXECUTANDO CHECK DESIGN (PRE-SINTESE)"
puts "=================================================="

# Redireciona o check_design para arquivo conforme item 5 da especificação
redirect synth/reports/check_design.rpt {
  check_design
}

# Relatórios pré-síntese adicionais para análise de controle
redirect synth/reports/area_pre.rpt {
  report_area -hierarchy
}

redirect synth/reports/timing_pre.rpt {
  report_timing -max_paths 10
}

# ------------------------------------------------------------
# Síntese Lógica Ultra Otimizada
# ------------------------------------------------------------
puts "\n=================================================="
puts "INICIANDO SÍNTESE ULTRA (-no_autoungroup)"
puts "=================================================="
compile_ultra -no_autoungroup

# ------------------------------------------------------------
# Relatórios pós-síntese (Salvos diretamente em synth/)
# ------------------------------------------------------------
redirect synth/reports/area_pos.rpt {
  report_area -hierarchy
}

redirect synth/reports/timing_relatorio.rpt {
  report_timing -max_paths 10
}

redirect synth/reports/power.rpt {
  report_power
}

redirect synth/reports/setup_violations.rpt {
  report_constraint -all_violators
}

# ------------------------------------------------------------
# Exportar Netlist Estrutural e Arquivos de Saída (.v e .ddc)
# ------------------------------------------------------------
write -format verilog -hierarchy -output synth/vending_top_syn.v
write -format ddc -hierarchy -output synth/vending_top_syn.ddc
write_file -format ddc -hierarchy -output synth/vending_top.ddc

puts "\n=================================================="
puts "SÍNTESE CONCLUÍDA COM SUCESSO"
puts "=================================================="
puts "Arquivos gerados diretamente em synth/:"
puts "  synth/reports/check_design.rpt"
puts "  synth/reports/area_pos.rpt"
puts "  synth/reports/timing_relatorio.rpt"
puts "  synth/reports/power.rpt"
puts "  synth/reports/setup_violations.rpt"
puts "Netlist Estrutural gerada:"
puts "  synth/vending_top_syn.v"
puts "=================================================="

# Encerra o dc_shell devolvendo o controle para o terminal/Makefile
exit