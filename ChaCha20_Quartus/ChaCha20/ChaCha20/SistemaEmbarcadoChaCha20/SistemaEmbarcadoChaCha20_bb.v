
module SistemaEmbarcadoChaCha20 (
	clk_clk,
	pio_char_in_export,
	pio_char_out_export,
	pio_ready_in_export,
	pio_ready_out_export,
	reset_reset_n);	

	input		clk_clk;
	input	[7:0]	pio_char_in_export;
	output	[7:0]	pio_char_out_export;
	input	[1:0]	pio_ready_in_export;
	output	[1:0]	pio_ready_out_export;
	input		reset_reset_n;
endmodule
