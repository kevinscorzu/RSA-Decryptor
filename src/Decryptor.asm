section .text

decryptImage:
    mov     ecx, 0                  ; Se mueve un 0 a ecx para vaciarlo
    mov     edx, 0                  ; Se mueve un 0 a edx para vaciarlo
    mov     [encCont], ecx          ; Se inicializa el contador de la imagen encriptada
    mov     [decCont], ecx          ; Se inicializa el contador de la imagen desencriptada
    jmp     decryptImageAux         ; Se salta a la función auxiliar
    
decryptImageAux:
    mov     eax, 0                  ; Se mueve un 0 a eax para vaciarlo
    mov     ebx, encImage           ; Se mueve la posición de memoria de la imagen encriptada a ebx
    mov     ecx, [encCont]          ; Se mueve el contador de la imagen encriptada a ecx
    call    findNumber              ; Se llama la función para buscar el siguiente número de la imagen encriptada
    cmp     edx, 1                  ; Se verifica edx para comprobar si se llegó al final del archivo
    je      decryptImageExit        ; Si es 1, se llegó al final y salta a la función de salida
    mov     [temp], al              ; Sino se almacena el número encontrado en la variable temp
    mov     eax, 0                  ; Se mueve un 0 a eax para vaciarlo
    call    findNumber              ; Se llama la función para buscar el siguiente número
    mov     [encCont], ecx          ; Se almacena el contador de la imagen encriptada actual
    mov     ah, [temp]              ; Se mueve el número almacenado en temp a los 8 bits máx significativos de ax
    call    searchTables            ; Se llama la función para buscar el valor desenciptado que tiene el número de eax
    cmp     eax, 0                  ; Se compara eax con 0
    je      decryptImageAux2        ; Si es 0, se salta a la función auxiliar 2
    mov     ebx, 0                  ; Sino se vacía ebx con un 0
    jmp     decryptImageAux4        ; Y se salta a la función auxiliar 4

decryptImageAux2:
    mov     eax, 48                 ; Se mueve un 48 (0 en ASCII) a eax
    call    decryptImageAux3        ; Se llama la función auxiliar 3
    mov     eax, 32                 ; Se mueve un 32 (espacio en ASCII) a eax
    call    decryptImageAux3        ; Se llama la función auxiliar 3
    jmp     decryptImageAux         ; Se salta a la función auxiliar inicial
    
decryptImageAux3:
    mov     ecx, [decCont]          ; Se mueve el contador de la imagen desencriptada a ecx
    mov     [decImage + ecx], al    ; Se almacena el byte menos significativo de eax en la posición de memoria designada
    inc     ecx                     ; Se incrementa ecx
    mov     [decCont], ecx          ; Se almacena el contador de la imagen desencriptada
    ret                             ; Se retorna de la función
         
decryptImageAux4:
    push    eax                     ; Se almacena eax en el stack
    cmp     eax, ebx                ; Se compara eax con ebx
    je      decryptImageAux5        ; Si son iguales se salta a la función auxiliar 5
    jmp     decryptImageAux6        ; Sino, se salta a la 6
    
decryptImageAux5:
    pop     eax                     ; Se saca eax del stack
    mov     eax, 32                 ; Se mueve un 32 (espacio en ASCII) a eax
    call    decryptImageAux3        ; Se llama la función auxiliar 3
    jmp     decryptImageAux         ; Se salta a la función auxiliar principal
    
decryptImageAux6:
    cmp     eax, 0                  ; Se compara eax con 0
    je      decryptImageAux7        ; Si es 0, se salta a la función auxiliar 7
    cmp     eax, ebx                ; Se compara eax con ebx
    je      decryptImageAux7        ; Si son iguales, se salta a la función auxiliar 7
    mov     ecx, 10                 ; Se mueve un 10 a ecx
    mov     edx, 0                  ; Se vacía edx
    div     ecx                     ; Se divide eax entre 10
    jmp     decryptImageAux6        ; Se salta al inicio del loop de esta función auxiliar
    
decryptImageAux7:
    mov     eax, edx                ; Se mueve el valor de edx a eax
    add     eax, 48                 ; Se suman 48 a eax
    call    decryptImageAux3        ; Se llama la función auxiliar 3
    mov     eax, ebx                ; Se mueve ebx a eax
    mov     ebx, 10                 ; Se mueve un 10 a ebx
    push    edx                     ; Se almacena edx en el stack
    mul     ebx                     ; Se multiplica eax por ebx
    pop     edx                     ; Se saca edx del stack
    add     eax, edx                ; Se suma eax más edx
    mov     ebx, eax                ; Se mueve eax a ebx
    pop     eax                     ; Se saca eax (el inicial) del stack
    jmp     decryptImageAux4        ; Se salta a la función auxiliar 4
    
decryptImageExit:
    ret                             ; Se retorna de la función