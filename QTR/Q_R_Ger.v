module Q_R_Ger (a_s,b_s,c_s,d_s,a,b,c,d) ;
parameter num_bits=32;
output reg [num_bits -1:0] a_s,b_s,c_s,d_s;
input [num_bits -1:0] a,b,c,d;
always 
begin
	 a_s = a+ b;
	 d_s = d ^ a;
	 d_s = (((d) << (16)) | ((d) >> ( 16)));
    c_s = c + d;
	 b_s = b ^ c;
	 b_s = (((b) << (12)) | ((b) >> ( 20)));
    a_s = a+ b;
	 d_s = d ^ a;
	 d_s = (((d) << (8)) | ((d) >> ( 24)));
    c_s = c + d;
	 b_s = b ^ c;
	 b_s = (((b) << (7)) | ((b) >> ( 25))) ;
end
endmodule