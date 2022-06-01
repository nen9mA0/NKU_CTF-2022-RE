#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// flag{The_Answer_Is_Out_There_Neo...}

// int mat1[9] = {
//     1, 2, 3,
//     4, 5, 6,
//     7, 8, 9
// };

// int mat2[9] = {
//     11, 12, 13,
//     14, 15, 16,
//     17, 18, 19
// };


int mat1[36] = {
    53, 99, 58, 77, 89, 26,
    81, 13, 70, 69,  4, 89,
    12, 69, 59, 77, 60, 17,
    60, 75, 36, 72, 50, 27,
    57, 98, 85, 92,  0, 45,
    65, 42, 71, 73, 28, 27
};

char input[100];
int mat2[36];


int res[36] = {
    41801, 39539, 41509, 36521, 38609, 39167,
    33904, 32865, 29695, 28340, 27532, 33582,
    30693, 28254, 31076, 27100, 27170, 29001,
    32971, 31426, 32415, 29119, 31090, 31128,
    39406, 36902, 37363, 33058, 34806, 39186,
    32021, 30025, 31364, 28708, 28635, 30146
};


int* MatrixMul(int *mat1, int *mat2, int len)
{
    int *mat = malloc(len*len*sizeof(int));
    memset(mat, 0, len*len*sizeof(int));

    for(int i=0; i<len; i++)
    {
        for(int j=0; j<len; j++)
        {
            for(int k=0; k<len; k++)
            {
                mat[i*len+j] += mat1[i*len+k] * mat2[k*len+j];
            }
        }
    }
    return mat;
}

// int PrintMatrix(int *mat, int len)
// {
//     for(int i=0; i<len; i++)
//     {
//         for(int j=0; j<len; j++)
//             printf("%d ", mat[i*len+j]);
//         printf("\n");
//     }
// }


int main(void)
{
    printf("Input Flag:\n");
    scanf("%s", input);
    if(strlen(input) != 36)
    {
        printf("Try Again!\n");
        exit(0);
    }
    else
    {
        for(int i=0; i<strlen(input); i++)
            mat2[i] = input[i];
    }

    int *mat = MatrixMul(mat1, mat2, 6);

    if(memcmp(mat, res, 6*6*sizeof(int)) == 0)
        printf("Congratulation!\n");
    else
        printf("Try Again!\n");

    return 0;
}