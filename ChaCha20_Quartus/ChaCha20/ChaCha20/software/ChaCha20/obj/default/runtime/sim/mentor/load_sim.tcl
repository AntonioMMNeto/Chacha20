# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force F:/Documentos/UFBA/Lab_Integrado_IV/ChaCha20_Quartus/ChaCha20/ChaCha20/software/ChaCha20/mem_init/hdl_sim/SistemaEmbarcadoChaCha20_MemoriaDados.dat ./ 
file copy -force F:/Documentos/UFBA/Lab_Integrado_IV/ChaCha20_Quartus/ChaCha20/ChaCha20/software/ChaCha20/mem_init/hdl_sim/SistemaEmbarcadoChaCha20_MemoriaPrograma.dat ./ 
file copy -force F:/Documentos/UFBA/Lab_Integrado_IV/ChaCha20_Quartus/ChaCha20/ChaCha20/software/ChaCha20/mem_init/SistemaEmbarcadoChaCha20_MemoriaDados.hex ./ 
file copy -force F:/Documentos/UFBA/Lab_Integrado_IV/ChaCha20_Quartus/ChaCha20/ChaCha20/software/ChaCha20/mem_init/SistemaEmbarcadoChaCha20_MemoriaPrograma.hex ./ 
