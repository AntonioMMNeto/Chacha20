# TCL File Generated by Component Editor 18.1
# Wed Aug 14 21:11:25 BRT 2024
# DO NOT MODIFY


# 
# ChaCha20 "ChaCha20" v1.0
#  2024.08.14.21:11:25
# Chacha 20 rounds
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module ChaCha20
# 
set_module_property DESCRIPTION "Chacha 20 rounds"
set_module_property NAME ChaCha20
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Meus Componentes"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME ChaCha20
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL chacha
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file chacha.v VERILOG PATH chacha.v TOP_LEVEL_FILE
add_fileset_file chacha_core.v VERILOG PATH chacha_core.v
add_fileset_file chacha_qr.v VERILOG PATH chacha_qr.v

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL chacha
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file chacha.v VERILOG PATH chacha.v
add_fileset_file chacha_core.v VERILOG PATH chacha_core.v
add_fileset_file chacha_qr.v VERILOG PATH chacha_qr.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point Leitura_Escrita
# 
add_interface Leitura_Escrita avalon end
set_interface_property Leitura_Escrita addressUnits WORDS
set_interface_property Leitura_Escrita associatedClock clock
set_interface_property Leitura_Escrita associatedReset reset
set_interface_property Leitura_Escrita bitsPerSymbol 8
set_interface_property Leitura_Escrita burstOnBurstBoundariesOnly false
set_interface_property Leitura_Escrita burstcountUnits WORDS
set_interface_property Leitura_Escrita explicitAddressSpan 0
set_interface_property Leitura_Escrita holdTime 0
set_interface_property Leitura_Escrita linewrapBursts false
set_interface_property Leitura_Escrita maximumPendingReadTransactions 0
set_interface_property Leitura_Escrita maximumPendingWriteTransactions 0
set_interface_property Leitura_Escrita readLatency 0
set_interface_property Leitura_Escrita readWaitTime 1
set_interface_property Leitura_Escrita setupTime 0
set_interface_property Leitura_Escrita timingUnits Cycles
set_interface_property Leitura_Escrita writeWaitStates 2
set_interface_property Leitura_Escrita writeWaitTime 2
set_interface_property Leitura_Escrita ENABLED true
set_interface_property Leitura_Escrita EXPORT_OF ""
set_interface_property Leitura_Escrita PORT_NAME_MAP ""
set_interface_property Leitura_Escrita CMSIS_SVD_VARIABLES ""
set_interface_property Leitura_Escrita SVD_ADDRESS_GROUP ""

add_interface_port Leitura_Escrita addr address Input 8
add_interface_port Leitura_Escrita read_data readdata Output 32
add_interface_port Leitura_Escrita write_data writedata Input 32
add_interface_port Leitura_Escrita read read Input 1
add_interface_port Leitura_Escrita write write Input 1
set_interface_assignment Leitura_Escrita embeddedsw.configuration.isFlash 0
set_interface_assignment Leitura_Escrita embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Leitura_Escrita embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Leitura_Escrita embeddedsw.configuration.isPrintableDevice 0
