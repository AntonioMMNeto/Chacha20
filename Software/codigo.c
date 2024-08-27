#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define INT_BITS 32

unsigned int constant[4] = {0x61707865, 0x3320646e, 0x79622d36, 0x6b206574};  // "expand 32-byte k"
unsigned int key[8] = {0,0,0,0,0,0,0,0}; // password
unsigned int state[4][4]; // 4x4 matrix
unsigned int *pointer_state = &state[0][0];
unsigned int nonce[3] = {0,0,0};
unsigned int counter = 0x00;

void generate_nonce();

char encrypted_message[64];
char decrypted_message[64];

void inner_block(unsigned int *state);
void quarter_round(unsigned int *state, unsigned int a, unsigned int b, unsigned int c, unsigned int d);
unsigned int left_rotate(unsigned int value, unsigned short int num_shifted);
unsigned int *chacha20_block(unsigned int *key, unsigned int counter, unsigned int *nonce);
void xor_message(char *message, char *encrypted_message, int counter);

typedef unsigned char u8;

int main()
{
	char message[64] = {0};

	// Encrpyt message, xor with state
	printf("Original Message:\n");
    for (int i = 0; i < 64; i+=4) {
        typedef unsigned char u8;  // in case char is signed by default on your platform
        unsigned num = ((u8)message[i] << 24) | 
            ((u8)message[i+1] << 16) | 
            ((u8)message[i+2] << 8) | 
            (u8)message[i+3];
        printf("%#08x ", num);
    }

	xor_message(message, encrypted_message, 0); // encrypt
    printf("\nEncrypted Message:\n");
    int k = 1;
    for (int i = 0; i < 64; i+=4) {
          // in case char is signed by default on your platform
        unsigned num = ((u8)encrypted_message[i] << 24) | 
            ((u8)encrypted_message[i+1] << 16) | 
            ((u8)encrypted_message[i+2] << 8) | 
            (u8)encrypted_message[i+3];
        printf("%#08x\n", num);
    }
    printf("\n");

	return 0;
}

void inner_block(unsigned int *state){
    quarter_round(state, 0, 4, 8, 12);
    quarter_round(state, 1, 5, 9, 13);
    quarter_round(state, 2, 6, 10, 14);
    quarter_round(state, 3, 7, 11, 15);
    quarter_round(state, 0, 5, 10, 15);
    quarter_round(state, 1, 6, 11, 12);
    quarter_round(state, 2, 7, 8, 13);
    quarter_round(state, 3, 4, 9, 14);
}

void quarter_round(unsigned int *state, unsigned int a, unsigned int b, unsigned int c, unsigned int d){

    unsigned int *p = state;

    *(p + a) += *(p + b);
    *(p + d) ^= *(p + a);
    *(p + d) = left_rotate(*(p + d), 16);
    *(p + c) += *(p + d);
    *(p + b) ^= *(p + c);
    *(p + b) = left_rotate(*(p + b), 12);
    *(p + a) += *(p + b);
    *(p + d) ^= *(p + a);
    *(p + d) = left_rotate(*(p + d), 8);
    *(p + c) += *(p + d);
    *(p + b) ^= *(p + c);
    *(p + b) = left_rotate(*(p + b), 7);
}

unsigned int left_rotate(unsigned int value, unsigned short int num_shifted){
    return (value << num_shifted) | (value >> (INT_BITS - num_shifted));
}

unsigned int* chacha20_block(unsigned int *key, unsigned int counter, unsigned int *nonce){
    unsigned short int cont = 0;

    // Attributing value on matrix
    for (unsigned short int i = 0; i < 16; i++)
    {
        if(i <= 3){
            *(pointer_state + (i)) = constant[cont];
            cont++;
            if(i == 3) cont = 0;
        }
        else if((i >= 4) && (i <= 11)){
            *(pointer_state + (i)) = key[cont];
            cont++;
            if(i == 11) cont = 0;
        }
        else if(i == 12){
            *(pointer_state + (i)) = counter;
        }
        else{
            *(pointer_state + (i)) = nonce[cont];
            cont++;
        }
    }

    unsigned int initial_state[4][4];
    unsigned int *pointer_initial = &initial_state[0][0];

    for (unsigned short int i = 0; i < 16; i++)
    {
        *(pointer_initial + i) = *(pointer_state + i);
    }

    for (unsigned short int i = 0; i < 10; i++)
    {
        inner_block(&state[0][0]);
    }

    for (unsigned short int i = 0; i < 16; i++)
    {
        *(pointer_state + i) = *(pointer_state + i) + *(pointer_initial + i);
    }

    return pointer_state;
}

// XOR message with state matrix
void xor_message(char *message, char *encrypted_message, int counter) {
    generate_nonce();
    unsigned int *key_stream;

    key_stream = chacha20_block(&key[0], counter, &nonce[0]);
    
    // xor the block (int) 16x16 with the message (char) 64
    for (int i = 0; i < 64; i+=4) {
        typedef unsigned char u8;  // in case char is signed by default on your platform
        unsigned num = ((u8)message[i] << 24) | 
            ((u8)message[i+1] << 16) | 
            ((u8)message[i+2] << 8) | 
            (u8)message[i+3];
        num ^= key_stream[i/4];
        encrypted_message[i+3] = (num >> 24) & 0xFF;
        encrypted_message[i+2] = (num >> 16) & 0xFF;
        encrypted_message[i+1] = (num >> 8) & 0xFF;
        encrypted_message[i] = num & 0xFF;
    }
    
}

void generate_nonce() {
    int seed;
    // Método 1: Gerar com uma seed fixa.
    seed = 5;

    // Método 2: Gerar usando a chave para a seed
    for (int i = 0; i < 8; i++) {
        seed |= (key[i] & 0xF) << (i * 4);
    }

    srand(seed);
    nonce[0] = rand();
    nonce[1] = rand();
    nonce[2] = rand();
}
