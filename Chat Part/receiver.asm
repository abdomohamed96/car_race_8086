.model small 
.data
value db ?,'$'
msg db 'hello world','$'
upperx db ?
uppery db ?
lowerx db ?
lowery db ?
.code
main proc far
mov ax,@data
;clear screen
mov ds,ax
mov ah,0
mov al,3
int 10h

;mov cursor
mov ah,02h
mov dl,0
mov dh,12
int 10h

mov cx,80
L1:
mov ah,02h
mov dl,'_'
int 21h
loop L1
mov lowerx,0
mov lowery,13
mov upperx,0
mov uppery,0
mov dx,3fbh 			; Line Control Register
mov al,10000000b		;Set Divisor Latch Access 
out dx,al
mov dx,3f8h			
mov al,0ch			
out dx,al
mov dx,3f9h
mov al,00h
out dx,al
mov dx,3fbh
mov al,00011011b
out dx,al

AGAIN: 

    recieve:
        cmp lowery,24
        jne recieve1
        cmp lowerx,79
         jne recieve1
               mov ah,6       ; function 6
                mov al,1        ; scroll by 1 line    
                mov bh,0       ; normal video attribute         
                mov ch,13       ; upper left Y
                mov cl,79        ; upper left X
                mov dh,24     ; lower right Y
                mov dl,0      ; lower right X 
                int 10h           
                mov lowerx,0
               mov lowery,13
       recieve1: mov dx , 3FDH		; Line Status Register
		in al , dx 
  		AND al , 1
  		JZ send  
        mov dx , 03F8H
  		in al , dx 
  		mov VALUE , al
        cmp al,10
        je sus
        inc lowerx
        cmp lowerx,80
        jne print
        sus :
        inc lowery
        mov lowerx,0
        print:
        mov ah,02h
        mov dl,lowerx
        mov dh,lowery
        int 10h
        mov ah,09
        mov dx,offset value
        int 21h
    send:
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		AND al , 00100000b
  		jz recieve
       
        mov ah,01h
        int 16h
        jz recieve
        mov ah,00h
        int 16h
        ;-------mov cursir
        mov cx,ax
        cmp ah,1ch
        je enter
        inc upperx
        cmp upperx,80
        jne print1
        enter:inc uppery
        mov upperx,0
      print1:
        mov ah,02h
        mov dl,upperx
        mov dh,uppery
        int 10h
        cmp cl,13
        je su
        mov ah,02
        mov dl,cl
        int 21h 
        ;--------------------------------
        su:mov dx , 3F8H
        mov ax,cx		; Transmit data register
  		cmp ah,01h
        jz exit
        cmp ah,1ch
        je ent
        out dx , al
  		jmp again
        ent:
        mov al,10
        out dx,al
        mov al,13   
        out dx,al
        jmp AGAIN
exit:
mov ah,4ch
int 21h
main endp
end main