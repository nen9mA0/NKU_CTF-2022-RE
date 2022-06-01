import base64

# 这个base64换表的方法来自 https://stackoverflow.com/questions/5537750/decode-base64-like-string-with-different-index-tables

my_base64chars  = "/+9876543210zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA"
std_base64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

s = "mZOemISImpOckJKaoIuQoI2aiZqNjJaRmKCakZiWkZqajZaRmIL="

trans = my_base64chars.maketrans(my_base64chars, std_base64chars)
s = s.translate(trans)
data = base64.b64decode(s)
print(data)