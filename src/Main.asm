;%include "io.inc"
;%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/FindNumber.asm"
;%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/ReadFiles.asm"
;%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/WriteFile.asm"
;%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/Decryptor.asm"
;%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/RSA.asm"

%include "FindNumber.asm"
%include "ReadFiles.asm"
%include "WriteFile.asm"
%include "Decryptor.asm"
%include "RSA.asm"
 
section .data
    encImageFile    db  'imagen.txt', 0h        ; Constante del nombre del archivo de la imagen encriptada
    keyFile         db  'llaves.txt', 0h        ; Constante del nombre del archivo de la llave privada
    decImageFile    db  'imagenNueva.txt', 0h   ; Constante del nombre del archivo de la imagen desencriptada
    
section .bss
    imageDescriptor  resb    4          ; Variable donde se almacena el descriptor del archivo de la imagen encriptada
    keyDescriptor    resb    4          ; Variable donde se almacena el descriptor del archivo de la llave privada
    dImageDescriptor resb    4          ; Variable donde se almacena el descriptor del archivo de la imagen desencriptada
    encImage         resb    3000000    ; Variable donde se almacena la imagen encriptada
    decImage         resb    6000000    ; Variable donde se almacena la imagen desencriptada
    key              resb    100        ; Variable donde se almacena la llave privada
    d                resw    1          ; Variable donde se almacena d de la llave privada
    n                resw    1          ; Variable donde se almacena n de la llave privada
    encTable         resb    510        ; Variable donde se encuentra la parte encriptada de la look up table
    decTable         resb    255        ; Variable donde se encuentra la parte desencriptada de la look up table
    decCont          resd    1          ; Contador utilizado para la imagen desencriptada
    encCont          resd    1          ; Contador utilizado para la imagen encriptada
    r                resd    1          ; Variable r donde se almacena el resultado de la operación módulo
    b                resd    1          ; Variable b donde se almacena la base de la operación módulo
    e                resd    1          ; Variable e donde se almacena el exponente de la operación módulo
    temp             resb    1          ; Variable de almacenamiento temporal
   
section .text
    global  _start
 
_start:
    call    readImageFile       ; Se llama la función para leer el archivo de imagen
    call    readKeyFile         ; Se llama la función para leer el archivo de llaves
    call    findDAndN           ; Se llama la función para buscar d y n
    call    decryptImage        ; Se llama la función para desencriptar la imagen
    call    writeImageFile      ; Se llama la función para escribir los datos desencriptados en un archivo
    call    finish              ; Se llama la función de finalización
   
findDAndN:
    mov     ebx, key            ; Se mueve la posición de memoria donde se encuentran los datos de la llave
    mov     eax, 0              ; Se mueve un 0 a eax para vaciarlo, este es el número encontrado
    mov     ecx, 0              ; Se mueve un 0 a ecx para vaciarlo, este es el Offset
    call    findNumber          ; Se llama la función para buscar un número, este será d
    mov     [d], ax             ; Se almacena el número encontrado en d
    mov     eax, 0              ; Se mueve un 0 a eax para vaciarlo, este es el número encontrado
    call    findNumber          ; Se llama la función para buscar un número, este será n
    mov     [n], ax             ; Se almacena el número encontrado en n
    ret                         ; Se retorna de la función
    
finish:
    mov     ebx, 0              ; Se indica que no se presentaron errores
    mov     eax, 1              ; Se ejecuta SYS_EXIT
    int     80h                 ; Se llama el kernel
    ret                         ; Retorno de la función