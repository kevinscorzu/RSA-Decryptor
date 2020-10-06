section .text

fillDecryptedTable:
    mov     eax, 0                  ; Se mueve un 0 a eax para vaciarlo
    mov     ebx, 0                  ; Se mueve un 0 a ebx para vaciarlo
    mov     ecx, 1                  ; Se mueve un 1 a ecx, este es el contador de la cantidad de valores a aplicar el algoritmo de exponenciación modular
    mov     [RSACont], ecx          ; Se almacena el 1 en el contador
    mov     edx, 0                  ; Se mueve un 0 a edx para vaciarlo
    mov     [tableCont], edx        ; Se almacena un 0 al contador de la tabla, esta es la tabla donde se almacenarán los valores desencriptados
    jmp     fillDecryptedTableAux   ; Se salta a la función auxiliar
    
fillDecryptedTableAux:
    mov     ecx, [RSACont]          ; Se mueve el contador del número actual a aplicar el algoritmo a ecx
    cmp     ecx, 256                ; Si el contador es 256, se termina ya que 255 es el último número representable en 8 bits
    je      exitFillDecryptedTable  ; En caso de que sí sea 256, se salta a la función de salida
    mov     [b], ecx                ; Sino, se almacena el número actual del contador a b, este valor es la base del exponente
    call    RSADecryption           ; Se llama a la función de desencriptación de RSA
    call    fillTable               ; Se llama a la función para almacenar el valor desencriptado en la tabla, el valor se encuentra en eax
    mov     ecx, [RSACont]          ; Se mueve el contador nuevamente a ecx
    inc     ecx                     ; Se incrementa
    mov     [RSACont], ecx          ; Y se vuelve a almacenar
    jmp     fillDecryptedTableAux   ; Se devuelve al inicio del loop, para aplicar el algoritmo al siguiente valor
       
exitFillDecryptedTable:
    ret                             ; Se retorna de la función

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
    ret                             ; Se retorna de la función

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
    ret                             ; Se retorna de la función
    
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
    mov     eax, [e]                ; Se mueve e a eax
    mov     ecx, 2                  ; Se mueve un 2 a ecx
    mov     edx, 0                  ; Se limpia edx
    div     ecx                     ; Se divide eax (e) entre ecx (2)
    mov     [e], eax                ; Se almacena el resultado en e
    mov     eax, [b]                ; Se mueve b a eax
    mul     eax                     ; Se multiplica eax (b) por eax (b)
    mov     bx, [n]                 ; Se carga n a bx
    mov     edx, 0                  ; Se limpia edx
    div     ebx                     ; Se divide eax (b * b) entre n
    mov     [b], edx                ; Se almacena el residuo en b
    jmp     RSADecryptionAux2       ; Se retorna a la función auxiliar 2, el inicio del loop
    
fillTable:
    mov     ebx, [tableCont]        ; Se mueve el contador de la tabla a ebx
    mov     [decTable + ebx], ah    ; Se almacena el byte más significativo de los primeros 16 bits de eax a la posición de memoria designada en la tabla
    inc     ebx                     ; Se incrementa el contador
    mov     [decTable + ebx], al    ; Se almacena el byte menos significativo de los primeros 16 bits de eax a la posición de memoria designada en la tabla
    inc     ebx                     ; Se incrementa el contador
    mov     [tableCont], ebx        ; Se almacena el contador
    ret                             ; Se retorna de la función