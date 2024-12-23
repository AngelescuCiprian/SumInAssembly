.model small
.stack 100h
.data
    msj1 db "Introduceti primul numar",10,13,"$"
    msj2 db "Introduceti al doilea numar",10,13,"$"
    msj3 db "Suma celor 2 numere este",10,13,"$"


.code
;description
citireNumar PROC
    mov ax,@data
    mov ds,ax
    xor bx,bx
    push bx 
    mov cx,10
    citire:
        mov ah,01h
        int 21h
        cmp al,13
            je numarCitit
        sub al,48
        mov bl,al
        pop ax 
        mul cx
        add ax,bx
        push ax
        jmp citire
    numarCitit:
        pop ax
        ret
citireNumar ENDP 
;description
afisareNumar PROC
    mov bx,10
    xor cx,cx
    descompunere:
        xor dx,dx
        div bx 
        push dx
        inc cx
        cmp ax,0
            je afisare 
        jmp descompunere
    afisare:
        pop dx
        add dx,48
        mov ah,02h
        int 21h
    loop afisare
    ret
    
afisareNumar ENDP

    main:
    mov ax,@data
    mov ds,ax
    mesaj  MACRO msj 
        mov ah,09h
        lea dx,msj 
        int 21h

    ENDM
    mesaj msj1
    call citireNumar
    push ax 
    mesaj msj2
    call citireNumar
    xor bx,bx
    mov bx,ax 
    pop ax
    add ax,bx
    mov bx,ax
    mesaj msj3
    xor ax,ax
    mov ax,bx
    call afisareNumar
    
    mov ah,4ch
    int 21h
    end main 