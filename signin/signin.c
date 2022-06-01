#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char flag[100];

// flag{welcome_to_reversing_engineering}
// char table[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
char table[64] = "/+9876543210zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA";
char cmp[] = "mZOemISImpOckJKaoIuQoI2aiZqNjJaRmKCakZiWkZqajZaRmIL=";


char* base(char* buf)
{
    int i,j;
    int len = strlen(buf);
    int new_len = len/3*4+4;
    char* res = malloc(new_len);
    memset(res, 0, new_len);

    for(i=0,j=0; i<new_len; i+=4, j+=3)
    {
        char a = (buf[j] >> 2) & 0x3f;
        char b = ( (buf[j] << 4) | (buf[j+1] >> 4) ) & 0x3f;
        char c = ( (buf[j+1] << 2) | (buf[j+2] >> 6) ) & 0x3f;
        char d = buf[j+2] & 0x3f;

        res[i] = table[a];
        res[i+1] = table[b];
        res[i+2] = table[c];
        res[i+3] = table[d];
    }

    if(len % 3 == 1)
    {
        res[i-2] = '=';
        res[i-1] = '=';
        res[i] = '\0';
    }
    else if(len % 3 == 2)
    {
        res[i-1] = '=';
        res[i] = '\0';
    }
    else
        res[i-4] = '\0';

    return res;
}


int main(void)
{
    printf("Input Flag:\n");
    scanf("%s", flag);

    if(strlen(flag) != 38)
    {
        printf("Try again!\n");
        exit(0);
    }

    char* res = base(flag);

    if(memcmp(res, cmp, strlen(res)) == 0)
        printf("Congratulation!\n");
    else
        printf("Try again!\n");

    return 0;
}