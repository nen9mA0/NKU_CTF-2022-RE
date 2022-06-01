a = [0xa0,0x57,0x33,0x25,0x31,0x1a,0xe6,0xe1,0x2,0x70,0xb,0x1d,0x92,0xac,0x85,0x88,0x9f,0x8b,0x6f,0x6e,0x43,0x5d,0xd5,0xb0,0x73,0x46,0x6d,0x73,0x87,0x7,0x19,0xb8,0x20,0xa5,0x9,0x64]

init_str = "nkctf_1s_Am4z1ng"

def init(mystr):
    table1 = []
    table2 = []
    mylen = len(mystr)
    for i in range(256):
        table1.append(i)
        table2.append( ord(mystr[i % mylen]) )

    v8 = 0
    for i in range(256):
        v8 = (table1[i] + table2[i] + v8) % 256
        tmp = table1[i]
        table1[i] = table1[v8]
        table1[v8] = tmp
    return table1

def encrypt(table, myinput):
    result = []
    input_len = len(myinput)

    v6 = 0
    v7 = 0
    for i in range(input_len):
        v7 = (v7 + 1) % 256
        v6 = (table[v7] + v6) % 256
        tmp = table[v7]
        table[v7] = table[v6]
        table[v6] = tmp

        result.append( chr( myinput[i] ^ table[ (table[v7] + table[v6]) % 256 ] ) )

    return result

table = init(init_str)
result = encrypt(table, a)
print("".join(result))