section .text

writeImageFile:
    mov     ecx, 0777           ; code continues from lesson 22
    mov     ebx, decImageFile
    mov     eax, 8
    int     80h
    
    mov     [dImageDescriptor], eax  ; Se almacena el descriptor de la imagen
 
    mov     edx, [decCont]             ; number of bytes to write - one for each letter of our contents string
    mov     ecx, decImage       ; move the memory address of our contents string into ecx
    mov     ebx, [dImageDescriptor]            ; move the file descriptor of the file we created into ebx
    mov     eax, 4              ; invoke SYS_WRITE (kernel opcode 4)
    int     80h                 ; call the kernel
    
    mov     ebx, [dImageDescriptor]  ; Se mueve la descripción del archivo abierto
    mov     eax, 6                  ; Se ejecuta SYS_CLOSE
    int     80h                     ; Se llama el kernel
    
    ret