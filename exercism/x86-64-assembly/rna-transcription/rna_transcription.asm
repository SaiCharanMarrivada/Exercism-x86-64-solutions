default rel

section .rodata
dna_to_rna:
    db 'U', 'A', 'G', 'A', 'A', 'A', 'C', 'A', 'A', 'A', 'A', 'A', 'A',
    db 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
    db 'A', 'A', 'A', 'A', 'A', 'A'

A: db (256 - 'A')

section .text
global to_rna
to_rna:
    xor eax, eax
    vpbroadcastb ymm0, [A]
    vmovdqu ymm1, [dna_to_rna]
rna:
    vpaddb ymm2, ymm0, [rdi + rax]
    vpshufb ymm2, ymm1, ymm2
    vmovdqu [rsi + rax], ymm2
    vpmovmskb ecx, ymm2
    add rax, 32
    test ecx, ecx
    jne rna
    vzeroupper
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
