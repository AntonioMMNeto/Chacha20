module CustomIP (
	input [1:0] address,
	input chipselect,
	input clk,
	input read,
	input reset_n,
	input write,
	input [31:0] writedata,
	output reg [31:0] readdata
);

	reg [31:0] reg1, reg2, reg3;		// To hold the Data
	
	always @ ( posedge clk or negedge reset_n )
	begin
		if ( reset_n == 1'b0 )
		begin
			reg1 <= 32'b0;
			reg2 <= 32'b0;
			reg3 <= 32'b0;
			readdata <= 32'b0;
		end
		else if ( chipselect && write )
		begin
			case ( address )
				0 			: reg1 <= writedata;
				1 			: reg2 <= writedata;
				2 			: reg3 <= writedata;
			endcase
		end
		else if ( chipselect && read )
		begin
			case ( address )
				0 : readdata <= reg1;
				1 : readdata <= reg2;
				2 : readdata <= reg3;
			endcase
		end
		else
		begin
			reg1 <= reg1;
			reg2 <= reg2;
			reg3 <= reg3;
			readdata <= 32'b0;
		end
	end
endmodule 
