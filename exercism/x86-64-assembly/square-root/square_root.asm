section .text
global square_root
square_root:
    ; Provide your implementation here
    test edi, edi
    js error
    mov eax, -1
root:
    inc eax
    mov ecx, eax
    imul ecx, eax
    cmp ecx, edi
    jne root
_end:
    ret
error:
    mov eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
