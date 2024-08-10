
module quarterR (Resultado,Pronto,MatQ,Double_Word,Carregar,Descarrega,Iniciar,Clk,Reset);
parameter num_bits=32,
			 estado_inicial=4'b0000,	
			 Atribu_variavel_repete1=4'b0001,
			 repete1=4'b0010,
			 Q_r=4'b0011,
			 contin=4'b0100,
			 Fim_repete1=4'b0101,
			 soma=4'b0110,
			 pronto1=4'b0111,
			 estado_reset=4'b1000;
			 
output reg [num_bits -1:0] Resultado;
output reg 					Pronto;

input [num_bits -1:0] MatQ;
input [3:0]			 Double_Word;
input 				 Carregar;
input					 Descarrega;
input 				 Iniciar;
input			  		 Clk;
input					 Reset;		

reg [num_bits -1:0] Const[3:0],Const_ini [3:0],Const_m [3:0];
reg [num_bits -1:0] Chave [7:0],Chave_ini [7:0],Chave_m [7:0];
reg [num_bits -1:0] Contador,Contador_ini,Contador_m;
reg [num_bits -1:0] Nonce [2:0],Nonce_ini [2:0],Nonce_m [2:0];
reg [3:0] estado_atual,estado_futuro,estado_parado;
reg [4:0] cont,cont1;




always @(posedge Clk)
begin
if(Iniciar)
begin
estado_parado<=estado_inicial;
end 
else
begin
estado_parado<=estado_reset;
end
end
/*bloco de reset e atualizador de estado*/
always @(posedge Clk)
begin
if (Reset)
begin
	estado_atual<=estado_reset;
end
else
begin
	estado_atual<=estado_futuro;
end
end


/*De 0 até 111	  - carrega a chave
1000 				  - carrega o contador
de 1001 até 1011 - carrega os nonce´s   */
always @(posedge Carregar)
begin 
case(Double_Word)
4'b0000:begin 
				Chave[0]=MatQ;
		  end
4'b0001:begin 
				Chave[1]=MatQ;
		  end
4'b0010:begin 
				Chave[2]=MatQ;
		  end
4'b0011:begin 
				Chave[3]=MatQ;
		  end
4'b0100:begin 
				Chave[4]=MatQ;
		  end
4'b0101:begin 
				Chave[5]=MatQ;
		  end
4'b0110:begin 
				Chave[6]=MatQ;
		  end
4'b0111:begin 
				Chave[7]=MatQ;
		  end
4'b1000:begin 
				Contador=MatQ;
		  end
4'b1001:begin 
				Nonce[0]=MatQ;
		  end
4'b1010:begin 
				Nonce[1]=MatQ;
		  end
4'b1011:begin 
				Nonce[2]=MatQ;
		  end
endcase
		  
end

always @(estado_atual)
begin
estado_futuro<=estado_atual;
case(estado_atual)
estado_reset:begin
						Const[0]<=32'H61707865;
						Const[1]<=32'H3320646e;
						Const[2]<=32'H79622d32;
						Const[3]<=32'H6b206574;
						Const_ini[0]<=32'H61707865;
						Const_ini[1]<=32'H3320646e;
						Const_ini[2]<=32'H79622d32;
						Const_ini[3]<=32'H6b206574;
					/*	Chave[0]<=0;
						Chave[1]<=0;
						Chave[2]<=0;
						Chave[3]<=0;
						Chave[4]<=0;
						Chave[5]<=0;
						Chave[6]<=0;
						Chave[7]<=0;
						Contador<=0;
						Nonce[0]<=0;
						Nonce[1]<=0;
						Nonce[2]<=0;*/
						Pronto<=0;
						estado_futuro<=estado_parado;
				 end	


estado_inicial:begin
					   Chave_ini[0]<=Chave[0];
						Chave_ini[1]<=Chave[1];
					   Chave_ini[2]<=Chave[2];
						Chave_ini[3]<=Chave[3];
						Chave_ini[4]<=Chave[4];
						Chave_ini[5]<=Chave[5];
						Chave_ini[6]<=Chave[6];
						Chave_ini[7]<=Chave[7];
						Contador_ini<=Contador;
						Nonce_ini[0]<=Nonce[0];
						Nonce_ini[1]<=Nonce[1];
						Nonce_ini[2]<=Nonce[2];
						estado_futuro<=Atribu_variavel_repete1;
					end
Atribu_variavel_repete1:begin					
				cont<=0;
				estado_futuro<=repete1;
		  end	
repete1:
			begin
				if(cont>9)
				begin
					estado_futuro<=Fim_repete1;
				end
				else
				begin
					estado_futuro<=Q_r;
				end
			end
Q_r:
				begin
					 Q_R_Gera(Const_m[0],Chave_m[0],Chave_m[4],Contador_m,Const[0],Chave[0],Chave[4],Contdor);
					 Q_R_Gera(Const_m[1],Chave_m[1],Chave_m[5],Nonce_m[0],Const[1],Chave[1],Chave[5],Nonce[0]);
					 Q_R_Gera(Const_m[2],Chave_m[2],Chave_m[6],Nonce_m[1],Const[2],Chave[2],Chave[6],Nonce[1]);
					 Q_R_Gera(Const_m[3],Chave_m[3],Chave_m[7],Nonce_m[2],Const[3],Chave[3],Chave[7],Nonce[2]);
			
					 Q_R_Gera(Const_m[0],Chave_m[1],Chave_m[6],Nonce_m[2],Const[0],Chave[1],Chave[6],Nonce[2]);
					 Q_R_Gera(Const_m[1],Chave_m[2],Chave_m[7],Contador_m,Const[1],Chave[2],Chave[7],Contador);
					 Q_R_Gera(Const_m[2],Chave_m[3],Chave_m[4],Nonce_m[0],Const[2],Chave[3],Chave[4],Nonce[0]);
					 Q_R_Gera(Const_m[3],Chave_m[0],Chave_m[5],Nonce_m[1],Const[3],Chave[0],Chave[5],Nonce[1]);
					 estado_futuro<=contin;
				end
				
contin:	begin
					cont<=cont+1;
					estado_futuro<=repete1;
				end	
Fim_repete1:begin
					estado_futuro<=soma;
				end	
soma:
				begin
						Chave_ini[0]<=Chave_ini[0] + Chave_m[0];
						Chave_ini[1]<=Chave_ini[1] + Chave_m[1];
					   Chave_ini[2]<=Chave_ini[2] + Chave_m[2];
						Chave_ini[3]<=Chave_ini[3] + Chave_m[3];
						Chave_ini[4]<=Chave_ini[4] + Chave_m[4];
						Chave_ini[5]<=Chave_ini[5] + Chave_m[5];
						Chave_ini[6]<=Chave_ini[6] + Chave_m[6];
						Chave_ini[7]<=Chave_ini[7] + Chave_m[7];
						Contador_ini<=Contador_ini + Contador_m;
						Nonce_ini[0]<=Nonce_ini[0] + Nonce_m[0];
						Nonce_ini[1]<=Nonce_ini[1] + Nonce_m[1];
						Nonce_ini[2]<=Nonce_ini[2] + Nonce_m[2];
						Const_ini[0]<=Const_ini[0] + Const_m[0];
						Const_ini[1]<=Const_ini[1] + Const_m[1];
						Const_ini[2]<=Const_ini[2] + Const_m[2];
						Const_ini[3]<=Const_ini[3] + Const_m[3];
						estado_futuro <= pronto1;
						cont<=0;
				end
				
pronto1:	begin
					Pronto<=1;
					estado_futuro <= pronto1;
				end	
endcase	
				
end

always @(negedge Descarrega)
begin
	if(Pronto)
	begin	
		cont1<=cont1+1;
	end
end

always @(posedge Descarrega)
begin 
case(cont1)
4'b0000:begin 
			Resultado<=	Const_ini[0];
		  end
4'b0001:begin 
			Resultado<=	Const_ini[1];	
		  end
4'b0010:begin 
			Resultado<=	Const_ini[2];
		  end
4'b0011:begin 
			Resultado<=	Const_ini[3];
		  end
4'b0100:begin 
			Resultado<=Chave_ini[0];
		  end
4'b0101:begin 
			Resultado<=Chave_ini[1];
		  end
4'b0110:begin 
			Resultado<=Chave_ini[2];
		  end
4'b0111:begin 
			Resultado<=Chave_ini[3];
			end
4'b1000:begin 
			Resultado<=Chave_ini[4];
		  end
4'b1001:begin 
			Resultado<=Chave_ini[5];
		  end
4'b1010:begin 
			Resultado<=Chave_ini[6];
		  end
4'b1011:begin 
			Resultado<=Chave_ini[7];
		  end
4'b1100:begin 
			Resultado<=Contador_ini;
		  end
4'b1101:begin 
			Resultado<=Nonce_ini[0];
		  end
4'b1110:begin 
			Resultado<=Nonce_ini[1];
		  end
4'b1111:begin 
			Resultado<=Nonce_ini[2];
		  end
endcase
end




task Q_R_Gera ;
output [num_bits -1:0] a_s,b_s,c_s,d_s;
input [num_bits -1:0] a,b,c,d;
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
endtask
endmodule