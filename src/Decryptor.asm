section .text

decryptImage:
    mov     ecx, 0
    mov     edx, 0
    mov     [encCont], ecx
    mov     [decCont], ecx
    jmp     decryptImageAux
    
decryptImageAux:
    mov     eax, 0
    mov     ebx, encImage
    mov     ecx, [encCont]
    call    findNumber
    cmp     edx, 1
    je      decryptImageExit
    mov     [temp], al
    mov     eax, 0
    call    findNumber
    mov     [encCont], ecx
    mov     ah, [temp]
    call    searchTables
    cmp     eax, 0
    je      decryptImageAux2
    mov     ebx, 0
    jmp     decryptImageAux4

decryptImageAux2:
    mov     eax, 48
    call    decryptImageAux3
    mov     eax, 32
    call    decryptImageAux3
    jmp     decryptImageAux
    
decryptImageAux3:
    mov     ecx, [decCont]
    mov     [decImage + ecx], al
    inc     ecx
    mov     [decCont], ecx
    ret
         
decryptImageAux4:
    push    eax
    cmp     eax, ebx
    je      decryptImageAux5
    jmp     decryptImageAux6
    
decryptImageAux5:
    pop     eax
    mov     eax, 32
    call    decryptImageAux3
    jmp     decryptImageAux
    
decryptImageAux6:
    cmp     eax, 0
    je      decryptImageAux7
    cmp     eax, ebx
    je      decryptImageAux7
    mov     ecx, 10
    mov     edx, 0
    div     ecx
    jmp     decryptImageAux6
    
decryptImageAux7:
    mov     eax, edx
    add     eax, 48
    call    decryptImageAux3
    mov     eax, ebx
    mov     ebx, 10
    push    edx
    mul     ebx
    pop     edx
    add     eax, edx
    mov     ebx, eax
    pop     eax
    jmp     decryptImageAux4
    
decryptImageExit:
    ret