section .text
global square
square:
    ; Provide your implementation here
    test rdi, rdi
    jle error
    cmp rdi, 64
    ja error
    lea ecx, [edi - 1]
    mov rax, 1
    shlx rax, rax, rcx
    ret

global total
total:
    mov rax, -1 ; `-1` is `1111...111` in 2's complement
    ret

global error
error:
    xor eax, eax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
