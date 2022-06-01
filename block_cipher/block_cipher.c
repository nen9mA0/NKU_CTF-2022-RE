#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// flag{It_has_been_3_o_clock_TEA_first!}

uint32_t IV[] = {0xdeadbeef, 0xcafebabe};
uint32_t key[] = {0x5a5aa5a5, 0xa5a55a5a};

unsigned char cmp[] = { 0xc1, 0x38, 0xe9, 0x35, 0x81, 0x94, 0xa9, 0x0d,
                        0xc8, 0x6c, 0xd6, 0x81, 0x6f, 0x76, 0x91, 0xf1,
                        0x84, 0x29, 0xf3, 0x09, 0xbe, 0xe5, 0xdd, 0xf6,
                        0xf9, 0x9a, 0xb1, 0x04, 0x70, 0x0c, 0xd2, 0xa4,
                        0x72, 0x47, 0xcc, 0x15, 0xc8, 0x92, 0x03, 0xe9
                        };

char buf[100];


void encrypt_block(uint32_t *v, uint32_t *k)
{
    uint32_t v0 = v[0], v1 = v[1];
    uint32_t sum = 0;

    uint32_t delta = 0x9e3779b9;
    uint32_t k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];

    for(int i=0; i<32; i++)
    {
        sum += delta;
        v0 += ( (v1<<4) + k0 ) ^ ( v1+sum ) ^ ( (v1>>5) + k1 );
        v1 += ( (v0<<4) + k2 ) ^ ( v0+sum ) ^ ( (v0>>5) + k3 );
    }
    v[0] = v0;
    v[1] = v1;
}

// void decrypt_block(uint32_t *v, uint32_t *k)
// {
//     uint32_t v0 = v[0], v1 = v[1];
//     uint32_t sum = 0xc6ef3720;
//     uint32_t delta = 0x9e3779b9;
//     uint32_t k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];

//     for(int i=0; i<32; i++)
//     {
//         v1 -= ( (v0<<4) + k2 ) ^ (v0 + sum) ^ ( (v0>>5) + k3 );
//         v0 -= ( (v1<<4) + k0 ) ^ (v1 + sum) ^ ( (v1>>5) + k1 );
//         sum -= delta;
//     }
//     v[0] = v0; v[1] = v1;
// }

void encrypt(unsigned char *pad_buf, size_t len)
{
    uint32_t v[2];
    uint32_t IV_tmp[2];

    IV_tmp[0] = IV[0];
    IV_tmp[1] = IV[1];

    for(int i=0; i<len; i+=8)
    {
        v[0] = *((uint32_t*)&pad_buf[i]);
        v[1] = *((uint32_t*)&pad_buf[i+4]);

        v[0] ^= IV_tmp[0];
        v[1] ^= IV_tmp[1];

        encrypt_block(v, key);

        IV_tmp[0] = v[0];
        IV_tmp[1] = v[1];

        *((uint32_t*)&pad_buf[i]) = v[0];
        *((uint32_t*)&pad_buf[i+4]) = v[1];
    }
}

// void decrypt(unsigned char *buf, size_t len)
// {
//     uint32_t v[2];
//     uint32_t IV_tmp[2];

//     v[0] = *((uint32_t*)&buf[0]);
//     v[1] = *((uint32_t*)&buf[4]);

//     IV_tmp[0] = v[0];
//     IV_tmp[1] = v[1];

//     decrypt_block(v, key);

//     v[0] ^= IV[0];
//     v[1] ^= IV[1];

//     *((uint32_t*)&buf[0]) = v[0];
//     *((uint32_t*)&buf[4]) = v[1];

//     for(int i=8; i<len; i+=8)
//     {
//         v[0] = *((uint32_t*)&buf[i]);
//         v[1] = *((uint32_t*)&buf[i+4]);

//         decrypt_block(v, key);

//         v[0] ^= IV_tmp[0];
//         v[1] ^= IV_tmp[1];

//         IV_tmp[0] = *((uint32_t*)&buf[i]);
//         IV_tmp[1] = *((uint32_t*)&buf[i+4]);

//         *((uint32_t*)&buf[i]) = v[0];
//         *((uint32_t*)&buf[i+4]) = v[1];
//     }
// }

unsigned char* pkcs5(unsigned char *buf, size_t *p_len)
{
    int len = *p_len;
    int new_size = len / 8 * 8 + 8;
    int pad_size = len%8 ? 8-len%8 : 8;

    unsigned char *new_buf = malloc(new_size);
    memcpy(new_buf, buf, len);
    for(int i=0; i<pad_size; i++)
        new_buf[len+i] = pad_size;

    *p_len = new_size;
    return new_buf;
}

int main(void)
{
    printf("Input Flag:\n");
    scanf("%s", buf);
    size_t len = strlen(buf);
    unsigned char* pad_buf = pkcs5(buf, &len);

    encrypt(pad_buf, len);

    if(memcmp(pad_buf, cmp, sizeof(cmp)) == 0)
        printf("Congratulation!\n");
    else
        printf("Try again!\n");

    // unsigned char *pad_buf = cmp;
    // size_t len = sizeof(cmp);
    // decrypt(pad_buf, len);

    // for(int i=0; i<len; i++)
    //     printf("%02x", pad_buf[i]);
    // printf("\n");

    free(pad_buf);

    return 0;
}
