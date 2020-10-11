section .text

searchTables:                 
    mov     ebx, 0                  ; Se mueve un 0 a ebx para vaciarlo
    mov     ecx, 0                  ; Se mueve un 0 a ecx para vaciarlo
    mov     edx, 0                  ; Se mueve un 0 a edx para vaciarlo
    jmp     searchTablesAux         ; Se salta a la función auxiliar
    
searchTablesAux:
    mov     bx, [encTable + ecx]    ; Se mueve el valor de la tabla encriptada encontrado a bx
    cmp     ebx, 0                  ; Se compara ebx con 0
    je      fillEncryptedTable      ; Si es 0, se salta a la función de llenar la tabla encriptada
    cmp     ebx, eax                ; Se compara ebx con eax
    je      searchTablesAux2        ; Si son iguales, se salta a la función auxiliar 2
    inc     ecx                     ; Sino, se incrementa ecx
    inc     ecx                     ; Se incrementa ecx
    jmp     searchTablesAux         ; Se salta al inicio del loop
    
searchTablesAux2:
    mov     eax, ecx                ; Se mueve ecx a eax
    shr     ecx, 1                  ; Se divide eax entre 2 y se almacena en ecx
    mov     al, [decTable + ecx]    ; Se mueve el valor desencriptado encontrado a eax
    ret                             ; Se retorna de la función

fillEncryptedTable:
    mov     [encTable + ecx], ax    ; Se almacena ax a la posición designada en la tabla encriptada
    mov     [b], eax                ; Se mueve eax a la variable b
    mov     eax, ecx                ; Se mueve ecx a eax
    shr     ecx, 1                  ; Se divide eax entre 2 y se almacena en ecx
    push    ecx                     ; Se almacena ecx en el stack
    jmp     RSADecryption           ; Se salta al algoritmo de desencripción

RSADecryption:
    mov     bx, [n]                 ; Se mueve el valor de n a bx, n es el módulo
    cmp     ebx, 1                  ; Se verifica si es 1
    je      RSADecryptionAux        ; En caso de serlo, se ejecuta la función auxiliar
    mov     eax, 1                  ; Sino, se mueve un 1 a eax
    mov     [r], eax                ; Se almacena eax en r, r es donde se guardará el resultado final
    mov     eax, [b]                ; Se mueve la base del exponente a eax
    mov     edx, 0                  ; Se mueve un 0 a edx para limpiarlo, ya que aquí se almacena el residuo de la operación div
    div     ebx                     ; Se divide eax (b) entre ebx (n)
    mov     [b], edx                ; Se almacena el residuo en b, osea esta será la nueva base
    mov     bx, [d]                 ; Se mueve el exponente d a dx
    mov     [e], ebx                ; Se almacena el exponente a e, esto es para no modificar el valor de d
    jmp     RSADecryptionAux2       ; Se salta a la segunda función auxiliar
    
RSADecryptionAux:
    mov     eax, 0                  ; Ya que n es 1, el resultado es 0, por lo que se almacena en eax
    jmp     fillDecryptedTable      ; Se salta a la función para llenar la tabla desencriptada
    
RSADecryptionAux2:
    mov     eax, [e]                ; Se mueve el exponente en eax
    cmp     eax, 0                  ; Se compara con 0
    jle     RSADecryptionAux3       ; Si es menor o igual que 0, se ejecuta la función auxiliar 3
    mov     ecx, 2                  ; Sino se mueve un 2 a ecx
    mov     edx, 0                  ; Y se limpia edx
    div     ecx                     ; Se divide eax (e) entre ecx (2)
    cmp     edx, 1                  ; Se compara edx (residuo) con 1
    je      RSADecryptionAux4       ; Si es 1 se ejecuta la función auxiliar 4
    jmp     RSADecryptionAux5       ; Sino, se ejecuta la función auxiliar 5
    
RSADecryptionAux3:
    mov     eax, [r]                ; Ya que e es menor o igual que 0, esto quiere decir que se encontró la respuesta, esta se almacena en eax
    jmp     fillDecryptedTable      ; Se salta a la función para llenar la tabla desencriptada
    
RSADecryptionAux4:
    mov     eax, [r]                ; Se mueve r a eax
    mov     ebx, [b]                ; Se mueve b a ebx
    mul     ebx                     ; Se multiplica eax (r) por ebx (b)
    mov     bx, [n]                 ; Se mueve n a bx
    mov     edx, 0                  ; Se limpia edx
    div     ebx                     ; Se divide eax (r * b) entre ebx (n)
    mov     [r], edx                ; Se almacena el residuo de la operación en r
    jmp     RSADecryptionAux5       ; Se salta a la función auxiliar 5
    
RSADecryptionAux5:
    mov     eax, [e]                ; Se mueve e a eax.
    shr     eax, 1                  ; Se divide eax entre 2 y se almacena en eax
    mov     [e], eax                ; Se almacena el resultado en e
    mov     eax, [b]                ; Se mueve b a eax
    mul     eax                     ; Se multiplica eax (b) por eax (b)
    mov     bx, [n]                 ; Se carga n a bx
    mov     edx, 0                  ; Se limpia edx
    div     ebx                     ; Se divide eax (b * b) entre n
    mov     [b], edx                ; Se almacena el residuo en b
    jmp     RSADecryptionAux2       ; Se retorna a la función auxiliar 2, el inicio del loop
    
fillDecryptedTable:
    pop     ecx                     ; Se saca ecx del stack
    mov     [decTable + ecx], al    ; Se mueve el valor desencriptado en la posición definida en la tabla
    ret                             ; Se retorna de la función