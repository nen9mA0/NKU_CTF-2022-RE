import ctypes

cipher = [0x35e938c1,0xda99481,0x81d66cc8,0xf191766f,0x9f32984,0xf6dde5be,0x4b19af9,0xa4d20c70,0x15cc4772,0xe90392c8]
iv = [0xdeadbeef, 0xcafebabe]
key = [0x5a5aa5a5, 0xa5a55a5a, 0x00000000, 0x00000000]

def decrypt_block(block, key):
    v0 = ctypes.c_uint32(block[0])
    v1 = ctypes.c_uint32(block[1])

    delta = 0x9e3779b9
    sum = ctypes.c_uint32(delta*32)

    for i in range(32):
        v1.value -= ( (v0.value<<4) + key[2] ) ^ (v0.value + sum.value) ^ ( (v0.value>>5) + key[3] )
        v0.value -= ( (v1.value<<4) + key[0] ) ^ (v1.value + sum.value) ^ ( (v1.value>>5) + key[1] )
        sum.value -= delta

    return v0.value, v1.value


def decrypt(cipher, key):
    cipher_len = len(cipher)
    v = [0, 0]
    iv_tmp = [0, 0]

    v[0] = cipher[0]
    v[1] = cipher[1]
    iv_tmp[0] = v[0]
    iv_tmp[1] = v[1]

    v[0], v[1] = decrypt_block(v, key)
    v[0] ^= iv[0]
    v[1] ^= iv[1]

    cipher[0] = v[0]
    cipher[1] = v[1]

    for i in range(2, cipher_len, 2):
        v[0] = cipher[i]
        v[1] = cipher[i+1]
        v[0], v[1] = decrypt_block(v, key)
        v[0] ^= iv_tmp[0]
        v[1] ^= iv_tmp[1]

        iv_tmp[0] = cipher[i]
        iv_tmp[1] = cipher[i+1]
        cipher[i] = v[0]
        cipher[i+1] = v[1]


decrypt(cipher, key)
for i in cipher:
        tmp = i
        print("%c" %(tmp&0xff), end="")
        print("%c" %((tmp>>8)&0xff), end="")
        print("%c" %((tmp>>16)&0xff), end="")
        print("%c" %((tmp>>24)&0xff), end="")