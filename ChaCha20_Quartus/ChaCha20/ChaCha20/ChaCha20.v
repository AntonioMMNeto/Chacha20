// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Tue Apr 23 21:23:19 2024"

module ChaCha20(
	CLOCK_50,
	KEY,
	SW,
	LEDG,
	LEDR
);


input wire	CLOCK_50;
input wire	[0:0] KEY;
input wire	[9:0] SW;
output wire	[1:0] LEDG;
output wire	[7:0] LEDR;






SistemaEmbarcadoChaCha20	b2v_inst1(
	.clk_clk(CLOCK_50),
	.reset_reset_n(KEY),
	.pio_char_in_export(SW[7:0]),
	.pio_ready_in_export(SW[9:8]),
	.pio_char_out_export(LEDR),
	.pio_ready_out_export(LEDG));


endmodule
