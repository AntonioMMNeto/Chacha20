# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force C:/Projetos/Quartus/ChaCha20/software/TesteSoftware/mem_init/hdl_sim/SistemaEmbarcadoChaCha20_MemoriaDados.dat ./ 
file copy -force C:/Projetos/Quartus/ChaCha20/software/TesteSoftware/mem_init/hdl_sim/SistemaEmbarcadoChaCha20_MemoriaPrograma.dat ./ 
file copy -force C:/Projetos/Quartus/ChaCha20/software/TesteSoftware/mem_init/SistemaEmbarcadoChaCha20_MemoriaDados.hex ./ 
file copy -force C:/Projetos/Quartus/ChaCha20/software/TesteSoftware/mem_init/SistemaEmbarcadoChaCha20_MemoriaPrograma.hex ./ 
