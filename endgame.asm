EXTRN WINNER:byte
public GAMEOVER
.Model medium
.Stack 64
.Data
    player_1win    db 'player 1 won the race','$'
    player_2win    db 'player 2 won the race','$'
    no_one_win      db 'game over','$'

.Code

GAMEOVER PROC FAR
              mov  ah,0
              mov  al,3h                         ; or 4 or 6
              int  10h
            push bx
              MOV CX,160
              MOV DX,100
              mov ah,2
              mov bl,cl
              mov bh,dl
              MOV dx,bx
              int 10h 
              mov ah, 9
              LEA DX, player_1win
              cmp WINNER,1
              je op1
              lea dx, player_2win
              cmp WINNER,2
              je op1
              
              lea dx,no_one_win
              op1:
              mov winner,0
              int 21h
              pop bx 
            mov cx,0ffffh
              sifood:loop sifood
     ret
GAMEOVER ENDP

End 