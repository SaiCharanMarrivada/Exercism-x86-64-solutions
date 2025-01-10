section .text
global distance

%include <string.h>

distance:
    xor rdx, rdx
    xor rax, rax
    ; Provide your implementation here
    mov [rsi], cl
    cmp BYTE PTR [rdi], cl

    // movb [rdi], rax

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
