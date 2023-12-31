extrn    temp_ax               :word           
extrn    posxs1                :word           
extrn    posxe1                :word           
extrn    posys1                :word           
extrn    posye1                :word           
extrn    posxs2                :word           
extrn    posxe2                :word           
extrn    posys2                :word           
extrn    posye2                :word           
extrn    temp_posxs1           :word           
extrn    temp_posxe1           :word           
extrn    temp_posys1           :word           
extrn    temp_posye1           :word           
extrn    temp_posxs2           :word           
extrn    temp_posxe2           :word           
extrn    temp_posys2           :word           
extrn    temp_posye2           :word           
extrn    up_pressed_or_not     :byte           
extrn    down_pressed_or_not :byte 
extrn    right_pressed_or_not :byte 
extrn    left_pressed_or_not :byte 
extrn    w_pressed_or_not :byte 
extrn    d_pressed_or_not :byte 
extrn    s_pressed_or_not :byte 
extrn    a_pressed_or_not :byte 
extrn    color    :byte 
extrn    current_flag :word 
extrn    msg             :byte  
extrn    cur_row         :word  
extrn    cur_col         :word  
extrn    new_row         :word  
extrn    new_col         :word  
extrn    rand_dir        :byte  
extrn    rand_dist       :byte  
extrn    valid_left      :word  
extrn    valid_right     :word  
extrn    valid_down      :word  
extrn    valid_up        :word  
extrn    LAST_COL        :word  
extrn    LAST_ROW        :word  
extrn    photoFilename   :byte 
extrn    remaining_time  :byte 
;extrn   ; finallinename   :byte  'final_line.bin', 0
extrn    photoFilehandle :word  
;extrn    ;finallinehandle :word  e
; extrn winner:byte
extrn    FIRST_COL       :word  
extrn    FIRST_ROW       :word  
extrn    photoData       :byte  
extrn    is_col          :byte   
extrn    CARFLAG1        :byte           
extrn    CARFLAG2        :byte           
extrn    POWER1          :word          
extrn    POWER2          :word
extrn    slow1           :word           
extrn    slow2           :word           
extrn    is_powered1     :byte          
extrn    is_powered2     :byte
extrn    skipobstacle2   :byte 
extrn    skipobstacle1   :byte 
extrn    canskipobstacle2:byte 
extrn    canskipobstacle1:byte 
extrn    maketrap1       :byte 
extrn    maketrap2       :byte
extrn power1_val         :byte
extrn power2_val         :byte
extrn hitPowerup_x       :byte 
extrn hitPowerup_y       :byte
extrn currentDir1        :byte
extrn currentDir2        :byte
extrn powerupclr1        :byte
extrn powerupclr2        :byte
extrn game_over          :byte
extrn timer_minute       :byte
extrn timer_second       :byte
extrn init_posxs1        :word
extrn init_posxe1        :word
extrn init_posys1        :word
extrn init_posye1        :word 
extrn init_posxs2        :word
extrn init_posxe2        :word
extrn init_posys2        :word
extrn init_posye2        :word
extrn statusbar:far
extrn timer_first:far
extrn calc_time:far
public WINNER,drawcar,current_press,check_color1,check_color2,drawrectangle1,drawrectangle2,takepower1,takepower2,takeslow1,takeslow2,takeobstaclepower1
public takeobstaclepower2,removemakingobs1,removemakingobs2,createtrap, GENERATERANDOMPOWERUPS
.model small
.stack 100h
.data
color1                equ          33h
color2                equ          44h
v1                    equ          3
v2                    equ          3   
ok                    db           0
power_val             db           1
powerup_posxs         dw           ?
powerup_posxe         dw           ?
powerup_posys         dw           ?
powerup_posye         dw           ?
WINNER                 db           0
.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DRAWRECTANGLE1 proc FAR  
    mov ah ,0ch
    MOV DX,posye1
    MOV CX,posxe1
    MOV AL,color
    AGAIN:DEC DX
    MOV CX,posxe1
    INCR:INT 10H
    DEC CX
    CMP CX,posxs1
    JNZ INCR
    CMP DX,posys1
    JNZ AGAIN
    ret
DRAWRECTANGLE1 ENDp
DRAWRECTANGLE2 proc FAR
    mov ah ,0ch
    MOV DX,posye2
    MOV CX,posxe2
    MOV AL,color
    AGAIN2:DEC DX
    MOV CX,posxe2
    INCR2:INT 10H
    DEC CX
    CMP CX,posxs2
    JNZ INCR2
    CMP DX,posys2
    JNZ AGAIN2
    ret
DRAWRECTANGLE2 ENDp
;-----------------------------------;
GENERATERANDOMPOWERUPS proc far
    ;mov si,0fh
Regenerate:     
    ;dec si
    mov ah, 2CH
    int 21H
    mov powerup_posxs, dx
    mov ah, 2CH
    int 21H
    ;mov dh, 0
    mov powerup_posys, dx
    mov  ax, powerup_posxs
    mov powerup_posxe,ax
    add powerup_posxe, 5
    mov  ax, powerup_posys
    mov powerup_posye,ax
    add powerup_posye, 5   
    ;cmp si, 0
    ;jz rr2

    MOV AH,0DH
    MOV DX,powerup_posxs
    MOV cX,powerup_posys
    INT 10H 
    CMP AL,1Bh
    jnz Regenerate
    MOV AH,0DH 
    MOV DX,powerup_posxe
    MOV cX,powerup_posye
    INT 10H 
    CMP AL,1Bh
    jnz Regenerate

    MOV AH,0DH
    MOV DX,powerup_posxs
    MOV cX,powerup_posye
    INT 10H 
    CMP AL,1Bh
    jnz Regenerate
    MOV AH,0DH 
    MOV DX,powerup_posxe
    MOV cX,powerup_posys
    INT 10H 
    CMP AL,1Bh
    jnz Regenerate

    mov ax,posxs1
    mov temp_posxs1,ax
    mov ax,posxe1
    mov temp_posxe1,ax
    mov ax,posys1
    mov temp_posys1,ax
    mov ax,posye1
    mov temp_posye1,ax
     
    mov ax,powerup_posxs
    mov posxs1,ax
    mov ax,powerup_posxe
    mov posxe1,ax
    mov ax,powerup_posys
    mov posys1,ax
    mov ax,powerup_posye
    mov posye1,ax

    mov ah, 2CH
    int 21H
    mov ah, 0
    mov al, dl
    mov bl, 4
    div bl
    mov power_val, ah
    inc power_val
    cmp power_val, 1
    jz  runquick
    cmp power_val, 2
    jz  slowtheother
    cmp power_val, 3
    jz avoidobstacle
    cmp power_val, 4
    jz makeobstacle
rr2: jmp uptorr2
    runquick: 
        mov color, 55h
        jmp cc
    slowtheother:
        mov color, 66h
        jmp cc
    avoidobstacle:
        mov color, 73h
        jmp cc
    makeobstacle:
        mov color, 50h
        jmp cc
cc:
    call DRAWRECTANGLE1
    mov ax,temp_posxs1
    mov posxs1,ax
    mov ax,temp_posxe1
    mov posxe1,ax
    mov ax,temp_posys1
    mov posys1,ax
    mov ax,temp_posye1
    mov posye1,ax
uptorr2: 
    ret
GENERATERANDOMPOWERUPS endp
;-----------------------------------;
REMOVEPOWERUP1 proc FAR  
    mov ax,posxs1
    mov temp_posxs1,ax
    mov ax,posxe1
    mov temp_posxe1,ax
    mov ax,posys1
    mov temp_posys1,ax
    mov ax,posye1
    mov temp_posye1,ax
    
    cmp power1_val, 1
    jz  runquick1
    cmp power1_val, 2
    jz  slowtheother1
    cmp power1_val, 3
    jz avoidobstacle1
    cmp power1_val, 4
    jz makeobstacle1

    runquick1: 
        mov powerupclr1, 55h
        jmp c
    slowtheother1:
        mov powerupclr1, 66h
        jmp c
    avoidobstacle1:
        mov powerupclr1, 73h
        jmp c
    makeobstacle1:
        mov powerupclr1, 50h
        jmp c
c:
    push ax
    sub posxs1, 7d
    sub posys1, 7d
    add posxe1, 7d
    add posye1, 7d
    pop ax
    jmp con
con:

    mov ah ,0ch
    MOV DX,posye1
    MOV CX,posxe1
    MOV AL,1Bh
    AG1:DEC DX
    MOV CX,posxe1
    INCRE1:
    push ax
    push cx
    push dx
    MOV AH,0DH 

    INT 10h 
    cmp al, powerupclr1
    pop dx
    pop cx
    pop ax
    jnz contin

    INT 10H
contin:
    DEC CX
    CMP CX,posxs1
    JNZ INCRE1
    CMP DX,posys1
    JNZ AG1


    mov ax,temp_posxs1
    mov posxs1,ax
    mov ax,temp_posxe1
    mov posxe1,ax
    mov ax,temp_posys1
    mov posys1,ax
    mov ax,temp_posye1
    mov posye1,ax
    ret
REMOVEPOWERUP1 ENDp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

REMOVEPOWERUP2 proc FAR  
    mov ax,posxs2
    mov temp_posxs2,ax
    mov ax,posxe2
    mov temp_posxe2,ax
    mov ax,posys2
    mov temp_posys2,ax
    mov ax,posye2
    mov temp_posye2,ax
    
    cmp power2_val, 1
    jz  runquick2
    cmp power2_val, 2
    jz  slowtheother2
    cmp power2_val, 3
    jz avoidobstacle2
    cmp power2_val, 4
    jz makeobstacle2

    runquick2: 
        mov powerupclr2, 55h
        jmp c2
    slowtheother2:
        mov powerupclr2, 66h
        jmp c2
    avoidobstacle2:
        mov powerupclr2, 73h
        jmp c2
    makeobstacle2:
        mov powerupclr2, 50h
        jmp c2
c2:
    push ax
    sub posxs2, 7d
    sub posys2, 7d
    add posxe2, 7d
    add posye2, 7d
    pop ax
    jmp con2
con2:

    mov ah ,0ch
    MOV DX,posye2
    MOV CX,posxe2
    MOV AL,1Bh
    AG2:DEC DX
    MOV CX,posxe2
    INCRE2:
    push ax
    push cx
    push dx
    MOV AH,0DH 
  
    INT 10h 
    cmp al, powerupclr2
    pop dx
    pop cx
    pop ax
    jnz contin2

    INT 10H
contin2:
    DEC CX
    CMP CX,posxs2
    JNZ INCRE2
    CMP DX,posys2
    JNZ AG2


    mov ax,temp_posxs2
    mov posxs2,ax
    mov ax,temp_posxe2
    mov posxe2,ax
    mov ax,temp_posys2
    mov posys2,ax
    mov ax,temp_posye2
    mov posye2,ax
    ret
REMOVEPOWERUP2 ENDp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TAKEPOWER1 PROC FAR
    mov power1_val, 1
    call REMOVEPOWERUP1
 
    call statusbar
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    RET
TAKEPOWER1 ENDP
TAKEPOWER2 PROC FAR
    mov power2_val, 1
    call REMOVEPOWERUP2
    call statusbar
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    RET
TAKEPOWER2 ENDP
TAKESLOW1 PROC FAR
 mov power1_val, 2
    call REMOVEPOWERUP1
    call statusbar
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    RET
TAKESLOW1 ENDP
TAKESLOW2 PROC FAR
    mov power2_val, 2
    call REMOVEPOWERUP2
    call statusbar
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    RET
TAKESLOW2 ENDP
TAKEOBSTACLEPOWER1 PROC FAR

    mov power1_val, 3
    call REMOVEPOWERUP2
    call statusbar
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    RET
TAKEOBSTACLEPOWER1 ENDP
TAKEOBSTACLEPOWER2 PROC FAR
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov power2_val, 3
    call REMOVEPOWERUP2
    call statusbar
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    RET
TAKEOBSTACLEPOWER2 ENDP


removemakingobs1 PROC far

    mov power1_val, 4
    call REMOVEPOWERUP1
    call statusbar
    RET
removemakingobs1 ENDP

removemakingobs2 PROC far
    mov power2_val, 4
    call REMOVEPOWERUP2
    call statusbar
    RET
removemakingobs2 ENDP

createtrap proc far
    mov ax,posxs1
    mov temp_posxs1,ax
    mov ax,posxe1
    mov temp_posxe1,ax
    mov ax,posys1
    mov temp_posys1,ax
    mov ax,posye1
    mov temp_posye1,ax
    cmp maketrap1,1
    jnz down_to_checktrap2
    mov maketrap1,0
    cmp up_pressed_or_not,1
    jnz checkdown1
    add posys1,10
    add posye1,10
checkdown1:
    cmp down_pressed_or_not,1
    jnz checkright1
    sub posys1,10
    sub posye1,10
checkright1:
    jmp bridge7
    down_to_checktrap2:
    jmp checktrap2
bridge7:
    cmp right_pressed_or_not,1
    jnz checkleft1
    sub posxs1,10
    sub posxe1,10
checkleft1:
    cmp left_pressed_or_not,1
    jnz cannotmaketrap1
    add posxs1,10
    add posxe1,10
cannotmaketrap1:
    mov color,22h
    call DRAWRECTANGLE1
    mov ax,temp_posxs1
    mov posxs1,ax
    mov ax,temp_posxe1
    mov posxe1,ax
    mov ax,temp_posys1
    mov posys1,ax
    mov ax,temp_posye1
    mov posye1,ax
    mov color,color1
    call DRAWRECTANGLE1
checktrap2:
    mov ax,posxs2
    mov temp_posxs2,ax
    mov ax,posxe2
    mov temp_posxe2,ax
    mov ax,posys2
    mov temp_posys2,ax
    mov ax,posye2
    mov temp_posye2,ax
    cmp maketrap2,1
    jnz cannotmaketrap2
    mov maketrap2,0    
    cmp w_pressed_or_not,1
    jnz checkdown2
    add posys2,10
    add posye2,10
    checkdown2:
    cmp s_pressed_or_not,1
    jnz checkright2
    sub posys2,10
    sub posye2,10
    checkright2:
    cmp d_pressed_or_not,1
    jnz checkleft2
    sub posxs2,10
    sub posxe2,10
checkleft2:
    cmp a_pressed_or_not,1
    jnz cannotmaketrap2
    add posxs2,10
    add posxe2,10
cannotmaketrap2:
    mov color,22h
    call DRAWRECTANGLE2
    mov ax,temp_posxs2
    mov posxs2,ax
    mov ax,temp_posxe2
    mov posxe2,ax
    mov ax,temp_posys2
    mov posys2,ax
    mov ax,temp_posye2
    mov posye2,ax
    mov color,color2
    call DRAWRECTANGLE2
ret
createtrap endp
current_press proc far
    cli
    in al ,60h
    cmp al,48h ; 48h UP KEy
    jnz up1_not_pressed
    mov current_flag,01h
    jmp return_press
    up1_not_pressed:
    cmp al,48h+80h
    jnz up1_not_released
    mov current_flag,02h
    jmp return_press
    up1_not_released:

cmp al,50h  ; 50h down key
    jnz dwn1_not_pressed                
    mov current_flag,04h
    jmp return_press
    dwn1_not_pressed:
    cmp al,50h+80h
    jnz dwn1_not_released
    mov current_flag,08h
    jmp return_press
    dwn1_not_released:
cmp al,4Bh  ; 4Bh left key
    jnz left1_not_pressed
    mov current_flag,10h
    jmp return_press
    left1_not_pressed:
    cmp al,4Bh+80h
    jnz left1_not_released
    mov current_flag,20h
    jmp return_press
    left1_not_released:

cmp al,4Dh  ; 4Dh right key
    jnz right1_not_pressed
    mov current_flag,40h
    jmp return_press
    right1_not_pressed:
    cmp al,4Dh+80h
    jnz right1_not_released
    mov current_flag,80h
    jmp return_press
    right1_not_released:
cmp al,11h ; 11h W KEy  
    jnz up2_not_pressed
    mov current_flag,100h
    jmp return_press
    up2_not_pressed:
    cmp al,11h+80h
    jnz up2_not_released
    mov current_flag,200h
    jmp return_press
    up2_not_released:

cmp al,1fh  ; 1fh S key
    jnz dwn2_not_pressed
    mov current_flag,400h
    jmp return_press
    dwn2_not_pressed:
    cmp al,1fh+80h
    jnz dwn2_not_released
    mov current_flag,800h
    jmp return_press
    dwn2_not_released:

cmp al,1eh  ; 1eh A key
    jnz left2_not_pressed
    mov current_flag,1000h
    jmp return_press
    left2_not_pressed:
    cmp al,1eh+80h
    jnz left2_not_released
    mov current_flag,2000h
    jmp return_press
    left2_not_released:

cmp al,20h  ; 20h D key
    jnz right2_not_pressed
    mov current_flag,4000h
    jmp return_press
    right2_not_pressed:
    cmp al,20h+80h
    jnz right2_not_released
    mov current_flag,8000h     
    jmp return_press
    right2_not_released:

cmp al,26h ;L key
    jnz l_not_pressed
    cmp is_powered2,4
    jz  createtrap2
    cmp is_powered2,3
    jz  takeobpower2
    cmp is_powered2,2
    jz slowahmad2
    cmp is_powered2,1
    jz powerali2
    jmp return_press
    createtrap2:
    mov maketrap2,1
    mov is_powered2,0
    mov power2_val, 10h 

    call createtrap
    jmp return_press
    takeobpower2:
    mov canskipobstacle2,1
    mov is_powered2,0
    mov power2_val, 10h
    jmp return_press
    slowahmad2:
    mov slow1,0ffh
    mov is_powered2,0
    mov power2_val, 10h
    jmp return_press
    powerali2:
    mov power2,0ffh
    mov is_powered2,0
    mov power2_val, 10h
    l_not_pressed:
    cmp al,26h+80h
    jnz l_not_released
    jmp return_press
    l_not_released:

    cmp al,23h ;H key
    jnz h_not_pressed
    cmp is_powered1,4
    jz  createtrap1
    cmp is_powered1,3
    jz  takeobpower1
    cmp is_powered1,2
    jz slowahmad1
    cmp is_powered1,1
    jz powerali
    jmp return_press
    createtrap1:
    mov maketrap1,1
    mov is_powered1,0
    mov power1_val, 10h
    call createtrap
    jmp return_press
    takeobpower1:
    mov canskipobstacle1,1
    mov is_powered1,0
    mov power1_val, 10h
    jmp return_press
    slowahmad1:
    mov slow2,0ffh
    mov is_powered1,0
    mov power1_val, 10h
    jmp return_press
    powerali:
    mov power1,0ffh
    mov is_powered1,0
    mov power1_val, 10h
    h_not_pressed:
    cmp al,23h+80h
    jnz h_not_released
    jmp return_press
    h_not_released:
    cmp al,62
    jnz return_press
    mov game_over,1
    mov winner,3
return_press:
call statusbar
ret
current_press endp

CHECK_COLOR1 PROC far


    MOV AH,0DH 

     MOV AH,0DH 
    ;;ABDO
    MOV DX,posye1
    MOV cX,posxe1
    INT 10H
    CMP AL,5 
    JNE SECOND_P
    ;; NEEDED 
    MOV WINNER,1
    RET
    SECOND_P:
    ;;ABDO
    MOV DX,posys1
    MOV cX,posxs1
    INT 10H 
    ;;;ABDO
    CMP AL,5 
    JNE L
    MOV WINNER,1
    RET
    ;;;ABDO
    L:

    MOV DX,posys1
    MOV cX,posxs1
    INT 10H 
    CMP AL,50h
    JZ createob1
    CMP AL,22h
    JZ  HITOBSTACLE1
    CMP AL,55h
    jz POWERUP1
    CMP AL,66h
    jz SLOWDOWN1
    CMP AL,73h
    jz TAKEOBSTACLEPOW1
    CMP AL,44H
    JZ RETURNO
    CMP AL,00H
    JZ RETURNO
    MOV DX,posYE1
    mov CX,POSXS1
    INT 10H
    CMP AL,50h
    JZ createob1
    CMP AL,22h
    JZ  HITOBSTACLE1
    CMP AL,55h
    JZ POWERUP1
    CMP AL,66h
    jz SLOWDOWN1
    CMP AL,73h
    jz TAKEOBSTACLEPOW1
    CMP AL,44H
    JZ RETURNO
    CMP AL,00H
    JZ RETURNO
    MOV DX,posYS1
    mov CX,POSXE1
    jmp bridge5
    RETURNO:
    MOV CARFLAG1,0
    RET
    createob1:
    mov is_powered1,4
    call removemakingobs1
    ret
    POWERUP1:
    mov is_powered1,1
    CALL TAKEPOWER1
    RET
    SLOWDOWN1:
    MOV is_powered1,2
    call TAKESLOW1
    ret
    TAKEOBSTACLEPOW1:
    MOV is_powered1,3
    CALL TAKEOBSTACLEPOWER1
    RET
    HITOBSTACLE1:
    CMP canskipobstacle1,1
    JNZ CRACH1
    MOV skipobstacle1,1
    RET
    CRACH1:
    MOV CARFLAG1,0
    RET
    BRIDGE_FOR_RETURNO:
    JMP RETURNO
    bridge5:
    INT 10H
    CMP AL,50h
    JZ createob1
    CMP AL,22h
    JZ  HITOBSTACLE1
    CMP AL,55h
    JZ POWERUP1
    CMP AL,66h
    jz SLOWDOWN1
    CMP AL,73h
    jz TAKEOBSTACLEPOW1
    CMP AL,44H
    JZ BRIDGE_FOR_RETURNO
    CMP AL,00H
    JZ BRIDGE_FOR_RETURNO
    MOV DX,posyE1
    mov CX,POSXE1
    INT 10H
    CMP AL,50h
    JZ createob1
    CMP AL,22h
    JZ  HITOBSTACLE1
    CMP AL,55h
    JZ POWERUP1
    CMP AL,66h
    jz SLOWDOWN1
    CMP AL,73h
    jz TAKEOBSTACLEPOW1
    CMP AL,44H
    JZ BRIDGE_FOR_RETURNO
    CMP AL,00H
    JZ BRIDGE_FOR_RETURNO
    MOV CARFLAG1,1
    RET
    CHECK_COLOR1 ENDP
CHECK_COLOR2 PROC far
    MOV AH,0DH 

    ;;ABDO
    MOV DX,posye2
    MOV cX,posxe2
    INT 10H
    CMP AL,5 
    JNE SECOND_P1
    ;;DRAW GAME OVER PAGE WITH PLAYER TWO 
    MOV WINNER,2
    RET
    SECOND_P1:
    ;;ABDO
    MOV DX,posys2
    MOV cX,posxs2
    INT 10H 
    ;;;ABDO
    CMP AL,5 
    JNE L1
    MOV WINNER,2
    RET
    ;;;ABDO
    L1:
    ;;;ABDO

    MOV DX,posys2
    MOV cX,posxs2
    INT 10h 
    CMP AL,50h
    JZ createob2
    CMP AL,22h
    JZ  HITOBSTACLE2
    CMP AL,55h
    jz POWERUP2
    CMP AL,66h
    jz SLOWDOWN2
    CMP AL,73h
    jz TAKEOBSTACLEPOW2
    CMP AL,33H
    JZ RETURNO2
    CMP AL,00H
    JZ RETURNO2
    MOV DX,posYE2
    mov CX,POSXS2
    INT 10h
    CMP AL,50h
    JZ createob2
    CMP AL,22h
    JZ  HITOBSTACLE2
    CMP AL,55h
    JZ POWERUP2
    CMP AL,66h
    jz SLOWDOWN2
    CMP AL,73h
    jz TAKEOBSTACLEPOW2
    CMP AL,33H
    JZ RETURNO2
    CMP AL,00H
    JZ RETURNO2
    jmp bridge4
    REturno2:
    MOV CARFLAG2,0
    RET
    createob2:
    mov is_powered2,4
    call removemakingobs2
    ret
    POWERUP2:
    mov is_powered2,1
    CALL TAKEPOWER2
    RET
    SLOWDOWN2:
    MOV is_powered2,2
    call TAKESLOW2
    ret
    TAKEOBSTACLEPOW2:
    MOV is_powered2,3
    CALL TAKEOBSTACLEPOWER2
    RET
    HITOBSTACLE2:
    CMP canskipobstacle2,1
    JNZ CRACH2
    MOV skipobstacle2,1
    RET
    CRACH2:
    MOV CARFLAG2,0
    RET
    bridge4:
    MOV DX,posYS2
    mov CX,POSXE2
    INT 10h
    CMP AL,50h
    JZ createob2
    CMP AL,22h
    JZ  HITOBSTACLE2
    CMP AL,55h
    JZ POWERUP2
    CMP AL,66h
    jz SLOWDOWN2
    CMP AL,73h
    jz TAKEOBSTACLEPOW2
    CMP AL,33H
    JZ RETURNO2
     CMP AL,00H
    JZ RETURNO2
    MOV DX,posyE2
    mov CX,POSXE2
    INT 10h
    jmp bridge6
    bridge_for_RETURNO2:
    jmp RETURNO2
    bridge6:
    CMP AL,50h
    JZ createob2
    CMP AL,22h
    JZ  HITOBSTACLE2
    CMP AL,55h
    JZ POWERUP2
    CMP AL,66h
    jz SLOWDOWN2
    CMP AL,73h
    jz TAKEOBSTACLEPOW2
    CMP AL,33H
    JZ bridge_for_RETURNO2
    cmp al,00h
    jz bridge_for_returno2
    MOV CARFLAG2,1
    RET
    CHECK_COLOR2 ENDP
DRAWCAR proc FAR
mov    up_pressed_or_not    ,0
mov    down_pressed_or_not  ,0
mov    right_pressed_or_not ,0
mov    left_pressed_or_not  ,0
mov    w_pressed_or_not     ,0
mov    d_pressed_or_not     ,0
mov    s_pressed_or_not     ,0
mov    a_pressed_or_not     ,0
mov current_flag,0
mov is_powered1,0
mov is_powered2,0
mov power1_val,0
mov power2_val,0
mov    power1          ,0
mov    POWER2          ,0h
mov    slow1           , 0
mov    slow2           , 0
mov    is_powered1     , 0
mov    is_powered2     , 0
mov    skipobstacle2   , 0
mov    skipobstacle1   , 0
mov    canskipobstacle2, 0
mov    canskipobstacle1, 0
mov    maketrap1       , 0
mov    maketrap2       , 0
mov ax,init_posxe1
mov posxe1,ax
mov ax,init_posxs1
mov posxs1,ax
mov ax,init_posye1
mov posye1,ax
mov ax,init_posys1
mov posys1,ax
mov ax,init_posxe2
mov posxe2,ax
mov ax,init_posxs2
mov posxs2,ax
mov ax,init_posye2
mov posye2,ax
mov ax,init_posys2
mov posys2,ax
mov color,color1
call DRAWRECTANGLE1
mov color,color2
call DRAWRECTANGLE2  
    call timer_first
    agains:
    ;CHECK GAME OVER 
    ;if the time is zero return  
    CMP WINNER,0
    JE NEXTto
    RET
    NEXTto:
    mov cx,0ffffh
    koko:  
    loop koko
    call calc_time
    cmp remaining_time,0
    JNE NEXTto2
    RET
    nextto2:
    cmp timer_minute,0
    jnz pow
    cmp timer_second,0
    jz upto_exit_game6
    pow:cmp power1,0
    jle hops1
    dec power1
    hops1:
    cmp power2,0
    jle hops2
    dec power2
    hops2:
    cmp slow1,0
    jle hops3
    dec slow1
    hops3:
    cmp slow2,0
    jle hops4
    dec slow2
    hops4:
    call current_press
    jmp next2
    upto_exit_game6:jmp upto_exit_game5
    next2:
    cmp current_flag,01h
    jnz hop1
    mov up_pressed_or_not,01h
    jmp up1
    hop1:
    cmp current_flag,02h
    jnz hop2
    mov up_pressed_or_not ,0h;
    jmp up1
    hop2:
    cmp current_flag,04h
    jnz hop3
    mov down_pressed_or_not,01h
    jmp up1
    hop3:
    cmp current_flag,08h
    jnz hop4
    mov down_pressed_or_not,00h
    jmp up1
    hop4:
    cmp current_flag,10h
    jnz hop5
    mov left_pressed_or_not,01h
    jmp up1
    hop5:
    cmp current_flag,020h
    jnz hop6
    mov left_pressed_or_not,00h
    jmp up1
    hop6:
    cmp current_flag,040h
    jnz hop7
    mov right_pressed_or_not,01h
    jmp up1
    hop7:
    cmp current_flag,080h
    jnz hop8
    mov right_pressed_or_not,00h
    jmp up1
    jmp next
    up_to_agains1:
    jmp agains
    upto_exit_game5:jmp upto_exit_game4
    next:
    hop8:
    cmp current_flag,0100h
    jnz hop9
    mov w_pressed_or_not,01h
    jmp up1
    hop9:
    cmp current_flag,0200h
    jnz hop10
    mov w_pressed_or_not,00h
    jmp up1
    hop10:
    cmp current_flag,0400h
    jnz hop11
    mov s_pressed_or_not,01h
    jmp up1
    hop11:
    cmp current_flag,0800h
    jnz hop12
    mov s_pressed_or_not,00h
    jmp up1
    hop12:
    cmp current_flag,1000h
    jnz hop13
    mov a_pressed_or_not,01h
    jmp up1
    hop13:
    cmp current_flag,2000h
    jnz hop14
    mov a_pressed_or_not,00h
    jmp up1
    hop14:
    cmp current_flag,4000h
    jnz hop15
    mov d_pressed_or_not,01h
    jmp up1
    hop15:
    cmp current_flag,8000h
    jnz up_to_agains1
    mov d_pressed_or_not,00h
    jmp up1
    jmp ali2
    up_to_agains2:
    jmp up_to_agains1
    upto_exit_game4:jmp upto_exit_game3
    ali2:
    up1:
    ; mov currentDir1, 3
    cmp posys1,0
    jle down1  
    cmp up_pressed_or_not,01h
    jnz down1
    sub posys1,2
    sub posye1,2
    call CHECK_COLOR1
    add posys1,2
    add posye1,2
    cmp CARFLAG1,0h
    jz down1
    mov color ,1Bh
    call DRAWRECTANGLE1
    sub posys1,2
    sub posye1,2
    mov color ,color1
    cmp power1,0
    jle contdown1
    sub posys1,v1
    sub posye1,v1
    contdown1:
    cmp slow1,0
    jle contdown12
    add posys1,1
    add posye1,1
    contdown12:
    cmp skipobstacle1,1
    JNZ contdown123
    sub posys1,10
    sub posye1,10
    mov skipobstacle1,0
    mov canskipobstacle1,0
    contdown123:
    call DRAWRECTANGLE1
    down1:
    ; mov currentDir1, 4
    cmp posye1,199
    jge left1  
    cmp down_pressed_or_not,01h
    jnz left1
    add posys1,2
    add posye1,2
    call CHECK_COLOR1
    sub posys1,2
    sub posye1,2
    cmp CARFLAG1,0h
    jz left1
    mov color ,1Bh
    call DRAWRECTANGLE1
    add posys1,2
    add posye1,2
    mov color ,color1
    cmp power1,0
    jle contleft1
    add posys1,v1
    add posye1,v1
    contleft1:
    cmp slow1,0
    jle contleft12
    sub posys1,1
    sub posye1,1
    contleft12:
    cmp skipobstacle1,1
    JNZ contleft123
    add posys1,10
    add posye1,10
    mov skipobstacle1,0
    mov canskipobstacle1,0
    contleft123:
    call DRAWRECTANGLE1
    
    left1:
    ; mov currentDir1, 2
    cmp posxs1,0
    jle right1 
    cmp left_pressed_or_not,01h
    jnz right1
    sub posxs1,2
    sub posxe1,2
    call CHECK_COLOR1
    add posxs1,2
    add posxe1,2
    cmp CARFLAG1,0h
    jz right1
    mov color ,1Bh
    call DRAWRECTANGLE1
    sub posxs1,2
    sub posxe1,2
    mov color ,color1
    cmp power1,0
    jle contright1
    sub posxs1,v1
    sub posxe1,v1
    contright1:
    cmp slow1,0
    jle contright12
    add posxs1,1
    add posxe1,1
    contright12:
    cmp skipobstacle1,1
    JNZ contright123
    sub posxs1,10
    sub posxe1,10
    mov skipobstacle1,0
    mov canskipobstacle1,0
    contright123:
    call DRAWRECTANGLE1
    right1:
    ; mov currentDir1, 1
    cmp posxe1,319
    jge bridge_for_up2
    cmp right_pressed_or_not,01h
    jnz bridge_for_up2
    add posxs1,2
    add posxe1,2
    call CHECK_COLOR1
    sub posxs1,2
    sub posxe1,2
    cmp CARFLAG1,0h
    jz bridge_for_up2
    mov color ,1BH
    call DRAWRECTANGLE1
    add posxs1,2
    add posxe1,2
    mov color ,color1
    cmp power1,0
    jle contup2
    add posxs1,v1
    add posxe1,v1
    jmp bridge1
    bridge_for_up2:
    jmp up2
    bridge1:
    contup2:
    cmp slow1,0
    jle contup22
    sub posxs1,1
    sub posxe1,1
    contup22:
    cmp skipobstacle1,1
    JNZ contup223
    add posxs1,10
    add posxe1,10
    mov skipobstacle1,0
    mov canskipobstacle1,0
    contup223:
    call DRAWRECTANGLE1
    jmp ahmed
    up_to_agains3:
    jmp up_to_agains2
    upto_exit_game3:jmp upto_exit_game2
    ahmed:
    up2:
    ; mov currentDir2, 3
    cmp posys2,0
    jle down2
    cmp w_pressed_or_not,01h
    jnz down2
    sub posys2,2
    sub posye2,2
    call CHECK_COLOR2
    add posys2,2
    add posye2,2
    cmp CARFLAG2,0h
    jz down2
    mov color ,1BH
    call DRAWRECTANGLE2
    sub posys2,2
    sub posye2,2
    mov color ,color2
    cmp power2,0
    jle contdown2
    sub posys2,v2
    sub posye2,v2
    contdown2:
    cmp slow2,0
    jle contdown22
    add posys2,1
    add posye2,1
    contdown22:
    cmp skipobstacle2,1
    JNZ contdown223
    sub posys2,10
    sub posye2,10
    mov skipobstacle2,0
    mov canskipobstacle2,0
    contdown223:
    call DRAWRECTANGLE2
    down2:
    ; mov currentDir2, 4
    cmp posye2,199
    jge bridge_for_left2  
    cmp s_pressed_or_not,01h
    jnz bridge_for_left2
    add posys2,2
    add posye2,2
    call CHECK_COLOR2
    sub posys2,2
    sub posye2,2
    cmp CARFLAG2,0h
    jz bridge_for_left2
    mov color ,1BH
    call DRAWRECTANGLE2
    add posys2,2
    add posye2,2
    mov color ,color2
    cmp power2,0
    jle contleft2
    add posys2,v2
    add posye2,v2
    jmp bridge2
    bridge_for_left2:
    jmp left2
    bridge2:
    contleft2:
    cmp slow2,0
    jle contleft22
    sub posys2,1
    sub posye2,1
    contleft22:
    cmp skipobstacle2,1
    JNZ contleft223
    add posys2,10
    add posye2,10
    mov skipobstacle2,0
    mov canskipobstacle2,0
    contleft223:
    call DRAWRECTANGLE2
    jmp ahmed2
    up_to_agains4:
    jmp up_to_agains3
    upto_exit_game2:jmp upto_exit_game1
    ahmed2:
    left2:
    ; mov currentDir2, 2
    cmp posxs2,0
    jle bridge_for_right2
    cmp a_pressed_or_not,01h  
    jnz bridge_for_right2 
    sub posxs2,2
    sub posxe2,2
    call CHECK_COLOR2
    add posxs2,2
    add posxe2,2
    cmp CARFLAG2,0h
    jz bridge_for_right2
    mov color ,1BH
    call DRAWRECTANGLE2
    sub posxs2,2
    sub posxe2,2
    mov color ,color2
    cmp power2,0
    jle contright2
    sub posxs2,v2
    sub posxe2,v2
    jmp bridge3
    bridge_for_right2:
    jmp right2
    bridge3:
    contright2:
    cmp slow2,0
    jle contright22
    add posxs2,1
    add posxe2,1
    contright22:
    cmp skipobstacle2,1
    JNZ contright223
    sub posxs2,10
    sub posxe2,10
    mov skipobstacle2,0
    mov canskipobstacle2,0
    contright223:
    call DRAWRECTANGLE2
    jmp ahmed3
    up_to_agains5:
    jmp up_to_agains4
    upto_exit_game1:jmp exit_game
    ahmed3:
    right2:
    ; mov currentDir2, 1
    cmp posxe2,319
    jge up_to_agains5    
    cmp d_pressed_or_not,01h
    jnz up_to_agains5
    add posxs2,2
    add posxe2,2
    call CHECK_COLOR2
    sub posxs2,2
    sub posxe2,2
    cmp CARFLAG2,0h
    jz up_to_agains5
    mov color ,1BH
    call DRAWRECTANGLE2
    add posxs2,2
    add posxe2,2
    mov color ,color2
    cmp power2,0
    jle final
    add posxs2,v2
    add posxe2,v2
    final:
    cmp slow2,0
    jle final2
    sub posxs2,1
    sub posxe2,1
    final2:
    cmp skipobstacle2,1
    JNZ final23
    add posxs2,10
    add posxe2,10
    mov skipobstacle2,0
    mov canskipobstacle2,0
    final23:
    call DRAWRECTANGLE2
    jmp up_to_agains5
exit_game:
; sti
ret
DRAWCAR endp 

END