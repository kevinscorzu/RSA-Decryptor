%include "io.inc"

section .text

fillDecryptedTable:
    mov     eax, 0
    mov     ebx, 0
    mov     ecx, 1
    mov     [RSACont], ecx
    mov     edx, 0
    jmp     fillDecryptedTableAux
    
fillDecryptedTableAux:
    mov     ecx, [RSACont]
    cmp     ecx, 256
    je      exitFillDecryptedTable
    mov     [b], ecx
    PRINT_CHAR 'C'
    PRINT_CHAR ':'
    PRINT_DEC   4, ecx
    NEWLINE
    call    RSADecryption
    PRINT_CHAR 'R'
    PRINT_CHAR ':'
    PRINT_DEC   4, eax
    NEWLINE
    ;FILLTABLE
    mov     ecx, [RSACont]
    inc     ecx
    mov     [RSACont], ecx
    jmp     fillDecryptedTableAux
       
exitFillDecryptedTable:
    ret

RSADecryption:
    mov     bx, [n]
    cmp     ebx, 1
    je      RSADecryptionAux
    mov     eax, 1
    mov     [r], eax
    mov     eax, [b]
    mov     edx, 0
    div     ebx
    mov     [b], edx
    mov     bx, [d]
    mov     [e], ebx
    jmp     RSADecryptionAux2    
    
RSADecryptionAux:
    mov     eax, 0
    ret

RSADecryptionAux2:
    mov     eax, [e]
    cmp     eax, 0
    jle     RSADecryptionAux3
    mov     ecx, 2
    mov     edx, 0
    div     ecx
    cmp     edx, 1
    je      RSADecryptionAux4
    jmp     RSADecryptionAux5
    
RSADecryptionAux3:
    mov     eax, [r]
    ret
    
RSADecryptionAux4:
    mov     eax, [r]
    mov     ebx, [b]
    mul     ebx
    mov     bx, [n]
    mov     edx, 0
    div     ebx
    mov     [r], edx
    jmp     RSADecryptionAux5
    
RSADecryptionAux5:
    mov     eax, [e]
    mov     ecx, 2
    mov     edx, 0
    div     ecx
    mov     [e], eax
    mov     eax, [b]
    mul     eax
    mov     bx, [n]
    mov     edx, 0
    div     ebx
    mov     [b], edx
    jmp     RSADecryptionAux2