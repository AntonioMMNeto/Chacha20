
#include <stdio.h>
#include <system.h>
#include <io.h>

#define ADDR_ROUNDS 0xb
#define ADDR_DATA_IN 0x40
#define ADDR_KEY 0x17

#define ADDR_DATA_OUT 0x80
#define ADDR_STATUS 0x9
#define ADDR_IV 0x20
#define ADDR_KEYLEN 0xa


#define ADDR_CTRL 0x08

unsigned int  key[8] = {0,0,0,0,0,0,0,0};
unsigned int  nonce[3] = {0,0,0};
int i;

int main()
{
  printf("Hello from Nios II!\n");

  IOWR(CHACHA20_BASE, ADDR_ROUNDS, 20);

  printf("Rounds: %d\n", IORD(CHACHA20_BASE, ADDR_ROUNDS));

  printf("Preenchendo os dados da chave...\n");
  // Preenche os dados da chave
  for (i = 0; i < 8; i ++){
	IOWR(CHACHA20_BASE, ADDR_KEY + i, key[i]);
  }

  printf("Preenchendo nonce...\n");
  // Preenche o nonce
  for (i = 0; i < 3; i ++){
	  IOWR(CHACHA20_BASE, ADDR_IV+i, nonce[i]);
  }

  printf("Preenchendo dados de entrada...\n");
  // Prenche os dados de entrada (string a ser criptografada
  for (i = 0; i < 16; i++) {
	  IOWR(CHACHA20_BASE, ADDR_DATA_IN + i, 0);
  }

  printf("Iniciando o processo no RTL\n");
  // Inicia o processo, espera um pouco para o init e retira a flag
  IOWR(CHACHA20_BASE, ADDR_CTRL, 0b11);
  for (i  = 0; i < 40; i++);
  IOWR(CHACHA20_BASE, ADDR_CTRL+i, 0b00);

  printf("Esperando o data out ficar valido...\n");
  // Espera ficar pronto
  int n = 0;
  while (!(IORD(CHACHA20_BASE, ADDR_STATUS) & 0b11)) {
	  if (n++ % 10000) {
		  printf("Status atual: %d\n", IORD(CHACHA20_BASE, ADDR_STATUS));
	  }

  }

  int check[16] = {
		  0x02234363, 0xbf0ca967, 0x4e15f409, 0x8aab3710,
		  0x5e0ad9d5, 0x36ba5d9b, 0xd792c4d9, 0x7b9f31eb,
		  0xa32fd07e, 0xd8714247, 0x29967bd0, 0xd7b56535,
		  0x042d1a0d, 0x36479bfa, 0xaf60c763, 0x920fe6b3,
  };

  int incorrect = 0;
  // Checa os resultados
   for (i = 0; i < 16; i++) {
	  int result = IORD(CHACHA20_BASE, ADDR_DATA_OUT + i);
 	  printf("data_out: %#08x, check: %#08x\n", result, check[i]);
 	  	 if (result!= check[i])
 	  		 incorrect++;
   }

   if (incorrect == 0) {
	   printf("Testes passados!\n");
   } else {
	   printf("Houve %d erros.\n");
   }

  return 0;
}
