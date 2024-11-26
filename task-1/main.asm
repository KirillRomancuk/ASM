MODEL SMALL
.STACK 100H
.DATA
    WH   DB 'Initial commit$'
.CODE
    MAIN:
         MOV AX, @DATA
         MOV DS, AX
         LEA DX, WH
         MOV AH, 09H
         INT 21H
         MOV AH, 4CH
         INT 21H
END MAIN
