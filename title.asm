extrn player1 : byte
extrn player2 : byte
extrn timer   : byte
extrn powerup_mes : byte
extrn score1      : byte
extrn score2  : byte
extrn score_mes   : byte
extrn powerup_mes : byte
extrn power1_val  : byte
extrn power2_val  : byte
public statusbar
.MODEL medium
.stack 64
.data 
run_mes               db           'Run Fast      ','$'         
slow_other_mes        db           'Slow Other    ','$'        
makeObs_mes            db          'Make Obstacle','$'        
avoidObs_mes           db          'Avoid Obstacle','$'   
empty_mes               db          '              ','$'
var1            db  02
var2            db  ?
.code 
statusbar proc far 
    mov ax,@Data
    mov ds, ax    
    ;Player1 Name
    ;move Cursor

    ;0 23
    ;0 34
    mov ah,02h 
    mov bh, 0      
    mov dx, 1202h
    INT 10h
    ;Display String 
    mov ah, 9
    mov dx, offset player1+2
    int 21h
            
    ;Player2 Name        
    mov ah,02h 
    mov bh, 0   
    mov dx, 1242h
    INT 10h
    mov ah, 9
    mov dx, offset player2+2
    int 21h       
    
    ;score1
    mov ah,02h 
    mov bh, 0   
    mov dx, 1302h
    INT 10h
    mov ah, 9
    mov dx, offset score_mes
    int 21h 
    ;score1 value
    mov ah,02h 
    mov bh, 0   
    mov dx, 1402h
    INT 10h
    
    mov bl, 100
    mov ah, 0
    mov al, score1
    div bl
    mov dl, al
    push ax
    add dl, 30h
    mov ah, 02h
    int 21h
    pop ax
    mov bl, 10
    mov al, ah
    mov ah, 0
    div bl
    mov dl, al
    push ax
    add dl, 30h
    mov ah, 02h
    int 21h
    pop ax
    mov dl, ah   
    add dl, 30h
    mov ah, 02h
    int 21h
    mov ah, 2
    mov dl, '%'
    int 21h
    
    ;score2
    mov ah,02h 
    mov bh, 0   
    mov dx, 1342h
    INT 10h
    mov ah, 9
    mov dx, offset score_mes
    int 21h 
    ;score2 value
    mov ah,02h 
    mov bh, 0   
    mov dx, 1442h
    INT 10h  
    mov bl, 100
    mov ah, 0
    mov al, score2
    div bl
    mov dl, al
    push ax
    add dl, 30h
    mov ah, 02h
    int 21h
    pop ax
    mov bl, 10
    mov al, ah
    mov ah, 0
    div bl
    mov dl, al
    push ax
    add dl, 30h
    mov ah,02h 
    mov bh, 0   
    int 21h
    pop ax
    mov dl, ah   
    add dl, 30h
    mov ah, 02h
    int 21h
    mov ah,02h 
    mov bh, 0   
    mov dl, '%'
    int 21h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;power1
    mov ah,02h 
    mov bh, 0   
    mov dx, 1502h
    INT 10h
    mov ah, 9
    mov dx, offset powerup_mes
    int 21h 
    ;score1 value 
    mov ah,02h 
    mov bh, 0   
    mov dx, 1602h
    INT 10h
    cmp power1_val, 1
    jz runfast1
    cmp power1_val, 2
    jz slowother1
    cmp power1_val, 3
    jz avoidobs1
    cmp power1_val, 4
    jz makeobs1
    jmp emp1   

runfast1: 
            mov dx, offset run_mes
            jmp cont1
slowother1:
            mov dx, offset slow_other_mes
            jmp cont1
avoidobs1: 
            mov dx, offset avoidObs_mes
            jmp cont1
makeobs1: 
            mov dx, offset makeObs_mes
            jmp cont1
emp1:       mov dx, offset empty_mes
            jmp cont1
cont1: 
    mov ah, 9
    int 21h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;power2

    mov ah,02h 
    mov bh, 0   
    mov dx, 1542h
    INT 10h
    mov ah, 9
    mov dx, offset powerup_mes
    int 21h 
    ;score1 value   
    mov ah,02h 
    mov bh, 0   
    mov dx, 1642h
    INT 10h
    cmp power2_val, 1
    jz runfast2
    cmp power2_val, 2
    jz slowother2
    cmp power2_val, 3
    jz avoidobs2
    cmp power2_val, 4
    jz makeobs2
    jmp emp2
runfast2: 
            mov dx, offset run_mes
            jmp cont2
slowother2:
            mov dx, offset slow_other_mes
            jmp cont2
avoidobs2: 
            mov dx, offset avoidObs_mes
            jmp cont2
makeobs2: 
            mov dx, offset makeObs_mes
            jmp cont2
emp2:       mov dx, offset empty_mes
            jmp cont2
cont2: 
    mov ah, 9
    int 21h
    ret

statusbar endp
end            


