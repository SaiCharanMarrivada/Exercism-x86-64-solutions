section .text
global steps
steps:
    ; Provide your implementation here
    test edi, edi
    jle error
    xor eax, eax
    cmp edi, 1
    je _end

sequence:
    lea ecx, [edi + 2*edi + 1]
    shr edi, 1
    cmovc edi, ecx
    tzcnt ecx, edi
    lea eax, [ecx + eax + 1]
    shr edi, cl
    cmp edi, 1
    jne sequence

_end:
    ret

error:
    mov eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
