#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define PIO_CHAR_OUT    (int*) 0x85030
#define PIO_READY_OUT   (int*) 0x85020
#define PIO_CHAR_IN     (int*) 0x85010
#define PIO_READY_IN    (int*) 0x85000
#define MEMORIA_DADOS   (int*) 0x80000

int i, size;


int main()
{
  char msg[65] = "123456789abcdefghi123456789";

  // bit mais significativo: escrita terminada
  // bit menos significativo: caractere pronto
  *PIO_READY_OUT = 0b10;
  *PIO_READY_OUT = 0b00;
  for (i = 0; i < 27; i++) {
	  *PIO_READY_OUT = 0b00;
	  *PIO_CHAR_OUT = msg[i];
	  *PIO_READY_OUT = 0b01;
  }
  *PIO_READY_OUT = 0b11;

  return 0;
}
