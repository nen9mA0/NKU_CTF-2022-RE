#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// flag{Now_You_Know_What_Is_Packer!!!}

// char flag[] = "flag{N0w_Y0u_Kn0w_Wh4t_1s_P4ck3r!!!}";

unsigned char cmp[] = { 0xa0, 0x57, 0x33, 0x25, 0x31, 0x1a, 0xe6, 0xe1,
                        0x02, 0x70, 0x0b, 0x1d, 0x92, 0xac, 0x85, 0x88,
                        0x9f, 0x8b, 0x6f, 0x6e, 0x43, 0x5d, 0xd5, 0xb0,
                        0x73, 0x46, 0x6d, 0x73, 0x87, 0x07, 0x19, 0xb8,
                        0x20, 0xa5, 0x09, 0x64
                        };

char key[] = "nkctf_1s_Am4z1ng";

unsigned char buf[100];
unsigned char sbox[256];


void rc4_init(unsigned char *s, unsigned char *key, unsigned long len)
{
    int j=0;
    unsigned char tmp = 0;
    char k[256];

    for(int i=0; i<256; i++)
    {
        s[i] = i;
        k[i] = key[i%len];
    }

    for(int i=0; i<256; i++)
    {
        j = (j + s[i] + k[i]) % 256;
        tmp = s[i];
        s[i] = s[j];
        s[j] = tmp;
    }
}

void rc4_crypt(unsigned char *s, unsigned char *data, unsigned long len)
{
    int i=0, j=0, t=0;
    unsigned long k = 0;
    unsigned char tmp;

    for(k=0; k<len; k++)
    {
        i = (i+1) % 256;
        j = (j+s[i]) % 256;
        tmp = s[i];
        s[i] = s[j];
        s[j] = tmp;
        t = (s[i]+s[j]) % 256;
        data[k] ^= s[t];
    }
}


int main(void)
{
    printf("Input Flag:\n");
    scanf("%s", buf);
    size_t len = strlen(buf);
    if(len != 36)
    {
        printf("Try again!\n");
        exit(0);
    }
    rc4_init(sbox, key, strlen(key));
    rc4_crypt(sbox, buf, len);

    if(memcmp(buf, cmp, sizeof(cmp)) == 0)
        printf("Congratulation!\n");
    else
        printf("Try again!\n");

    // size_t len = sizeof(cmp);
    // rc4_init(sbox, key, strlen(key));
    // rc4_crypt(sbox, cmp, len);

    // for(int i=0; i<len; i++)
    //     printf("%02x", cmp[i]);
    // printf("\n");

    return 0;
}
