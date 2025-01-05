section .text
global egg_count
egg_count:
    ; Provide your implementation here
    ; Brian Kernighan method
    xor eax, eax
    test edi, edi
    je _end
count:
    inc eax
    blsr edi, edi ; reset lsb
    jne count
_end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
