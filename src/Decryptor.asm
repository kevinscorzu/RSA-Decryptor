%include "io.inc"
%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/Functions.asm"
 
section .data
    encImageFile    db  'imagen.txt', 0h
    keyFile         db  'llaves.txt', 0h
    
section .bss
    imageDescriptor  resb    4
    keyDescriptor    resb    4
    encImage         resb    2000000
    key              resb    100
    d                resb    2
    n                resb    2
   
section .text
    global  CMAIN
 
CMAIN:
    mov     ebp, esp            ; Para DEBUG
    call    readImageFile       ; Se llama la función para leer el archivo de imagen
    call    readKeyFile         ; Se llama la función para leer el archivo de llaves
    call    findDAndN           ; Se llama la función para buscar d y n
    call    finish              ; Se llama la función de finalización
    
readImageFile:    
    mov     ecx, 0              ; Se abre el archivo en modo solo lectura
    mov     ebx, encImageFile   ; Se mueve la posición de memoria donde se almacena el nombre del archivo
    mov     eax, 5              ; Se ejecuta SYS_OPEN
    int     80h                 ; Se llama el kernel
    
    mov     [imageDescriptor], eax  ; Se almacena el descriptor de la imagen
    
    mov     edx, 2000000        ; Cantidad de bytes a leer del archivo, esto es un byte por cada carácter
    mov     ecx, encImage       ; Se mueve la posición de memoria donde se almacenarán los datos leídos del txt
    mov     ebx, [imageDescriptor]  ; Se mueve el descriptor del archivo abierto
    mov     eax, 3              ; Se ejecuta SYS_READ
    int     80h                 ; Se llama el kernel
    
    mov     ebx, [imageDescriptor]  ; Se mueve la descripción del archivo abierto
    mov     eax, 6              ; Se ejecuta SYS_CLOSE
    int     80h                 ; Se llama el kernel
    
    ret                         ; Retorno de la función
    
readKeyFile:
    mov     ecx, 0              ; Se abre el archivo en modo solo lectura
    mov     ebx, keyFile        ; Se mueve la posición de memoria donde se almacena el nombre del archivo
    mov     eax, 5              ; Se ejecuta SYS_OPEN
    int     80h                 ; Se llama el kernel
    
    mov     [keyDescriptor], eax  ; Se almacena el descriptor de la llave
    
    mov     edx, 100            ; Cantidad de bytes a leer del archivo, esto es un byte por cada carácter
    mov     ecx, key            ; Se mueve la posición de memoria donde se almacenarán los datos leídos del txt
    mov     ebx, [keyDescriptor]            ; Se mueve la descripción del archivo abierto
    mov     eax, 3              ; Se ejecuta SYS_READ
    int     80h                 ; Se llama el kernel
    
    mov     ebx, [keyDescriptor]            ; Se mueve la descripción del archivo abierto
    mov     eax, 6              ; Se ejecuta SYS_CLOSE
    int     80h                 ; Se llama el kernel
    
    ret                         ; Retorno de la función
    
findDAndN:
    mov     ebx, key            ; Se mueve la posición de memoria donde se encuentran los datos de la llave
    mov     eax, 0
    mov     ecx, 0
    call    findNumber
    mov     [d], eax
    mov     eax, 0
    call    findNumber
    mov     [n], eax
    ret
    
findNumber:
    mov     dl, byte [ebx + ecx]
    push    ebx   
    cmp     edx, 32
    je      adjustOffset
    cmp     edx, 48
    jge     findNumberAux
    pop     ebx
    ret
    
findNumberAux:  
    cmp     edx, 57
    jle     findNumberAux2
    pop     ebx
    ret
    
findNumberAux2:
    sub     edx, 48
    mov     ebx, 10
    push    edx
    mul     ebx
    pop     edx
    add     eax, edx
    inc     ecx
    pop     ebx
    jmp     findNumber  
    
adjustOffset:
    pop     ebx
    jmp     adjustOffsetAux
    
adjustOffsetAux:
    inc     ecx
    mov     dl, byte [ebx + ecx]
    cmp     edx, 32
    je      adjustOffsetAux
    ret

finish:
    mov     ebx, 0              ; Se indica que no se presentaron errores
    mov     eax, 1              ; Se ejecuta SYS_EXIT
    int     80h                 ; Se llama el kernel
    
    ret                         ; Retorno de la función