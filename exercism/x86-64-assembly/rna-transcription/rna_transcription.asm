default rel

section .rodata
dna_to_rna:
    db 'U', '0', 'G', '0', '0', '0', 'C', '0', '0', '0', '0', '0', '0',
    db '0', '0', '0', '0', '0', '0', 'A', '0', '0', '0', '0', '0', '0'

section .text
global to_rna
to_rna:
    xor ecx, ecx
    xor eax, eax
    lea rdx, [dna_to_rna]
rna:
    mov al, byte [rdi + rcx]
    sub al, 'A'
    js _end
    mov al, byte [rax + rdx]
    mov byte [rsi + rcx], al
    inc rcx
    jmp rna

_end:
    mov byte [rsi + rcx], 0 ; null terminate it
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
