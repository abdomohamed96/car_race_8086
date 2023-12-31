
extrn msg:byte
extrn cur_row:word
extrn cur_col:word
extrn new_row:word
extrn new_col:word
extrn rand_dir:byte
extrn rand_dist:byte
extrn valid_left:word
extrn valid_right:word
extrn valid_down:word
extrn valid_up:word
extrn LAST_COL:word
extrn LAST_ROW:word
extrn photoFilename:byte
extrn photoFilehandle:word
EXTRN IS_COL:WORD
extrn FIRST_COL:word
extrn FIRST_ROW:word
extrn photoData:byte
extrn seed:word
extrn posxs1:word
extrn posxe1:word
extrn posys1:word
extrn posye1:word
extrn color:word
extrn dist:word
EXTRN OPOT:BYTE
extrn posxs2:word
extrn posxe2:word
extrn posys2:word
extrn posye2:word
extrn init_posxs1:word
extrn init_posxe1:word
extrn init_posys1:word
extrn init_posye1:word 
extrn init_posxs2:word
extrn init_posxe2:word
extrn init_posys2:word
extrn init_posye2:word
extrn first_time:byte
extrn drawcar:far
extrn current_press:far
extrn check_color1:far
extrn check_color2:far
extrn drawrectangle1:far
extrn drawrectangle2:far
extrn takepower1:far
extrn takepower2:far
extrn takeslow1:far
extrn takeslow2:far
; extrn takeobstaclepower1:far
; extrn takeobstaclepower2:far
; extrn createobstacle:far
extrn removemakingobs1:far
extrn removemakingobs2:far
; extrn createpowerforobstacle:far
; extrn creatpowerformakingobstacle:far
; extrn createpowerup:far
; extrn createpowerdown:far
extrn createtrap:far
public dfs, readData, openFile, closeFile, draw
.model large
     .stack 64
                           
.data
    photoWidth      EQU 50
    photoHeight     EQU 20
    safty_width     equ 20d
    safty_width_down equ 50d
     Last_dir         db   ?
    roadrows          dw 15 dup(?)
    roadcols          dw 15 dup(?)
.code

   
draw Proc far 
            cmp first_time,0
            jnz lato2
            cmp rand_dir,0
            jz elkholsa
            cmp rand_dir,2
            jnz lat
            elkholsa:
            mov ax,340
              mov di,init_posys2
              mov si,init_posxs2
              xchg si,di
              mov init_posys2,di
              mov init_posxs2,si
              mov di,init_posye2
              mov si,init_posxe2
              xchg si,di
              mov init_posye2,di
              mov init_posxe2,si
            jnz lat
              lato2:mov ax,SEED
              lat:
              mov bl,10
              mov ah,00
              div bl
              xchg al,ah
              mov ah,00
              mov dist,aX
              ADD AL,RAND_DIR
              mov ah,00
              mov bl,5
              div bl  
              MOV OPOT,AH
              mov  ah,0ch                         ;draw pixel command
              LEA  BX , photoData                 ; BL contains index at the current drawn pixel
              int  10h
              mov ax,dist
              MOV  CX,FIRST_COL
              MOV  DX,FIRST_ROW
              mov posxs1,cx
              add posxs1,AX
              mov posxe1,cx
              add posxe1,AX
              ADD POSXE1,5
              mov posys1,dx
              add posys1,AX
              mov posye1,dx
              add posye1,AX
              ADD POSYE1,5
              mov si,dx
              CMP AX,7
              JG T1
                ADD AX,8
                JMP DR
                T1:SUB AX,6
              CMP si,7
              JG T
                ADD si,5
                JMP DR
              T:SUB si,5
              
             DR: MOV POSXS2,CX
              ADD POSXS2,AX
              MOV POSXE2,CX
              ADD POSXE2,AX
              ADD POSXE2,5
              mov POSYS2,si
              ADD POSYS2,AX
              mov POSYE2,si
              ADD POSYE2,AX
              add POSYE2,5
              or first_time,1
    drawLoop: 
              mov ah,0ch
              MOV  AL,[BX]
              INT  10h
              INC  CX
              INC  BX
              CMP  CX,LAST_COL
              JNE  drawLoop
              MOV  CX , FIRST_COL
              INC  DX
              CMP  DX , LAST_ROW
              JNE  drawLoop
      mov color,22h;
      call drawrectangle1
      CMP OPOT,00
      JZ RETER
      CMP OPOT,01
      JZ POWERUP1
      CMP OPOT,02
      JZ POWERUP2
      CMP OPOT,03
      JZ POWERUP3
      cmp OPOT,04
      JZ POWERUP4
      POWERUP1: MOV COLOR,55H;TODO:COLOR
      JMP DO
      POWERUP2: MOV COLOR,66H;TODO:COLOR
      JMP DO
      POWERUP3: MOV COLOR,50H;TODO:COLOR
      JMP DO
      POWERUP4: MOV COLOR,73H;TODO:COLOR
      DO: CALL DRAWRECTANGLE2
      RETER:RET
Draw ENDP
    
    
    
    
OpenFile Proc far 
              MOV  AH, 3Dh
              MOV  AL, 0                          ; read only
              LEA  DX, photoFilename
              INT  21h
         
              MOV  [photoFilehandle], AX
        
              RET
    
OpenFile ENDP
    
ReadData Proc far 
    
              MOV  AH,3Fh
              MOV  BX, [photoFilehandle]
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
              MOV  CX,photoWidth*photoHeight*4    ; number of bytes to read
              LEA  DX, photoData
              INT  21h
              RET
ReadData ENDP
    
    
CloseFile Proc far 
              MOV  AH, 3Eh
              MOV  BX, [photoFilehandle]
    
              INT  21h
              RET
CloseFile ENDP
dfs Proc far 
mov valid_down,1
mov valid_left,1
mov valid_right,1
mov valid_up,1


    Again:    
              mov  ax, valid_left
              or   ax, valid_right
              or   ax, valid_down
              or   ax, valid_up
              cmp  ax, 0
              je   uptoreturn
    ;TODO: push register
              push cx
              push dx
              push ax
    ;loop
              mov  ax, 00
              INT  1ah
              mov  ax, dx
               add ax,seed
               add seed,71
              mov  dx, 4d
              mov  ah, 0
              div  dl
              mov  rand_dir, ah
              pop  ax
              pop  dx
              pop  cx
    ;TODO: pop rsgister
              mov  dx, new_row
              mov  cx, new_col
              mov  cur_row, dx
              mov  cur_col, cx
              cmp  rand_dir, 00d
              je   right
              cmp  rand_dir, 01d
              je   uptodown
              cmp  rand_dir, 02d
              je   uptoleft
              cmp  rand_dir, 03d
              je   uptoup
              uptoagainos:jmp again
    ; check if going right is valid and not visited and draw it
    ; go right
    right:    
            ; add seed,4
              mov  valid_right, 0
              mov  cx, cur_col
              mov  dx, cur_row
              add  cx,photowidth
    ;TODO: randomize the distance
              mov  ax, 320
              sub  ax, safty_width
              cmp  cx, ax
              jle  y1
              JMP  uptoagainos
            uptoreturn :jmp uptoreturn2
            uptodown:jmp down
              uptoleft:jmp left
            uptoup:jmp uptoup2
    y1:       
    ;check if visited or not
            
              mov  ah, 0Dh                        ; set the video mode
              int  10h                            ; get the color of the pixeL
              cmp  al,0h
              JNE  uptoagainos
              mov  new_col, cx
              mov  new_row, dx       
              MOV  CX , cur_col
              MOV  FIRST_COL,CX
              mov  Dx,cur_row
              MOV  FIRST_ROW,DX
              MOV  AX,cx
              ADD  AX,photoWidth
              mov  LAST_COL,AX
              MOV  AX,dx
              ADD  AX,photoHeight
              mov  LAST_ROW,AX
              mov Last_dir,0
              CALL Draw
    ;call dfs 
              mov  valid_left, 1
              mov  valid_right, 1
              mov  valid_down, 1
              mov  valid_up, 1
              JMP  uptoAGAIN
            uptoAgain:jmp again
    ;---------------------------------------------------mov down
    down:     
   ; add seed,24
              mov  valid_down, 0
              mov  cx, cur_col
              mov  dx, cur_row
              add  dx,photowidth
    ;jmp right
              mov  ax, 200
              sub  ax, safty_width_down
              cmp  dx, ax
              jle  y2
              JMP  uptoAGAIN
        
    y2:       
    ;check if visited or not
            mov  ah, 0Dh                        ; set the video mode
              int  10h                            ; get the color of the pixeL
              cmp  al,0h
              JNE  uptoAgAIN
              mov  new_col, cx
              mov  new_row, dx
    ;draw these pixels
              MOV  CX , cur_col
              MOV  AX,cx
              ADD  AX,photoHeight
              mov  LAST_COL,AX
                  
              mov  Dx,cur_row
              MOV  AX,dx
              ADD  AX,photoWidth
              mov  LAST_ROW,AX
              MOV  CX,CUR_COL
              MOV  FIRST_COL,CX
              MOV  DX,CUR_ROW
              MOV  FIRST_ROW,DX
              mov Last_dir,1
              CALL Draw
              mov  valid_left, 1
              mov  valid_right, 1
              mov  valid_down, 1
              mov  valid_up, 1
              JMP  uptoAGAIN
              uptoagain2:jmp uptoagain
    ;------------------------------------------------------
    ;go left
    left:     
    add seed,17
              mov  valid_left, 0
              mov  cx, cur_col
              mov  dx, cur_row
              sub  cx,photowidth
              mov  ax, 0
              add  ax, safty_width
              cmp  cx, ax
        
              jge  y3
              JMP  uptoAGAIN2
      uptoreturn2: jmp return
      uptoup2:jmp up  
    y3:       
    ;check if visited or not
            mov  ah, 0Dh                        ; set the video mode
              int  10h                            ; get the color of the pixeL
              cmp  al,0h
              JNE  uptoAgAIN2
              mov  new_col, cx
              mov  new_row, dx
    ;draw these pixels
    ;GO LEFT FROM DOWN
              mov  cx,cur_col
              ADD  CX,photoHeight
              mov  LAST_COL,cx
              mov  dx,cur_row
    ;;;;;;;;;;;;;;;
              ADD  DX,photOHeight
              mov  LAST_ROW,dx                    ;
              mov  cx,new_col
              mov  dx,new_row
              MOV  FIRST_COL,CX
    ;;;;;;sub dx,photoHeight
              MOV  FIRST_ROW,DX
    ;;;;;;;;;;;sub new_row,photoHeight
              mov Last_dir,0
              CALL Draw
              mov  valid_left, 1
              mov  valid_right, 1
              mov  valid_down, 1
              mov  valid_up, 1
              JMP  uptoAGAIN2
                uptoagain3:jmp uptoagain2
    ;-------------------------------------------------------------
    ;go up
    up:       
    add seed,23
              mov  valid_up, 0
              mov  cx, cur_col
              mov  dx, cur_row
              sub  dx,photowidth
              mov  ax, 0
              add  ax, safty_width
              cmp  dx, ax
              jge  y4
              JMP  uptoAGAIN3
        
    y4:       
    ;check if visited or not
            mov  ah, 0Dh                        ; set the video mode
              int  10h                            ; get the color of the pixeL
              cmp  al,0h
              JNE  uptoAgAIN3
              mov  new_col, cx
              mov  new_row, dx
    ;draw these pixels
              mov  cx,cur_col
              mov  LAST_COL,cx
              add  LAST_COL,photoHeight
              mov  dx,cur_row
              add  dx,photOHeight
              mov  LAST_ROW,dx
              mov  cx,new_col
              mov  dx,new_row
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ADD DX,PHOTOHEIGHT
              MOV  FIRST_COL,CX
              MOV  FIRST_ROW,DX
              mov Last_dir,1
              CALL Draw
              mov  valid_left, 1
              mov  valid_right, 1
              mov  valid_down, 1
              mov  valid_up, 1
              JMP  uptoAGAIN3
        
    return:   
              call CloseFile
             MOV BX,0 
             MOV AX,new_col
             MOV CUR_COL,AX

             MOV AX,new_row
             MOV CUR_ROW,AX
             RE: mov cx,photoHeight
             MOV AX,CUR_col
             MOV new_COL,AX

             MOV AX,CUR_row
             MOV NEW_ROW,AX
              CMP Last_dir,0
              JNE end_left1
              ADD new_col,BX
              jmp DDD
              end_left1:
              ADD NEW_ROW,BX
              DDD:
              mov ah,0ch
              MOV  AL,5
              ll:
              push cx
              mov cx,new_col
              mov dx,new_row
              INT  10h
              pop cx
              cmp Last_dir,0
              JNE end_left
              inc new_row
              jmp lll
              end_left:
              inc new_col
              lll:
              loop ll
              INC BX
              CMP BX,4 
              JNE RE
              ret
dfs endp
END
```