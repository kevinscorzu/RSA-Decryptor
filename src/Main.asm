%include "io.inc"
%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/FindNumber.asm"
%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/ReadFiles.asm"
%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/WriteFile.asm"
%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/Decryptor.asm"
%include "/home/skryfall/Desktop/Proyects/RSA-Decryptor/src/RSA.asm"
 
section .data
    encImageFile    db  'imagen.txt', 0h
    keyFile         db  'llaves.txt', 0h
    decImageFile    db  'imagenNueva.txt', 0h
    
section .bss
    imageDescriptor  resb    4
    keyDescriptor    resb    4
    dImageDescriptor resb    4
    encImage         resb    3000000
    key              resb    100
    d                resw    1
    n                resw    1
    decTable         resb    508
    decImage         resb    5000000
    imgCont          resd    1
    RSACont          resd    1
    tableCont        resd    1
    r                resd    1
    b                resd    1
    e                resd    1
   
section .text
    global  CMAIN
 
CMAIN:
    call    readImageFile       ; Se llama la función para leer el archivo de imagen
    call    readKeyFile         ; Se llama la función para leer el archivo de llaves
    call    findDAndN           ; Se llama la función para buscar d y n
    call    fillDecryptedTable
    ;call    decryptImage        ; Se llama la función para desencriptar la imagen
    ;call    writeImageFile
    call    testTable
    call    finish              ; Se llama la función de finalización
    
testTable:
    mov     eax, 0
    jmp     ttaux
    
ttaux:
    cmp     eax, 256
    je      exittt
    mov     ebx, 0
    mov     bh, [decTable + eax]
    inc     eax
    mov     bl, [decTable + eax]
    inc     eax
    PRINT_CHAR  'R'
    PRINT_CHAR  ':'
    PRINT_DEC   4, ebx
    NEWLINE
    jmp     ttaux
    
exittt:
    ret
    
findDAndN:
    mov     ebx, key            ; Se mueve la posición de memoria donde se encuentran los datos de la llave
    mov     eax, 0              ; Se mueve un 0 a eax para vaciarlo, este es el número encontrado
    mov     ecx, 0              ; Se mueve un 0 a ecx para vaciarlo, este es el Offset
    call    findNumber          ; Se llama la función para buscar un número, este será d
    mov     [d], ax             ; Se almacena el número encontrado en d
    mov     eax, 0              ; Se mueve un 0 a eax para vaciarlo, este es el número encontrado
    call    findNumber          ; Se llama la función para buscar un número, este será n
    mov     [n], ax             ; Se almacena el número encontrado en n
    mov     eax, 0
    mov     ax, [d]
    PRINT_DEC   4, eax
    NEWLINE
    mov     eax, 0
    mov     ax, [n]
    PRINT_DEC   4, eax
    NEWLINE
    ret                         ; Se retorna de la función
    
finish:
    mov     ebx, 0              ; Se indica que no se presentaron errores
    mov     eax, 1              ; Se ejecuta SYS_EXIT
    int     80h                 ; Se llama el kernel
    
    ret                         ; Retorno de la función