extrn player1:byte
extrn player2:byte
extrn mode:byte
public welcome_screen1,welcome_screen2,second_screen
.model small
.stack 64
.data
Message  db 'Please ','Enter ','your ','name:','$'
Message2 db 'Press ','Enter ','Key ','to ','continue:','$'
Message3 db 'To start  Chatting Press F1$'
Message4 db 'To start  the game Press F2$'
Message5 db 'To end  the program Press ESC$'

.code
 welcome_screen1 proc far
    ;  mov ah,0
    ; mov al,3
    ; int 10h
;-------------------move the cursor----------------
; dl-> col, dh ->row
    mov ah,02
    mov dl,0h
    mov dh,02h
    int 10h
;--------------printing the first string------------
    mov ah,09
    mov dx,offset Message
    int 21h
;====================The second string===============
    mov ah,02
    mov dh,10
    mov dl,00h
    int 10h
;-----------------printing the second string--------
    mov ah,09
    mov dx,offset Message2
    int 21h
;===================================================
    mov ah,2
    mov dh,03
    mov dl,00h
    int 10h
;------------- waiting for input -------------
    mov ah,0ah
    mov dx,offset player1
    int 21h 
;-------------------------------------------
    mov ah,2
    mov dh,07
    mov dl,00h
    int 10h
;---------------------------------------------
    ret
 welcome_screen1 endp
 welcome_screen2 proc far
  ;  mov ah,0
    ; mov al,3
    ; int 10h
;-------------------move the cursor----------------
; dl-> col, dh ->row
    mov ah,02
    mov dl,2
    mov dh,02
    int 10h
;--------------printing the first string------------
    mov ah,09
    mov dx,offset Message
    int 21h
;====================The second string===============
    mov ah,02
    mov dh,10
    mov dl,00h
    int 10h
;-----------------printing the second string--------
    mov ah,09
    mov dx,offset Message2
    int 21h
;===================================================
    mov ah,2
    mov dh,3
    mov dl,00h
    int 10h
;------------- waiting for input -------------
    mov ah,0ah
    mov dx,offset player2
    int 21h 
;-------------------------------------------
    mov ah,2
    mov dh,7
    mov dl,00h
    int 10h
;---------------------------------------------
    ret
 welcome_screen2 endp 
second_screen proc far
    mov ax,3
    int 10h
    mov ah,02
    mov dl,30
    mov dh,8
    int 10h
    mov ah,9
    mov dx,offset Message3
    int 21h
    mov ah,02
    mov dl,30
    mov dh,12
    int 10h
    mov ah,9
    mov dx,offset Message4
    int 21h
    mov ah,02
    mov dl,30
    mov dh,16
    int 10h
    mov ah,9
    mov dx,offset Message5
    int 21h
    mov ah,00
    la:int 16h
    jz la
    cmp ah,1
    mov mode,0
    jz retire
    cmp ah,59
    mov mode,1
    jz retire
    cmp ah,60
    mov mode,2
    retire:
    mov ah,01
    int 16h
    ret
second_screen endp  
end