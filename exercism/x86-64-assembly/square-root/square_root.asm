section .text
global square_root
square_root:
    ; Input: edi (number to find square root of)
    ; Output: eax (integer square root, or -1 for error)

    ; Handle negative input
    test edi, edi
    js error

    ; Edge case: sqrt(0) = 0
    xor eax, eax
    cmp edi, 0
    je _end

    ; Initial guess using leading zero count
    mov ecx, 31         ; Maximum bit index
    lzcnt eax, edi      ; Count leading zeros
    sub ecx, eax        ; Effective bit width - 1
    shr ecx, 1          ; Divide bit width by 2
    mov eax, 1
    shlx eax, eax, ecx  ; Initial guess: 1 << (bit_width / 2)

newton:
    ; Approximate n / x using reciprocal multiplication
    mov ecx, edi        ; ecx = n
    mov edx, eax        ; edx = x
    mul edx             ; eax = x * x
    mov ebx, edi        ; ebx = n
    sub ebx, eax        ; ebx = n - x^2
    shr ebx, 1          ; Approximate: (n - x^2) / 2
    add eax, ebx        ; eax = x + (n - x^2) / 2

    ; Newton's update: x = (x + n / x) / 2
    shr eax, 1          ; eax = (x + approx(n / x)) / 2

    ; Convergence check
    cmp eax, edx        ; Check if x converges
    jne newton          ; Repeat until convergence

    ; Ensure result doesn't overshoot
    mov ecx, eax        ; ecx = sqrt(n)
    imul ecx, ecx       ; ecx = sqrt(n)^2
    cmp ecx, edi        ; Compare with n
    jbe _end            ; If sqrt(n)^2 <= n, we're done
    dec eax             ; Otherwise, decrement result

_end:
    ret

error:
    mov eax, -1         ; Error: return -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif


