.model medium
.stack 128
EXTRN OpenFile:FAR
EXTRN ReadData:FAR
EXTRN dfs:FAR
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
extrn takeobstaclepower1:far
extrn takeobstaclepower2:far
extrn removemakingobs1:far
extrn removemakingobs2:far
extrn createtrap:far
extrn statusbar:FAR
extrn timer_first: far
extrn calc_time:far
extrn welcome_screen1:far
extrn welcome_screen2:far
extrn second_screen:far
extrn GAMEOVER:far 
 extrn winner:byte
public first_minute, first_second, cur_minute, cur_second
public powerupclr1, powerupclr2
public currentDir1, currentDir2
public hitPowerup_x, hitPowerup_y
public player1, player2, timer, powerup_mes, score1, score2, score_mes, powerup_mes, power1_val, power2_val
public temp_ax , posxs1  , posxe1  , posys1  , posye1  , posxs2  , posxe2  , posys2  , posye2  , temp_posxs1, temp_posxe1, temp_posys1, temp_posye1
public temp_posxs2, temp_posxe2, temp_posys2, temp_posye2, up_pressed_or_not     , down_pressed_or_not   , right_pressed_or_not  , left_pressed_or_not
public w_pressed_or_not  , d_pressed_or_not  , s_pressed_or_not, a_pressed_or_not, color   , current_flag, msg     , cur_row , cur_col 
public new_row , new_col , rand_dir   , rand_dist  , valid_left , valid_right, valid_down , LAST_COL   , LAST_ROW   , photoFilename   
public  photoFilehandle , FIRST_COL  , FIRST_ROW  , photoData  , is_col  , CARFLAG1   , CARFLAG2   , POWER1  , POWER2  , slow1   , slow2   
public is_powered1, is_powered2, seed    , dist    , skipobstacle2   , skipobstacle1   , canskipobstacle2, canskipobstacle1, maketrap1
PUBLIC maketrap2 ,VALID_UP,OPOT,game_over,timer_minute,timer_second,init_posxs1  ,init_posxe1  ,init_posys1  ,init_posye1   ,init_posxs2  ,init_posxe2  ,init_posys2  ,init_posye2 ,first_time,mode


.data
    color1                equ           33h
    color2                equ           44h
    photoWidth            EQU           50
    photoHeight           EQU           30
    finalLineWidth        EQU           5
    temp_ax               dw            0
    posxs1                dw            0
    posxe1                dw            0
    posys1                dw            0
    posye1                dw            0
    posxs2                dw            0
    posxe2                dw            0
    posys2                dw            0
    posye2                dw            0
    temp_posxs1           dw            0
    temp_posxe1           dw            0
    temp_posys1           dw            0
    temp_posye1           dw            0
    temp_posxs2           dw            0
    temp_posxe2           dw            0
    temp_posys2           dw            0
    temp_posye2           dw            0
    up_pressed_or_not     db            0
    down_pressed_or_not   db            0
    right_pressed_or_not  db            0
    left_pressed_or_not   db            0
    w_pressed_or_not      db            0
    d_pressed_or_not      db            0
    s_pressed_or_not      db            0
    a_pressed_or_not      db            0
    color                 db            0     
    current_flag          dw                  0
    msg                   db             'Game Over $'
    cur_row               dw             10
    cur_col               dw             10
    new_row               dw             0
    new_col               dw             0
    rand_dir              db             0
    rand_dist             db             0
    valid_left            dw             1
    valid_right           dw             1
    valid_down            dw             1
    LAST_COL              DW             0
    LAST_ROW              DW             0
    photoFilename         DB             'xltrack.bin', 0
       photoFilehandle       DW             0
    
    FIRST_COL             DW             0
    FIRST_ROW             DW             0
    photoData             DB             photoWidth*photoHeight*4 dup(0)
    is_col                DB              0
    CARFLAG1              db                      0
    CARFLAG2              db                      0
    POWER1                DW                     0h
    POWER2                DW                     0h
    slow1                 dw                      0
    slow2                 dw                      0
    is_powered1           db                      0
    is_powered2           db                      0
    seed                  dw                     614d
    dist                  dw                      0
    skipobstacle2         db                      0
    skipobstacle1         db                      0
    canskipobstacle2      db                      0
    canskipobstacle1      db                      0
    maketrap1             db                      0
    maketrap2             db                      0
    valid_up              dw                      1
    OPOT                  db                      0
    player1               db  15d,?,15d dup('$'),'$'
    player2               db   15d,?,15d dup('$'),'$'
    timer                 db  '01:50','$'    
    powerup               db   'Run - Slow - Make - Avoid', '$'    
    score1                db  12
    score2                db  32       
    score_mes db 'Score: ','$'
    powerup_mes db 'Power-up: ','$'   
    power1_val  db  ?
    power2_val  db  ?
    hitPowerup_x db ?
    hitPowerup_y db ?
    currentDir1  db ?
    currentDir2  db ?
    powerupclr1  db ?
    powerupclr2  db ?
    first_minute db ?
    first_second db ?
    cur_minute   db ?
    cur_second   db ?
    game_over    db 0
    timer_minute    db 0
    timer_second db 0
    init_posxs1           dw          10
    init_posxe1           dw          15
    init_posys1           dw          10
    init_posye1           dw          15 
    init_posxs2           dw          20
    init_posxe2           dw          25
    init_posys2           dw          10
    init_posye2           dw          15
    first_time   db ?
    mode         db ?
  
.CODE    
main proc far
              mov  ax,@data
              mov  ds,ax
                mov ah,0
                mov al,3
                int 10h
                call welcome_screen1
                mov ax,3
                int 10h
                call welcome_screen2
              
             maino:
             mov ah,0
             mov al,3
             int 10h
                call second_screen
                ;change to graphics mode
                cmp mode,0
                jz exit
              ; cmp mode,1
              ; jz chatting
              cmp mode,2
              jz game
              ;;;;;;;;;;;;;;;;;;;;;chatting phase 2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            game: 
            mov winner,0
             
             mov  ah,0
              mov  al,13h                         ; or 4 or 6
              int  10h
              CALL OpenFile
              CALL ReadData
              mov  new_row, 10
              mov  new_col, 10
              
              call dfs
              ;
              call statusbar
        
              call DRAWCAR
              Call GAMEOVER
              mov cx,0ffffh
              sifo:loop sifo
              jmp maino
           exit:   
            mov ax,0003h
            int 10h
            mov ah,4ch
            int 21h
              main endp

end