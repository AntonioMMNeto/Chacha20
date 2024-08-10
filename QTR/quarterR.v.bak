
module quarterRound (Resultado,Pronto,MatQ,Double_Word,Carregar,Descarrega,Iniciar,Clk,Reset);
parameter num_bits=32,
			 estado_inicial=4'b0000,	
			 Atribu_variavel_repete1=4'b0001,
			 repete1=4'b0010,
			 Q_r=4'b0011,
			 continue=4'b0100,
			 Fim_repete1=4'b0101,
			 soma=4'b0110,
			 pronto1=4'b0111;
			 
output reg [num_bits -1:0] Resultado;
output reg 					Pronto;
input [num_bits -1:0] MatQ;
//input [num_bits -1:0] Chave;
//input [num_bits -1:0] Contador;
//input [num_bits -1:0] Nonce;
input [3:0]			 Double_Word;
input 				 Carregar;
input					 Descarrega;
input 				 Iniciar;
input			  		 Clk;
input					 Reset;		

reg [num_bits -1:0] Const[3:0],Const_ini [3:0];
reg [num_bits -1:0] Chave [7:0],Chave_ini [7:0];
reg [num_bits -1:0] Contador,Contador_ini;
reg [num_bits -1:0] Nonce [2:0],Nonce_ini [2:0];
reg [3:0] estado_atual,estado_futuro;
reg [4:0] cont;

/*bloco de reset e atualizador de estado*/
always @(posedge Clk)
begin
if (Reset)
begin
	Const[0]<=8'H61707865;
	Const[1]<=8'H3320646e;
	Const[2]<=8'H79622d32;
	Const[3]<=8'H6b206574;
	Const_ini[0]<=8'H61707865;
	Const_ini[1]<=8'H3320646e;
	Const_ini[2]<=8'H79622d32;
	Const_ini[3]<=8'H6b206574;
	Chave[0]<=0;
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
	Nonce[2]<=0;
	estado_atual<=estado_inicial;
	Pronto<=0;
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

always @(posedge Clk)
begin
estado_futuro<=estado_atual;
case(estado_atual)
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
						estado_futuro<=repete1;
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
					 Q_R_Gera(Const[0],Chave[0],Chave[4],Contador,Const[0],Chave[0],Chave[4],Contador);
					 Q_R_Gera(Const[1],Chave[1],Chave[5],Nonce[0],Const[1],Chave[1],Chave[5],Nonce[0]);
					 Q_R_Gera(Const[2],Chave[2],Chave[6],Nonce[1],Const[2],Chave[2],Chave[6],Nonce[1]);
					 Q_R_Gera(Const[3],Chave[3],Chave[7],Nonce[2],Const[3],Chave[3],Chave[7],Nonce[2]);
			
					 Q_R_Gera(Const[0],Chave[1],Chave[6],Nonce[2].Const[0],Chave[1],Chave[6],Nonce[2]);
					 Q_R_Gera(Const[1],Chave[2],Chave[7],Contador,Const[1],Chave[2],Chave[7],Contador);
					 Q_R_Gera(Const[2],Chave[3],Chave[4],Nonce[0],Const[2],Chave[3],Chave[4],Nonce[0]);
					 Q_R_Gera(Const[3],Chave[0],Chave[5],Nonce[1],Const[3],Chave[0],Chave[5],Nonce[1]);
					 estado_futuro<=continue;
				end
				
continue:	begin
					cont<=cont+1;
					estado_futuro<=repete1;
				end	
Fim_repete1:begin
					estado_futuro<=soma;
				end	
soma:
				begin
						Chave_ini[0]<=Chave_ini[0] + Chave[0];
						Chave_ini[1]<=Chave_ini[1] + Chave[1];
					   Chave_ini[2]<=Chave_ini[2] + Chave[2];
						Chave_ini[3]<=Chave_ini[3] + Chave[3];
						Chave_ini[4]<=Chave_ini[4] + Chave[4];
						Chave_ini[5]<=Chave_ini[5] + Chave[5];
						Chave_ini[6]<=Chave_ini[6] + Chave[6];
						Chave_ini[7]<=Chave_ini[7] + Chave[7];
						Contador_ini<=Contador_ini + Contador;
						Nonce_ini[0]<=Nonce_ini[0] + Nonce[0];
						Nonce_ini[1]<=Nonce_ini[1] + Nonce[1];
						Nonce_ini[2]<=Nonce_ini[2] + Nonce[2];
						Const_ini[0]<=Const_ini[0] + Const[0];
						Const_ini[1]<=Const_ini[1] + Const[1];
						Const_ini[2]<=Const_ini[2] + Const[2];
						Const_ini[3]<=Const_ini[3] + Const[3];
						estado_futuro<= pronto1;
						cont<=0;
				end
				
pronto1:	begin
					Pronto<=1;
					estado_futuro<=pronto1;
				end	
endcase	
				
end

always @(posedge Clk)
begin
	if(p && Descarrega)
	begin	
		cont<=cont+1;
	end
end

always @(posedge Clk)
begin 
if(p)
	begin
case(cont)
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
end




task Q_R_Gera ;
input [num_bits -1:0] a,b,c,d;
output [num_bits -1:0] a_s,b_s,c_s,d_s;
begin
	 a_s = a+ b;
	 d_s = d ^ a;
	 d_s = ROTL(d,16);
    c_s = c + d;
	 b_s = b ^ c;
	 b_s = ROTL(b,12);
    a_s = a+ b;
	 d_s = d ^ a;
	 d_s = ROTL(d, 8);
    c_s = c + d;
	 b_s = b ^ c;
	 b_s = ROTL(b, 7) ;
end
endtask
endmodule