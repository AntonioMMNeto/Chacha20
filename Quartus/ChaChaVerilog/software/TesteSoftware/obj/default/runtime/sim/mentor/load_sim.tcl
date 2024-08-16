# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force C:/Projetos/Quartus/ChaChaVerilog/software/TesteSoftware/mem_init/hdl_sim/SistemaEmbarcadoChaChaVerilog_MemoriaPrograma.dat ./ 
file copy -force C:/Projetos/Quartus/ChaChaVerilog/software/TesteSoftware/mem_init/SistemaEmbarcadoChaChaVerilog_MemoriaPrograma.hex ./ 
