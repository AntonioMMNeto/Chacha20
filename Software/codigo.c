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
 * @param nonce Ponteiro para um vetor de 3 inteiros sem sinal que representa o nonce de 96 bits.
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
 * Função para criptografar uma mensagem usando a operação XOR com um fluxo de chave
 * gerado pelo algoritmo ChaCha20. Esta função recebe uma mensagem de entrada e realiza
 * uma operação XOR em blocos de 4 bytes com o fluxo de chave, produzindo uma mensagem
 * criptografada como saída. O nonce é gerado internamente para cada operação de criptografia.
 *
 * @param message           A mensagem de entrada a ser criptografada.
 * @param encrypted_message O buffer de saída onde a mensagem criptografada será armazenada.
 * @param counter           Um valor de contador usado para gerar o fluxo de chave com o ChaCha20.
 */
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

/**
 * Função para gerar um nonce (número único que só pode ser usado uma vez) 
 * que será usado no processo de criptografia. 
 *
 * A função utiliza dois métodos diferentes para definir a semente (`seed`):
 * 
 * - Método 1: Inicializa a semente com um valor fixo (neste caso, 5).
 * - Método 2: Combina partes da chave (`key`) para formar a semente, 
 *   onde cada nibble (4 bits) de cada byte da chave é incorporado na semente.
 * 
 * Após a semente ser configurada, a função inicializa o gerador de números 
 * aleatórios (`srand(seed)`) e gera três valores aleatórios, que são armazenados 
 * no vetor `nonce`.
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
