section .text

decryptImage:
    mov     ebx, encImage
    mov     ecx, 0
    mov     edx, 0
    mov     [imgCont], ecx
    jmp     decryptImageAux
    
decryptImageAux:
    mov     eax, 0
    call    findNumber
    PRINT_DEC   4, eax
    NEWLINE
    cmp     edx, 1
    je      decryptImageExit
    cmp     eax, 0
    je      decryptImageAux2
    jmp     decryptImageAux4

decryptImageAux2:
    push    ecx
    mov     ecx, [imgCont]
    mov     eax, 48
    call    decryptImageAux3
    mov     eax, 32
    call    decryptImageAux3
    mov     eax, 48
    call    decryptImageAux3
    mov     eax, 32
    call    decryptImageAux3
    mov     [imgCont], ecx
    pop     ecx
    jmp     decryptImageAux
    
decryptImageAux3:
    mov     [decImage + ecx], al
    inc     ecx
    ret
    
decryptImageAux4:
    push    ebx
    push    ecx
    push    edx
    mov     ebx, [decTable]
    
    pop     edx
    pop     ecx
    pop     ebx
    
decryptImageExit:
    ret