`timescale 1ns/1ns

module ChaCha20TB;

reg	CLOCK_50;
reg	[0:0] KEY;
reg	[9:0] SW;
wire	[1:0] LEDG;
wire	[7:0] LEDR;

reg [7:0] cipher_msg [63:0];
integer f, i, k;

ChaCha20 DUV (CLOCK_50,	KEY, SW, LEDG, LEDR);

always #10 CLOCK_50  = !CLOCK_50;

// always @(posedge LEDG[1], posedge LEDG[0]) begin
// 	if (LEDG == 2'b01) begin // ended writting character
// 		cipher_msg[i] = LEDR;
// 		i = i + 1;
// 	end	else if (LEDG == 2'b11) begin // ended writing message
// 		$display("Cipher message: %s", cipher_msg);
// 		$stop;
// 	end

// end

initial 
begin
		
	KEY[0] = 0;
	
	#102 KEY[0] = 1;

	i = 0;

	//while (1) begin	

	//end
end

initial
begin
	//$display("Iniciando teste...");
	$monitor("Iniciando teste...");
	f = $fopen("F:/Documentos/UFBA/Lab_Integrado_IV/ChaCha20_Quartus/ChaCha20/ChaCha20", "w+");
	for (k = 0; k < 27; k = k + 1) begin 
		@(posedge LEDG[0]); 
		if (LEDG == 2'b01) begin // ended writting character
			cipher_msg[i] = LEDR;
			$fwrite(f, "%c", LEDR);
			i = i + 1;
		end	else if (LEDG == 2'b11) begin // ended writing message
			//$display("Cipher message: %s", cipher_msg);
			$monitor("Cipher message: %s", cipher_msg);
		end
	end
	$fclose(f);
	$stop;
end

endmodule


