from ctypes import *

iv = [0x98765432, 0x12345678]
mykey = [0x01234567, 0x89abcdef, 0xfedcba98, 0x76543210]
move = 16

mask64 = (1<<64)-1
mask32 = (1<<32)-1

content = [0xcc819a46,0xe0df67f6,0x31c959a,0x12aa480f,0x61248295,0xcf40cd8e,0xfd605666,0x731420a4,0x22734c19,0x99eafa97,0x870335d5,0x44a42faa]

def xtea_encrypt(v, key):
    v0, v1 = c_uint32(v[0]), c_uint32(v[1])
    delta = 0x9e3779b9

    total = c_uint32(0)

    for i in range(32):
        v0.value += ( ((v1.value << 4) ^ (v1.value >> 5)) + v1.value ) ^ (total.value + key[total.value & 3])
        total.value += delta
        v1.value += ( ((v0.value << 4) ^ (v0.value >> 5)) + v0.value ) ^ (total.value + key[(total.value >> 11) & 3])

    return v0.value, v1.value

def encrypt(content, length):
    mask = (1<<move)-1

    v = [0, 0]
    reg = [ iv[0], iv[1] ]
    for i in range(0, length, 2):
        v[0] = reg[0]
        v[1] = reg[1]

        v0_tmp, v1_tmp = xtea_encrypt(v, mykey)

        v_tmp = ( (v1_tmp<<32)|v0_tmp ) & mask64
        reg_tmp = ( (reg[1]<<32)|reg[0] ) & mask64
        reg_tmp = ( (reg_tmp << move) | (v_tmp & mask) ) & mask64

        reg[0] = reg_tmp & mask32
        reg[1] = (reg_tmp >> 32) & mask32

        content[i] = content[i] ^ v0_tmp
        content[i+1] = content[i+1] ^ v1_tmp


encrypt(content, len(content))
for i in content:
        tmp = i
        print("%c" %(tmp&0xff), end="")
        print("%c" %((tmp>>8)&0xff), end="")
        print("%c" %((tmp>>16)&0xff), end="")
        print("%c" %((tmp>>24)&0xff), end="")