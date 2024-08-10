#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define INT_BITS 32

unsigned int constant[4] = {0x61707865, 0x3320646e, 0x79622d32, 0x6b206574};  // "expand 32-byte k"
unsigned int key[8] = {0x03020100, 0x07060504, 0x0b0a0908, 0x0f0e0d0c, 0x13121110, 0x17161514, 0x1b1a1918, 0x1f1e1d1c}; // password
unsigned int state[4][4]; // 4x4 matrix
unsigned int *pointer_state = &state[0][0];
unsigned int nonce[3];
unsigned int counter = 0x01;
unsigned char block[64];

void generate_nonce();
void capture_char(unsigned int size, char* message);
void inner_block(unsigned int *state);
void quarter_round(unsigned int *state, unsigned int a, unsigned int b, unsigned int c, unsigned int d);
unsigned int left_rotate(unsigned int value, unsigned short int num_shifted);
unsigned int *chacha20_block(unsigned int *key, unsigned int counter, unsigned int *nonce);
char* xor_message(char *message, char *encrypted_message, unsigned int size);

int main()
{
    char encrypted_message[512];
    char decrypted_message[512];
    char *result_msg = NULL;

	char message[] = "ENGG57 - Labotario Integrado IV";
	int size = strlen(message);

	// Encrpyt message, xor with state
	printf("Original message: %s\n", message);
	result_msg = xor_message(&message[0], &encrypted_message[0], size); // encrypt
	printf("\nEncrypted_message Text: %s\n", result_msg);
	result_msg = xor_message(&encrypted_message[0], &decrypted_message[0], size); // decrypt
	printf("\nDecrypted Text: %s\n", result_msg);

	return 0;
}

/**
 * Realiza uma série de operações quarter_round em um vetor de estado.
 *
 * A função `inner_block` executa oito operações de mistura, cada uma usando
 * uma combinação diferente de quatro elementos do vetor `state`. Essas
 * operações são típicas em algoritmos de criptografia para fornecer difusão
 * e mistura dos bits no vetor, aumentando a segurança dos dados manipulados.
 *
 * @param state Um ponteiro para um vetor de 16 inteiros sem sinal, representando o estado.
 */
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

/**
 * Executa uma rodada de operações de mistura em quatro elementos do vetor de estado.
 *
 * A função `quarter_round` aplica uma sequência de operações aritméticas e lógicas
 * (adições e rotações) em quatro elementos específicos do vetor `state`. Esse tipo de
 * operação é comum em algoritmos de criptografia para embaralhar os bits e aumentar
 * a difusão de informações.
 *
 * @param state Um ponteiro para o vetor de estado que contém os dados.
 * @param a O índice do primeiro elemento do vetor `state` a ser processado.
 * @param b O índice do segundo elemento do vetor `state` a ser processado.
 * @param c O índice do terceiro elemento do vetor `state` a ser processado.
 * @param d O índice do quarto elemento do vetor `state` a ser processado.
 */
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

/**
 * Realiza uma rotação à esquerda (left rotate) de um valor inteiro.
 *
 * A função `left_rotate` desloca (shift) os bits de um valor inteiro para a esquerda
 * por um número especificado de posições, e os bits que "saem" pelo lado mais significativo
 * (esquerda) são reinseridos no lado menos significativo (direita). Isso cria uma rotação
 * circular dos bits, uma operação comum em criptografia para embaralhar os bits de maneira
 * que a difusão seja aumentada.
 *
 * @param value O valor inteiro cujo bits serão rotacionados.
 * @param num_shifted O número de posições para as quais os bits serão rotacionados.
 * @return O valor resultante após a rotação à esquerda.
 */
unsigned int left_rotate(unsigned int value, unsigned short int num_shifted){
    return (value << num_shifted) | (value >> (INT_BITS - num_shifted));
}

/**
 * Gera um bloco de saída para o algoritmo ChaCha20 usando uma chave, um contador e um nonce.
 *
 * A função `chacha20_block` configura um estado inicial com base em uma chave, um contador e um nonce,
 * aplica o algoritmo ChaCha20 para gerar um bloco de dados criptograficamente seguro e retorna o bloco gerado.
 *
 * @param key Ponteiro para um vetor de 8 inteiros sem sinal que representa a chave de 256 bits.
 * @param counter Valor inteiro que representa o contador de bloco.
 * @param nonce Ponteiro para um vetor de 2 inteiros sem sinal que representa o nonce de 64 bits.
 * @return Ponteiro para o vetor de estado contendo o bloco gerado.
 */
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

/**
 * Decripta uma mensagem criptografada usando XOR com um fluxo de chave gerado pelo ChaCha20.
 *
 * A função `xor_message` usa o algoritmo ChaCha20 para gerar um fluxo de chave e, em seguida, aplica
 * a operação XOR entre o fluxo de chave e a mensagem criptografada para recuperar a mensagem original.
 * O fluxo de chave é gerado em partes, correspondendo ao tamanho da mensagem.
 *
 * @param message Ponteiro para a mensagem original (decifrada).
 * @param encrypted_message Ponteiro para a mensagem criptografada que será decifrada.
 * @param size Tamanho da mensagem (em bytes).
 * @return Ponteiro para a mensagem decifrada.
 */
char* xor_message(char *message, char *encrypted_message, unsigned int size) {
    
    generate_nonce();

    char *process_message = encrypted_message;

    unsigned int len_text = size;
    unsigned int *key_stream;
    unsigned int parts = len_text / 64 + 1;

    for (int part = 0; part < parts; part++)
    {
        key_stream = chacha20_block(&key[0], counter + part, &nonce[0]);
        unsigned int last_i = part * 64 + 64;
        if (part == parts - 1) {
            last_i = len_text;
        }
        for (int j = part * 64; j < last_i; j++)
        {
            // get ith byte of the state, with 4 bytes per word. 4x4
        	unsigned int state_word = *(key_stream + (j / 16));
            block[j] = (state_word >> (8 * (j % 4))) & 0xff;
            *(process_message + j) = *(message + j) ^ block[j];
        }
    }

    return &process_message[0];
}

/**
 * Gera um nonce (Número usado uma vez) baseado em uma semente derivada de uma chave.
 *
 * A função `generate_nonce` cria um nonce de 3 inteiros (ou 96 bits) para ser utilizado em operações
 * criptográficas. O nonce é gerado a partir de uma semente derivada de uma chave fornecida e é utilizado
 * para garantir que cada operação criptográfica utilize valores únicos.
 */
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
