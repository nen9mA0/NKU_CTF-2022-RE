flag = "2838a9137103d37a099de8d2c6fd478423a698e021ee1e6da6e2459bcbcffd7129adae17520888665b29122ed6562b35"

mystr = "unsigned char cmp[] = { "

j = 0
for i in range(0, len(flag), 2):
    mystr += "0x%s" %(flag[i:i+2])
    j += 1
    if i+2 != len(flag):
        mystr += ","
    if i==0 or j%8 != 0:
        mystr += " "
    else:
        mystr += "\n"
        mystr += "                        "
        j = 0
mystr += "};"

print(mystr)