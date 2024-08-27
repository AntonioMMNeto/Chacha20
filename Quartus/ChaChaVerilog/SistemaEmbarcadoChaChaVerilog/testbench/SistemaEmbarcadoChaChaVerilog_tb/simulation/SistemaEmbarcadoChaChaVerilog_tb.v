// SistemaEmbarcadoChaChaVerilog_tb.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module SistemaEmbarcadoChaChaVerilog_tb (
	);

	wire    sistemaembarcadochachaverilog_inst_clk_bfm_clk_clk;       // SistemaEmbarcadoChaChaVerilog_inst_clk_bfm:clk -> [SistemaEmbarcadoChaChaVerilog_inst:clk_clk, SistemaEmbarcadoChaChaVerilog_inst_reset_bfm:clk]
	wire    sistemaembarcadochachaverilog_inst_reset_bfm_reset_reset; // SistemaEmbarcadoChaChaVerilog_inst_reset_bfm:reset -> SistemaEmbarcadoChaChaVerilog_inst:reset_reset_n

	SistemaEmbarcadoChaChaVerilog sistemaembarcadochachaverilog_inst (
		.clk_clk       (sistemaembarcadochachaverilog_inst_clk_bfm_clk_clk),       //   clk.clk
		.reset_reset_n (sistemaembarcadochachaverilog_inst_reset_bfm_reset_reset)  // reset.reset_n
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) sistemaembarcadochachaverilog_inst_clk_bfm (
		.clk (sistemaembarcadochachaverilog_inst_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) sistemaembarcadochachaverilog_inst_reset_bfm (
		.reset (sistemaembarcadochachaverilog_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (sistemaembarcadochachaverilog_inst_clk_bfm_clk_clk)        //   clk.clk
	);

endmodule