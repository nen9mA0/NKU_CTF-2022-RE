#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "windows.h"

// flag{0ops_Y0u_Kn0w_H0w_2_F1x_Th3_Thunk_C0de}

uint32_t IV[] = {0x98765432, 0x12345678};
uint32_t key[] = {0x01234567, 0x89abcdef, 0xfedcba98, 0x76543210};
uint8_t s = 16;


char buf[100];

int FD_IsDebuggerPresent()
{
    int (*func_p)() = IsDebuggerPresent;
    uint8_t first_byte = *((uint8_t*)func_p);

    if(first_byte == 0xcc)
        return 1;
    else if(first_byte == 0xe9)
        return 1;

    if(func_p())
        return 1;
    return 0;
}

void encrypt_block(uint32_t *v, uint32_t *k)
{
    uint32_t v0 = v[0], v1 = v[1];
    uint32_t sum = 0;

    uint32_t delta = 0x9e3779b9;
    uint32_t k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];

    for(int i=0; i<32; i++)
    {
        v0 += (((v1<<4) ^ (v1>>5)) + v1) ^ (sum + key[sum & 3]);
        sum += delta;
        v1 += (((v0<<4) ^ (v0>>5)) + v0) ^ (sum + key[(sum>>11) & 3]);
    }
    v[0] = v0;
    v[1] = v1;
}

// void decrypt_block(uint32_t *v, uint32_t *k)
// {
//     uint32_t v0 = v[0], v1 = v[1];
//     uint32_t delta = 0x9e3779b9;
//     uint32_t sum = delta * 32;
//     uint32_t k0 = k[0], k1 = k[1], k2 = k[2], k3 = k[3];

//     for(int i=0; i<32; i++)
//     {
//         v1 -= (((v0<<4) ^ (v0>>5)) + v0) ^ (sum + key[(sum>>11) & 3]);
//         sum -= delta;
//         v0 -= (((v1<<4) ^ (v1>>5)) + v1) ^ (sum + key[sum & 3]);
//     }
//     v[0] = v0; v[1] = v1;
// }

void encrypt(unsigned char *pad_buf, size_t len)
{
    uint32_t v[2];
    uint64_t reg;
    uint64_t mask = (1<<s)-1;
    uint32_t *p_reg = (uint32_t*)&reg;
    uint64_t *p_v = (uint64_t*)v;

    p_reg[0] = IV[0];
    p_reg[1] = IV[1];

    for(int i=0; i<len; i+=8)
    {
        v[0] = p_reg[0];
        v[1] = p_reg[1];

        encrypt_block(v, key);

        reg = (reg << s) | (*p_v & mask);

        *((uint32_t*)&pad_buf[i]) ^= v[0];
        *((uint32_t*)&pad_buf[i+4]) ^= v[1];
    }
}

// void decrypt(unsigned char *buf, size_t len)
// {
//     uint32_t v[2];
//     uint64_t reg;
//     uint64_t mask = (1<<s)-1;
//     uint32_t *p_reg = (uint32_t*)&reg;
//     uint64_t *p_v = (uint64_t*)v;

//     p_reg[0] = IV[0];
//     p_reg[1] = IV[1];

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
    unsigned char *cmp = NULL;
    printf("Input Flag:\n");
    scanf("%s", buf);
    size_t len = strlen(buf);

    if(FD_IsDebuggerPresent())
        exit(-1);

    unsigned char* pad_buf = pkcs5(buf, &len);

    encrypt(pad_buf, len);

    asm volatile (
        "call anti2\n\t"
        "anti1:\n\t"
        ".byte 0xe9\n\t"
        ".byte 0x46\n\t"
        ".byte 0x9a\n\t"
        ".byte 0x81\n\t"
        ".byte 0xcc\n\t"
        ".byte 0xf6\n\t"
        ".byte 0x67\n\t"
        ".byte 0xdf\n\t"
        ".byte 0xe0\n\t"
        ".byte 0x9a\n\t"
        ".byte 0x95\n\t"
        ".byte 0x1c\n\t"
        ".byte 0x03\n\t"
        ".byte 0x0f\n\t"
        ".byte 0x48\n\t"
        ".byte 0xaa\n\t"
        ".byte 0x12\n\t"
        ".byte 0x95\n\t"
        ".byte 0x82\n\t"
        ".byte 0x24\n\t"
        ".byte 0x61\n\t"
        ".byte 0x8e\n\t"
        ".byte 0xcd\n\t"
        ".byte 0x40\n\t"
        ".byte 0xcf\n\t"
        ".byte 0x66\n\t"
        ".byte 0x56\n\t"
        ".byte 0x60\n\t"
        ".byte 0xfd\n\t"
        ".byte 0xa4\n\t"
        ".byte 0x20\n\t"
        ".byte 0x14\n\t"
        ".byte 0x73\n\t"
        ".byte 0x19\n\t"
        ".byte 0x4c\n\t"
        ".byte 0x73\n\t"
        ".byte 0x22\n\t"
        ".byte 0x97\n\t"
        ".byte 0xfa\n\t"
        ".byte 0xea\n\t"
        ".byte 0x99\n\t"
        ".byte 0xd5\n\t"
        ".byte 0x35\n\t"
        ".byte 0x03\n\t"
        ".byte 0x87\n\t"
        ".byte 0xaa\n\t"
        ".byte 0x2f\n\t"
        ".byte 0xa4\n\t"
        ".byte 0x44\n\t"
        "anti2:\n\t"
        "push rax\n\t"
        "xor rax, rax\n\t"
        "jnz anti1\n\t"
        "pop rax\n\t"
        "pop %0\n\t"
        "inc %0\n\t"
        : "=r" (cmp)
    );

    if(memcmp(pad_buf, cmp, 48) == 0)
        printf("Congratulation!\n");
    else
        printf("Try again!\n");

    // for(int i=0; i<len; i++)
    //     printf("%02x", pad_buf[i]);
    // printf("\n");

    // // unsigned char *pad_buf = cmp;
    // // size_t len = 48;
    // decrypt(pad_buf, len);

    // for(int i=0; i<len; i++)
    //     printf("%02x", pad_buf[i]);
    // printf("\n");

    free(pad_buf);

    return 0;
}
