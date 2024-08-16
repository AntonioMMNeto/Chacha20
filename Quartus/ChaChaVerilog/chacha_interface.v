module chacha_interface(
              input           clk,
              input           reset_n,
              input write,
              input [31 : 0]  write_data,
              input read,
              output [31 : 0] read_data,
              input wire [7 : 0]   addr,
             );

reg [31 : 0] data_in_reg [0 : 15];

// Wires.
wire [255 : 0] core_key;
wire [63 : 0]  core_iv;
wire           core_ready;
wire [511 : 0] core_data_in;
wire [511 : 0] core_data_out;
wire           core_data_out_valid;

endmodule
