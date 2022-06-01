	.file	"antidisasm.c"
	.intel_syntax noprefix
	.text
	.globl	IV
	.data
	.align 8
IV:
	.long	-1737075662
	.long	305419896
	.globl	key
	.align 16
key:
	.long	19088743
	.long	-1985229329
	.long	-19088744
	.long	1985229328
	.globl	s
s:
	.byte	16
	.comm	buf, 100, 5
	.text
	.globl	FD_IsDebuggerPresent
	.def	FD_IsDebuggerPresent;	.scl	2;	.type	32;	.endef
	.seh_proc	FD_IsDebuggerPresent
FD_IsDebuggerPresent:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 48
	.seh_stackalloc	48
	.seh_endprologue
	mov	rax, QWORD PTR __imp_IsDebuggerPresent[rip]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -9[rbp], al
	cmp	BYTE PTR -9[rbp], -52
	jne	.L2
	mov	eax, 1
	jmp	.L3
.L2:
	cmp	BYTE PTR -9[rbp], -23
	jne	.L4
	mov	eax, 1
	jmp	.L3
.L4:
	mov	rax, QWORD PTR -8[rbp]
	call	rax
	test	eax, eax
	je	.L5
	mov	eax, 1
	jmp	.L3
.L5:
	mov	eax, 0
.L3:
	add	rsp, 48
	pop	rbp
	ret
	.seh_endproc
	.globl	encrypt_block
	.def	encrypt_block;	.scl	2;	.type	32;	.endef
	.seh_proc	encrypt_block
encrypt_block:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 48
	.seh_stackalloc	48
	.seh_endprologue
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	rax, QWORD PTR 16[rbp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -4[rbp], eax
	mov	rax, QWORD PTR 16[rbp]
	mov	eax, DWORD PTR 4[rax]
	mov	DWORD PTR -8[rbp], eax
	mov	DWORD PTR -12[rbp], 0
	mov	DWORD PTR -20[rbp], -1640531527
	mov	rax, QWORD PTR 24[rbp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -24[rbp], eax
	mov	rax, QWORD PTR 24[rbp]
	mov	eax, DWORD PTR 4[rax]
	mov	DWORD PTR -28[rbp], eax
	mov	rax, QWORD PTR 24[rbp]
	mov	eax, DWORD PTR 8[rax]
	mov	DWORD PTR -32[rbp], eax
	mov	rax, QWORD PTR 24[rbp]
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	mov	eax, DWORD PTR 12[rax]
	mov	DWORD PTR -36[rbp], eax
	mov	DWORD PTR -16[rbp], 0
	push rax
	mov rax, OFFSET .L7
	xchg [rsp], rax
	ret
.L8:
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	mov	eax, DWORD PTR -8[rbp]
	sal	eax, 4
	mov	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	shr	eax, 5
	xor	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	lea	ecx, [rdx+rax]
	mov	eax, DWORD PTR -12[rbp]
	and	eax, 3
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, key[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -12[rbp]
	add	eax, edx
	xor	eax, ecx
	add	DWORD PTR -4[rbp], eax
	mov	eax, DWORD PTR -20[rbp]
	add	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -4[rbp]
	sal	eax, 4
	mov	edx, eax
	mov	eax, DWORD PTR -4[rbp]
	shr	eax, 5
	xor	edx, eax
	mov	eax, DWORD PTR -4[rbp]
	lea	ecx, [rdx+rax]
	mov	eax, DWORD PTR -12[rbp]
	shr	eax, 11
	and	eax, 3
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, key[rip]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -12[rbp]
	add	eax, edx
	xor	eax, ecx
	add	DWORD PTR -8[rbp], eax
	add	DWORD PTR -16[rbp], 1
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
.L7:
	cmp	DWORD PTR -16[rbp], 31
	jle	.L8
	mov	rax, QWORD PTR 16[rbp]
	mov	edx, DWORD PTR -4[rbp]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR 16[rbp]
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	add	rax, 4
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	mov	edx, DWORD PTR -8[rbp]
	mov	DWORD PTR [rax], edx
	nop
	add	rsp, 48
	pop	rbp
	ret
	.seh_endproc
	.globl	encrypt
	.def	encrypt;	.scl	2;	.type	32;	.endef
	.seh_proc	encrypt
encrypt:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 80
	.seh_stackalloc	80
	.seh_endprologue
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	movzx	eax, BYTE PTR s[rip]
	movzx	eax, al
	mov	edx, 1
	mov	ecx, eax
	sal	edx, cl
	mov	eax, edx
	sub	eax, 1
	cdqe
	mov	QWORD PTR -16[rbp], rax
	lea	rax, -48[rbp]
	mov	QWORD PTR -24[rbp], rax
	lea	rax, -40[rbp]
	mov	QWORD PTR -32[rbp], rax
	mov	edx, DWORD PTR IV[rip]
	mov	rax, QWORD PTR -24[rbp]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR -24[rbp]
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	add	rax, 4
	mov	edx, DWORD PTR IV[rip+4]
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	mov	DWORD PTR [rax], edx
	mov	DWORD PTR -4[rbp], 0
	jz .L10
	jnz .L10
	.byte 0xe8
.L11:
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -40[rbp], eax
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR 4[rax]
	mov	DWORD PTR -36[rbp], eax
	lea	rax, -40[rbp]
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	lea	rdx, key[rip]
	mov	rcx, rax
	call	encrypt_block
	mov	rdx, QWORD PTR -48[rbp]
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	movzx	eax, BYTE PTR s[rip]
	movzx	eax, al
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	mov	ecx, eax
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	sal	rdx, cl
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	mov	rax, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR [rax]
	and	rax, QWORD PTR -16[rbp]
	or	rax, rdx
	mov	QWORD PTR -48[rbp], rax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	rdx, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	ecx, DWORD PTR [rax]
	mov	edx, DWORD PTR -40[rbp]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	mov	r8, QWORD PTR 16[rbp]
	add	rax, r8
	xor	edx, ecx
	mov	DWORD PTR [rax], edx
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 4[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, rdx
	mov	ecx, DWORD PTR [rax]
	mov	edx, DWORD PTR -36[rbp]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	r8, 4[rax]
	mov	rax, QWORD PTR 16[rbp]
	add	rax, r8
	xor	edx, ecx
	mov	DWORD PTR [rax], edx
	add	DWORD PTR -4[rbp], 8
.L10:
	mov	eax, DWORD PTR -4[rbp]
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	cdqe
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	cmp	QWORD PTR 24[rbp], rax
	push rax
	push rbx
	mov rax, OFFSET poly_ja_1
	mov rbx, OFFSET .L11
	cmova rax, rbx
	pop rbx
	xchg [rsp], rax
	ret
	poly_ja_1:
	nop
	add	rsp, 80
	pop	rbp
	ret
	.seh_endproc
	.globl	pkcs5
	.def	pkcs5;	.scl	2;	.type	32;	.endef
	.seh_proc	pkcs5
pkcs5:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 64
	.seh_stackalloc	64
	.seh_endprologue
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	rax, QWORD PTR 24[rbp]
	mov	rax, QWORD PTR [rax]
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	mov	DWORD PTR -8[rbp], eax
	mov	eax, DWORD PTR -8[rbp]
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	lea	edx, 7[rax]
	test	eax, eax
	cmovs	eax, edx
	sar	eax, 3
	add	eax, 1
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	sal	eax, 3
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -8[rbp]
	and	eax, 7
	test	eax, eax
	push rax
	push rbx
	mov rax, OFFSET poly_jz_1
	mov rbx, OFFSET .L13
	cmovz rax, rbx
	pop rbx
	xchg [rsp], rax
	ret
	poly_jz_1:
	mov	edx, DWORD PTR -8[rbp]
	mov	eax, edx
	sar	eax, 31
	shr	eax, 29
	add	edx, eax
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	and	edx, 7
	sub	edx, eax
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	mov	eax, edx
	mov	edx, 8
	sub	edx, eax
	mov	eax, edx
	jz .L14
	jnz .L14
	.byte 0xe8
.L13:
	mov	eax, 8
.L14:
	mov	DWORD PTR -16[rbp], eax
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	rcx, rax
	call	malloc
	mov	QWORD PTR -24[rbp], rax
	mov	eax, DWORD PTR -8[rbp]
	movsx	rdx, eax
	push rax
	.byte 0x66
	.byte 0xb8
	.byte 0xeb
	.byte 0x05
	.byte 0x31
	.byte 0xc0
	.byte 0x74
	.byte 0xfa
	.byte 0xe8
	pop rax
	mov	rax, QWORD PTR -24[rbp]
	mov	r8, rdx
	mov	rdx, QWORD PTR 16[rbp]
	mov	rcx, rax
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	call	memcpy
	mov	DWORD PTR -4[rbp], 0
	jz .L15
	jnz .L15
	.byte 0xe8
.L16:
	mov	edx, DWORD PTR -8[rbp]
	mov	eax, DWORD PTR -4[rbp]
	add	eax, edx
	cdqe
	mov	rdx, QWORD PTR -24[rbp]
	.byte 0xeb
	.byte 0xff
	.byte 0xc0
	.byte 0xff
	.byte 0xc8
	add	rax, rdx
	mov	edx, DWORD PTR -16[rbp]
	mov	BYTE PTR [rax], dl
	add	DWORD PTR -4[rbp], 1
.L15:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -16[rbp]
	push rax
	push rbx
	mov rax, OFFSET poly_jl_1
	mov rbx, OFFSET .L16
	cmovl rax, rbx
	pop rbx
	xchg [rsp], rax
	ret
	poly_jl_1:
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	rdx, QWORD PTR 24[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -24[rbp]
	add	rsp, 64
	pop	rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Input Flag:\0"
.LC1:
	.ascii "%s\0"
.LC2:
	.ascii "Congratulation!\0"
.LC3:
	.ascii "Try again!\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 64
	.seh_stackalloc	64
	.seh_endprologue
	call	__main
	mov	QWORD PTR -8[rbp], 0
	lea	rcx, .LC0[rip]
	call	puts
	lea	rax, buf[rip]
	mov	rdx, rax
	lea	rcx, .LC1[rip]
	call	scanf
	lea	rax, buf[rip]
	mov	rcx, rax
	call	strlen
	mov	QWORD PTR -24[rbp], rax
	call	FD_IsDebuggerPresent
	test	eax, eax
	je	.L19
	mov	ecx, -1
	call	exit
.L19:
	lea	rax, -24[rbp]
	mov	rdx, rax
	lea	rax, buf[rip]
	mov	rcx, rax
	call	pkcs5
	mov	QWORD PTR -16[rbp], rax
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	encrypt
/APP
 # 149 "antidisasm.c" 1
	call anti2
	anti1:
	.byte 0xe9
	.byte 0x46
	.byte 0x9a
	.byte 0x81
	.byte 0xcc
	.byte 0xf6
	.byte 0x67
	.byte 0xdf
	.byte 0xe0
	.byte 0x9a
	.byte 0x95
	.byte 0x1c
	.byte 0x03
	.byte 0x0f
	.byte 0x48
	.byte 0xaa
	.byte 0x12
	.byte 0x95
	.byte 0x82
	.byte 0x24
	.byte 0x61
	.byte 0x8e
	.byte 0xcd
	.byte 0x40
	.byte 0xcf
	.byte 0x66
	.byte 0x56
	.byte 0x60
	.byte 0xfd
	.byte 0xa4
	.byte 0x20
	.byte 0x14
	.byte 0x73
	.byte 0x19
	.byte 0x4c
	.byte 0x73
	.byte 0x22
	.byte 0x97
	.byte 0xfa
	.byte 0xea
	.byte 0x99
	.byte 0xd5
	.byte 0x35
	.byte 0x03
	.byte 0x87
	.byte 0xaa
	.byte 0x2f
	.byte 0xa4
	.byte 0x44
	anti2:
	push rax
	xor rax, rax
	jnz anti1
	pop rax
	pop rax
	inc rax
	
 # 0 "" 2
/NO_APP
	mov	QWORD PTR -8[rbp], rax
	mov	rdx, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	r8d, 48
	mov	rcx, rax
	call	memcmp
	test	eax, eax
	jne	.L20
	lea	rcx, .LC2[rip]
	call	puts
	jmp	.L21
.L20:
	lea	rcx, .LC3[rip]
	call	puts
.L21:
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	call	free
	mov	eax, 0
	add	rsp, 64
	pop	rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	scanf;	.scl	2;	.type	32;	.endef
	.def	strlen;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	memcmp;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
