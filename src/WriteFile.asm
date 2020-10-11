section .text

writeImageFile:
    mov     ecx, 0777                   ; Se colocan todos los permisos del archivo (escritura, lectura y ejecución)
    mov     ebx, decImageFile           ; Se mueve la posición de memoria donde se almacena el nombre del archivo
    mov     eax, 8                      ; Se ejecuta SYS_CREATE
    int     80h                         ; Se llama el kernel
    mov     [dImageDescriptor], eax     ; Se almacena el descriptor de la imagen
    mov     edx, [decCont]              ; Se mueve la cantidad de bytes a escribit
    mov     ecx, decImage               ; Se mueve la posición de memoria con los datos a escribir
    mov     ebx, [dImageDescriptor]     ; Se almacena el descriptor de la imagen desencriptada
    mov     eax, 4                      ; Se ejecuta SYS_WRITE
    int     80h                         ; Se llama el kernel
    mov     ebx, [dImageDescriptor]     ; Se mueve la descripción del archivo abierto
    mov     eax, 6                      ; Se ejecuta SYS_CLOSE
    int     80h                         ; Se llama el kernel
    ret                                 ; Retorno de la función