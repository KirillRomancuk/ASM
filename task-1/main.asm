.MODEL SMALL
.STACK 100H

.DATA
    Message DB 13, 10, 'The end is just a little harder When brought about by friends! For all who cares this wine', \
' could be my blood! For all who cares this bread could be my body! The end! This is my blood you drink,', \
' this is my body you eat!', 13, 10, '$'

.CODE
    main:       
                mov ax, @DATA
                mov ds, ax
                mov es, ax
                mov bx, OFFSET Message
                add bx, 1

    iter:       
                add bx, 1
                mov al, [bx]
                cmp al, 40h               ; код 'A' - 1
                jbe nextword              ; если меньше или равно
                cmp al, 4Dh               ; код 'M'
                jbe print
                cmp al, 60h               ; код 'a' - 1
                jbe nextword
                cmp al, 6Dh               ; код 'm'
                jbe print
                jmp nextword

    print:      
                mov ah, 2
                mov dl, al
                int 21h
                cmp al, 20h               ; пробел
                jz  iter
                mov ah, 21h

    znaki:                                ; проверка на знаки
                cmp [bx + 1], ah
                jz  printprobel
                add ah, 1
                cmp ah, 30h
                jbe znaki
                add bx, 1
                mov al, [bx]
                cmp al, 13                ; конец строки
                jz  cancel
                jmp print

    nextword:   
                cmp al, 20h               ; пробел
                jz  iter
                add bx, 1
                mov al, [bx]
                cmp al, 13                ; конец строки
                jz  cancel
                jmp nextword

    printprobel:
                mov ah, 2
                mov dl, 20h
                int 21h
                jmp iter

    cancel:     
                mov ah, 2
                mov dl, 10
                int 21h
                mov ah, 4Ch
                int 21h

END main
