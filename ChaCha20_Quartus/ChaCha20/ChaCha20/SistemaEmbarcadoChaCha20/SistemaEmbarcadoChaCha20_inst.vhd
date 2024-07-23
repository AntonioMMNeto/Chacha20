	component SistemaEmbarcadoChaCha20 is
		port (
			clk_clk              : in  std_logic                    := 'X';             -- clk
			pio_char_in_export   : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			pio_char_out_export  : out std_logic_vector(7 downto 0);                    -- export
			pio_ready_in_export  : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			pio_ready_out_export : out std_logic_vector(1 downto 0);                    -- export
			reset_reset_n        : in  std_logic                    := 'X'              -- reset_n
		);
	end component SistemaEmbarcadoChaCha20;

	u0 : component SistemaEmbarcadoChaCha20
		port map (
			clk_clk              => CONNECTED_TO_clk_clk,              --           clk.clk
			pio_char_in_export   => CONNECTED_TO_pio_char_in_export,   --   pio_char_in.export
			pio_char_out_export  => CONNECTED_TO_pio_char_out_export,  --  pio_char_out.export
			pio_ready_in_export  => CONNECTED_TO_pio_ready_in_export,  --  pio_ready_in.export
			pio_ready_out_export => CONNECTED_TO_pio_ready_out_export, -- pio_ready_out.export
			reset_reset_n        => CONNECTED_TO_reset_reset_n         --         reset.reset_n
		);

