# ============================================================
# Constraints de Timing Iniciais (Parte 2 - 50 MHz / 20 ns)
# ============================================================

# Criar o clock principal com período inicial de 20 ns
create_clock -name clk -period 20 [get_ports clk]

# Incerteza do clock (Jitter e Skew configurados para 0.5 ns)
set_clock_uncertainty 0.5 [get_clocks clk]

# Input delay de 3 ns para todas as entradas em relação ao clock
set_input_delay 3.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

# Output delay de 3 ns para todas as saídas em relação ao clock
set_output_delay 3.0 -clock clk [all_outputs]

# Fanout máximo recomendado para a tecnologia
set_max_fanout 8 [current_design]

# Carga das saídas (set_load)
set_load 0.05 [all_outputs]

# Célula de driver típica para as entradas (NBUFFX2_RVT da SAED32)
set_driving_cell -lib_cell NBUFFX2_RVT [remove_from_collection [all_inputs] [get_ports clk]]