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