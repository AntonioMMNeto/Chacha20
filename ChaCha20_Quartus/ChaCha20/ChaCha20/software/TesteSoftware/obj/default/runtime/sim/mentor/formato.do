onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix ascii /SistemaEmbarcadoChaCha20_tb/sistemaembarcadochacha20_inst/pio_char_in_export
add wave -noupdate -radix ascii /SistemaEmbarcadoChaCha20_tb/sistemaembarcadochacha20_inst/pio_char_out_export
add wave -noupdate -radix binary /SistemaEmbarcadoChaCha20_tb/sistemaembarcadochacha20_inst/pio_ready_in_export
add wave -noupdate -radix binary /SistemaEmbarcadoChaCha20_tb/sistemaembarcadochacha20_inst/pio_ready_out_export
add wave -noupdate -radix binary /SistemaEmbarcadoChaCha20_tb/sistemaembarcadochacha20_inst/clk_clk
add wave -noupdate -radix binary /SistemaEmbarcadoChaCha20_tb/sistemaembarcadochacha20_inst/reset_reset_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 462
configure wave -valuecolwidth 40
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {814 ps}
