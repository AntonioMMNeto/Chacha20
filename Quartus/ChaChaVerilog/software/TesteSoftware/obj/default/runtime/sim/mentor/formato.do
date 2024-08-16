onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider ChaCha
add wave -noupdate -radix decimal /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/chacha20/addr
add wave -noupdate -radix unsigned /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/chacha20/write_data
add wave -noupdate -radix binary /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/chacha20/write
add wave -noupdate /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/chacha20/read
add wave -noupdate -radix unsigned /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/chacha20/read_data
add wave -noupdate -divider CustomIP
add wave -noupdate -radix binary /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/customip_0/read
add wave -noupdate -radix binary /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/customip_0/write
add wave -noupdate -radix decimal /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/customip_0/writedata
add wave -noupdate -radix decimal /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/customip_0/readdata
add wave -noupdate -radix decimal /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/customip_0/reg1
add wave -noupdate -radix decimal /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/customip_0/reg2
add wave -noupdate -radix decimal /SistemaEmbarcadoChaChaVerilog_tb/sistemaembarcadochachaverilog_inst/customip_0/reg3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1862670039 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 338
configure wave -valuecolwidth 57
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4490249257 ps} {4490250040 ps}
