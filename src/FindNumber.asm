section .text

findNumber:
    push    ebx                     ; Se respalda el valor de ebx en el stack
    jmp     findNumberAux           ; Se ejecuta la primer parte de la función
    
findNumberAux:
    mov     dl, byte [ebx + ecx]    ; Se carga el dato que se encuentra en la posición de memoria que apunta ebx más el offset de ecx
    cmp     edx, 0                  ; Se compara el dato cargado con 0
    je      exitFindNumberAux       ; Si es 0, quiere decir que se terminó de leer, por lo que se ejecuta la función de salida
    cmp     edx, 48                 ; Se compara el dato cargado con 48 (0 en ASCII)
    jge     findNumberAux2          ; Si es dato cargado es mayor o igual a 48, podría ser un número, por lo que se ejecuta la siguiente función auxiliar
    inc     ecx                     ; Sino, se aumenta el Offset
    jmp     findNumberAux           ; Y se realiza un salto al inicio del loop, para analizar el siguiente dato
    
findNumberAux2:
    cmp     edx, 57                 ; Se compara el dato cargado con 57 (9 en ASCII)
    jle     findNumberAux3          ; En caso de que el dato sea menor o igual que 57, quiere decir que es un número, por lo que se ejecuta la siguiente función auxiliar
    inc     ecx                     ; Sino, se aumenta el Offset
    jmp     findNumberAux           ; Y se realiza un salto al inicio del loop, para analizar el siguiente dato
    
findNumberAux3:
    sub     edx, 48                 ; Se le resta 48 al dato cargado, con esto se obtiene el valor numérico del dato
    mov     ebx, 10                 ; Se mueve un 10 en ebx
    push    edx                     ; Se respalda edx en el stack, ya que este es influenciado por la operación de MUL
    mul     ebx                     ; Se multiplica eax por ebx
    pop     edx                     ; Se carga el dato respaldado de edx del stack
    add     eax, edx                ; Se suma eax con edx, eax es el número que se va generando, edx es el número leído
    inc     ecx                     ; Se incrementa el Offset
    pop     ebx                     ; Se carga el dato respaldado anteriormente en ebx del stack
    jmp     findNumberAux4          ; Se ejecuta la siguiente parte de la función
    
findNumberAux4:
    mov     dl, byte [ebx + ecx]    ; Se carga el siguiente dato a analizar en edx
    push    ebx                     ; Se respalda el dato de ebx en el stack
    cmp     edx, 48                 ; Se compara edx con 48
    jge     findNumberAux5          ; En caso de ser mayor o igual, se ejecuta la siguiente función auxiliar
    inc     ecx                     ; Sino, se incrementa el Offset
    jmp     exitFindNumber          ; Se ejecuta la salida de la función
    
findNumberAux5:
    cmp     edx, 57                 ; Se compara edx con 57
    jle     findNumberAux3          ; Si es menor o igual, se ejecuta nuevamente el algoritmo para determinar el número equivalente del ASCII
    inc     ecx                     ; Sino, se incrementa el Offset
    jmp     exitFindNumber          ; Se ejecuta la salida de la función
    
exitFindNumber:
    pop     ebx                     ; Se carga el dato respaldado de ebx del stack
    ret                             ; Se retorna de la función
    
exitFindNumberAux:
    mov     edx, 1                  ; Se carga un 1 a edx para indicar que se llegó al final del archivo
    jmp     exitFindNumber          ; Se ejecuta la función de la salida´