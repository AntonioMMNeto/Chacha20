`timescale 1ns/1ns

module ChaChaVerilogTB;


reg	CLOCK_50;
reg	[0:0] KEY;

ChaChaVerilog duv(CLOCK_50,KEY);

always #10 CLOCK_50 = ~CLOCK_50;


initial
begin
CLOCK_50 = 0;
KEY[0] = 0;

#102 KEY[0] = 1;
end

endmodule
