from ast import For
import random
import string

filename = "antidisasm"
suffix = ".s"

junk_code_insert_rate = 10

poly_jmp = [
    [
        "push rax",
        "mov rax, OFFSET {label}",
        "xchg [rsp], rax",
        "ret"
    ],
    [
        "jz {label}",
        "jnz {label}",
        ".byte 0xe8"
    ]
]

poly_jz = [
    [
        "push rax",
        "push rbx",
        "mov rax, OFFSET poly_jz_1",
        "mov rbx, OFFSET {label}",
        "cmovz rax, rbx",
        "pop rbx",
        "xchg [rsp], rax",
        "ret",
        "poly_jz_1:"
    ]
]

poly_jl = [
    [
        "push rax",
        "push rbx",
        "mov rax, OFFSET poly_jl_1",
        "mov rbx, OFFSET {label}",
        "cmovl rax, rbx",
        "pop rbx",
        "xchg [rsp], rax",
        "ret",
        "poly_jl_1:"
    ]
]

poly_ja = [
    [
        "push rax",
        "push rbx",
        "mov rax, OFFSET poly_ja_1",
        "mov rbx, OFFSET {label}",
        "cmova rax, rbx",
        "pop rbx",
        "xchg [rsp], rax",
        "ret",
        "poly_ja_1:"
    ]
]

junk_code = [   # jmp -1; inc eax; dec eax;
    [
        ".byte 0xeb",
        ".byte 0xff",
        ".byte 0xc0",
        ".byte 0xff",
        ".byte 0xc8"
    ],
    [           # push rax; mov ax, 05ebh; xor eax, eax; jz -6; jmp 5; pop rax;
        "push rax",
        ".byte 0x66",
        ".byte 0xb8",
        ".byte 0xeb",
        ".byte 0x05",
        ".byte 0x31",
        ".byte 0xc0",
        ".byte 0x74",
        ".byte 0xfa",
        ".byte 0xe8",
        "pop rax"
    ]
]


def FormatAsm(fmt_str, kwargs):
    return "\t" + fmt_str.format(**kwargs) + "\n"

def GetLabel(line):
    end_index = len(line)-1
    if line[end_index] == "\n":
        end_index -= 1
    begin_index = end_index
    while True:
        if not line[begin_index].isspace():
            begin_index -= 1
        else:
            break
    return line[begin_index+1:end_index+1]

def Poly(lines):
    patterns = {"jmp":poly_jmp, "jz":poly_jz, "je":poly_jz, "jl":poly_jl, "ja":poly_ja}
    new_lines = []
    user_code = False
    for line in lines:
        flag = False
        for pattern in patterns:
            if pattern+"\t" in line:
                flag = True
                label = GetLabel(line)
                param_dct = {"label":label}
                asm_lst = random.choice(patterns[pattern])
                for asm in asm_lst:
                    new_line = FormatAsm(asm, param_dct)
                    new_lines.append(new_line)
                break
        if not flag:
            if ".seh_endprologue" in line:
                user_code = True
            elif "add\trsp" in line:
                user_code = False

            if user_code:
                num = random.randint(0, 100)
                if num < junk_code_insert_rate:
                    label = GetLabel(line)
                    param_dct = {"label":label}
                    asm_lst = random.choice(junk_code)
                    for asm in asm_lst:
                        new_line = FormatAsm(asm, param_dct)
                        new_lines.append(new_line)
            # else:
            #     test = 0
            new_lines.append(line)
    return new_lines


def GetFunc(lines, func_name):
    find_func = False
    index = 0
    begin_index = 0
    end_index = 0
    for line in lines:
        if "seh_proc" in line and func_name+"\n" in line:
            find_func = True
            begin_index = index+2
        if find_func and "seh_endproc" in line:
            end_index = index-1
            break
        index += 1

    return (begin_index, end_index)

def ChangeLines(change_lst, lines):
    new_lines = []

    change_lst = sorted(change_lst, key = lambda change : change[0])
    prev_index = 0
    for begin, end, change in change_lst:
        new_lines.extend(lines[prev_index:begin])
        new_lines.extend(change)
        prev_index = end
    new_lines.extend(lines[prev_index:])
    return new_lines


if __name__ == "__main__":
    change_lst = []

    with open(filename+suffix, "r") as f:
        lines = f.readlines()

    begin_index, end_index = GetFunc(lines, "encrypt")
    new_lines = Poly(lines[begin_index:end_index])
    change_lst.append( (begin_index, end_index, new_lines) )

    begin_index, end_index = GetFunc(lines, "encrypt_block")
    new_lines = Poly(lines[begin_index:end_index])
    change_lst.append( (begin_index, end_index, new_lines) )

    begin_index, end_index = GetFunc(lines, "pkcs5")
    new_lines = Poly(lines[begin_index:end_index])
    change_lst.append( (begin_index, end_index, new_lines) )

    new_lines = ChangeLines(change_lst, lines)

    with open(filename+"_change"+suffix, "w") as f:
        f.writelines(new_lines)
