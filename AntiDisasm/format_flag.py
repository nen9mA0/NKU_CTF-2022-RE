flag = "469a81ccf667dfe09a951c030f48aa12958224618ecd40cf665660fda4201473194c732297faea99d5350387aa2fa444"

# mystr = "unsigned char cmp[] = { "

# j = 0
# for i in range(0, len(flag), 2):
#     mystr += "0x%s" %(flag[i:i+2])
#     j += 1
#     if i+2 != len(flag):
#         mystr += ","
#     if i==0 or j%8 != 0:
#         mystr += " "
#     else:
#         mystr += "\n"
#         mystr += "                        "
#         j = 0
# mystr += "};"

# print(mystr)

space = "        "
mystr = ""
for i in range(0, len(flag), 2):
    mystr += "%s\".byte 0x%s\\n\\t\"\n" %(space, flag[i:i+2])

print(mystr)