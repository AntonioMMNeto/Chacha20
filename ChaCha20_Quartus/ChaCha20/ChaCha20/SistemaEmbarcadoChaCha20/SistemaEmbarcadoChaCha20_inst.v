	SistemaEmbarcadoChaCha20 u0 (
		.clk_clk              (<connected-to-clk_clk>),              //           clk.clk
		.pio_char_in_export   (<connected-to-pio_char_in_export>),   //   pio_char_in.export
		.pio_char_out_export  (<connected-to-pio_char_out_export>),  //  pio_char_out.export
		.pio_ready_in_export  (<connected-to-pio_ready_in_export>),  //  pio_ready_in.export
		.pio_ready_out_export (<connected-to-pio_ready_out_export>), // pio_ready_out.export
		.reset_reset_n        (<connected-to-reset_reset_n>)         //         reset.reset_n
	);

