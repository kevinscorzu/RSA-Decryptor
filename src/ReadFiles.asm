section .text

readImageFile:    
    mov     ecx, 0                  ; Se abre el archivo en modo solo lectura
    mov     ebx, encImageFile       ; Se mueve la posición de memoria donde se almacena el nombre del archivo
    mov     eax, 5                  ; Se ejecuta SYS_OPEN
    int     80h                     ; Se llama el kernel
    mov     [imageDescriptor], eax  ; Se almacena el descriptor de la imagen
    mov     edx, 3000000            ; Cantidad de bytes a leer del archivo, esto es un byte por cada carácter
    mov     ecx, encImage           ; Se mueve la posición de memoria donde se almacenarán los datos leídos del txt
    mov     ebx, [imageDescriptor]  ; Se mueve el descriptor del archivo abierto
    mov     eax, 3                  ; Se ejecuta SYS_READ
    int     80h                     ; Se llama el kernel
    mov     ebx, [imageDescriptor]  ; Se mueve la descripción del archivo abierto
    mov     eax, 6                  ; Se ejecuta SYS_CLOSE
    int     80h                     ; Se llama el kernel
    ret                             ; Retorno de la función
    
readKeyFile:
    mov     ecx, 0                  ; Se abre el archivo en modo solo lectura
    mov     ebx, keyFile            ; Se mueve la posición de memoria donde se almacena el nombre del archivo
    mov     eax, 5                  ; Se ejecuta SYS_OPEN
    int     80h                     ; Se llama el kernel
    mov     [keyDescriptor], eax    ; Se almacena el descriptor de la llave
    mov     edx, 100                ; Cantidad de bytes a leer del archivo, esto es un byte por cada carácter
    mov     ecx, key                ; Se mueve la posición de memoria donde se almacenarán los datos leídos del txt
    mov     ebx, [keyDescriptor]    ; Se mueve la descripción del archivo abierto
    mov     eax, 3                  ; Se ejecuta SYS_READ
    int     80h                     ; Se llama el kernel
    mov     ebx, [keyDescriptor]    ; Se mueve la descripción del archivo abierto
    mov     eax, 6                  ; Se ejecuta SYS_CLOSE
    int     80h                     ; Se llama el kernel
    ret                             ; Retorno de la función