.model small
.stack 100h 
.data
   value  db ?,'$'
   msg    db 'hello world','$'
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
                xor dx,dx
   ; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ; L1:          
   ;              mov ah,02h
   ;              mov dl,40
   ;              int 10h
   ;              mov dl,'|'
   ;              int 21h
   ;              inc dh
   ;              cmp dh,25
   ;              jne L1
   ; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                mov lowerx,0
                mov lowery,0
                mov upperx,40
                mov uppery,0
                mov dx,3fbh           ; Line Control Register
                mov al,10000000b      ;Set Divisor Latch Access
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
                mov dx , 3FDH         ; Line Status Register
                in  al , dx
                AND al , 1
                JZ  uptosend
                mov dx , 03F8H
                in  al , dx
                mov VALUE , al
                mov ah,al
                cmp ah,3dh
                jz  uptoexits3
                cmp al,10
                je  sus
                inc lowerx
                cmp lowerx,40
                jne print
   sus:         
                inc lowery
                mov lowerx,0
   print:       
                cmp lowery,24d
                jl prints
                mov ah,6d             ; function 6
                mov al,1d             ; scroll by 1 line
                mov bh,7d             ; normal video attribute
                mov ch,0d             ; upper left Y
                mov cl,0d             ; upper left X
                mov dh,24d            ; lower right Y
                mov dl,39d            ; lower right X
                int 10h
                dec lowery
                mov lowerx,0
                cmp uppery,24d
                jl prints
                mov ah,6d             ; function 6
                mov al,1d             ; scroll by 1 line
                mov bh,7d             ; normal video attribute
                mov ch,0d             ; upper left Y
                mov cl,41d             ; upper left X
                mov dh,24d            ; lower right Y
                mov dl,79d            ; lower right X
                int 10h
                dec uppery
                mov upperx,40
                jmp prints
                uptoexits3:jmp uptoexits2
               uptoreceive:jmp recieve
               uptosend: jmp send
   prints:      
                mov ah,02h
                mov dl,lowerx
                mov dh,lowery
                int 10h
                mov ah,09
                mov dx,offset value
                int 21h
   send:        
                mov dx , 3FDH         ; Line Status Register
                In  al , dx           ;Read Line Status
                AND al , 00100000b
                jz  uptoreceive
       
                mov ah,01h
                int 16h
                jz  uptoreceive
                mov ah,00h
                int 16h
                jmp row
   uptoexits2:  jmp uptoexits
   ;-------mov cursir
   row:         mov cx,ax
                cmp ah,1ch
                je  intro
                inc upperx
                cmp upperx,80
                jne print1
   intro:       inc uppery
                mov upperx,41
   print1:      
                cmp uppery,24d
                jl prints1
                mov ah,6d             ; function 6
                mov al,1d             ; scroll by 1 line
                mov bh,7d             ; normal video attribute
                mov ch,0d             ; upper left Y
                mov cl,41d            ; upper left X
                mov dh,24d            ; lower right Y
                mov dl,79d            ; lower right X
                int 10h
                dec uppery
                mov upperx,40
               cmp lowery,24d
                jl prints1
                mov ah,6d             ; function 6
                mov al,1d             ; scroll by 1 line
                mov bh,7d             ; normal video attribute
                mov ch,0d             ; upper left Y
                mov cl,0d             ; upper left X
                mov dh,24d            ; lower right Y
                mov dl,39d            ; lower right X
                int 10h
                dec lowery
                mov lowerx,0
   prints1:     
                mov ah,02h
                mov dl,upperx
                mov dh,uppery
                int 10h
                cmp cl,13
                je  su
                mov ah,02
                mov dl,cl
                int 21h
   ;--------------------------------
                jmp su
   uptoexits:   jmp exit
   su:          mov dx , 3F8H
                mov ax,cx             ; Transmit data register
                cmp ah,3dh
                jz  exits
                cmp ah,1ch
                je  ent
                jmp right_serial
   exits:       mov al,ah
   right_serial:
                out dx , al
                cmp al,3dh
                jz  exit
                jmp again
   ent:         
                mov al,10
                out dx,al
                mov al,13
                out dx,al
                jmp AGAIN
   exit:        
                mov ah,0
                mov al,3
                int 10h
                mov ah,4ch
                int 21h
                hlt
main endp
end main