extrn first_second :byte
extrn first_minute :byte
extrn cur_minute   :byte
extrn cur_second   :byte
extrn timer_minute    :byte
extrn timer_second :byte
extrn GENERATERANDOMPOWERUPS:far
public timer_first, calc_time,remaining_time 
.MODEL medium
.stack 64
.data 
time_buffer            db      '00:00$';
var                    db       0   
remaining_time            db       ?
.code 
timer_first proc far
    
    MOV AH, 2CH	; CH=hour, CL=min, DH=sec
    INT 21H
    mov first_minute, cl
    mov first_second, dh    
    ret
timer_first endp
CONVERT PROC far
        XOR AH, AH
        MOV DL, 10                ;
        DIV DL		; AH has remainder, AL has quotient
        OR AX, 3030H	; convert to ASCII
        RET
CONVERT ENDP
calc_time proc  far
    MOV AH, 2CH	; CH=hour, CL=min, DH=sec
    INT 21H
    mov cur_minute, cl
    mov cur_second, dh 
    mov ax, @data
    mov ds, ax
    mov ah, 0      
    mov al, cur_minute 
    mov cl, 60
    mul cl
    mov dh, 0 
    mov dl, cur_second
    add  ax, dx 

    mov bx, ax
    mov ah, 0
    mov al, first_minute
    mul cl
    mov dh, 0 
    mov dl, first_second
    add  ax, dx 
    
    sub bx, ax 
    mov ah, 0
    mov al, 120
    sub al, bl 
    mov remaining_time,al 
    ;97
    div cl   ;rem = sec  quotint = min
    mov cx, ax
    mov timer_minute,cl
    mov timer_second,ch
    lea bx, time_buffer
    ; convert minutes into ASCII and store
        MOV AL, cl
        CALL CONVERT
        MOV [BX], AX
    ; convert seconds into ASCII and store
        MOV AL, ch
        CALL CONVERT
        MOV [BX+3], AX

       
        
        mov ah,02h 
        mov bh, 0          
        mov dl,15d  ; 0-23
        mov dh,20d ;  0-34
        int 10h 

        mov ah, 09h
        lea dx, time_buffer
        int 21h

        lea bx, time_buffer
        mov al, [BX+4]
        cmp al, '0'
        JZ r
        mov var, 0
        ret
        r:
            cmp var, 0
            jz l
            ret
        l:    
            mov var, 10d
            call GENERATERANDOMPOWERUPS
            
        ret
calc_time endp
end