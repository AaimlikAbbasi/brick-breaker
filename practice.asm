
;////////////////////////////////////aaimlik code of paddles/////////////////////

; brick1 color=01h score marks as 3  // brick2 color =05h score as 4// brick 3 is know as=0Dh score 5  // brick 4 color=0A score 2
;brick5 color=08h score marks 1//brick6 color =0F white score 6//brick7 color is knpw as 04 score 7//brick 8 score color 0C scrore 8
;brick9 color==brick8 color// brick 10color ==brick 7// brick11 color==03 score 3==brick1 //brick 12==brick6 0Fh/// brick 13==brick 7//
;brick14==02 score 2 //brick 15==0D== brick 3//brick 16=01h brick one
;brick 17==brick 14//brick 18==brick 16 //brick 19==brick 5//brick 20==09 score 4 //brick 21==brick 10


.model small
.stack 100h
.data
TIME_CHANGE db 0      ;check if time has changed
x_ball dw 50  ; x axis
y_ball dw 70       ; y axis

;checking theball speed over here
ball_vol_x dw 04h   ; horizontal velocity of ball
ball_vol_y dw 02h    ; vertical velocity of ball


;lets find the ball size 
ball_size  dw 5


;setting the colision of the ball in the screen

screen_width dw 138h     ;(300 pixel)
screen_height dw 0BDH      ;(200 pixel)


; now lets start dealing with the paddles
         
paddle_down_x dw  112
paddle_down_y dw  165

paddle_height dw 60;80
paddle_width dw 10 ;10


; now lets discuss paddle speed
paddle_vol dw 20
screen_bound dw 6
paddle_end dw 249

string db "SCORE :",'$'
string1 db "LEVEL 1  ",'$'

win db "  GAME OVER ",'$'
win1 db " WIN   ",'$'
askii db 123
score db 0  ; current pointsof teh player

live db 3
live1 db 3
loss1 db "LOSS",'$'

game_live dw 1
game_win dw 1
game_live1 dw 1
; variables for the brick for first coloumn
        brick1_x dw 20
        brick1_y dw 30
		
		brick2_x dw 55
        brick2_y dw 30
		
		brick3_x dw 90
        brick3_y dw 30
		
		brick4_x dw 125
        brick4_y dw 30
		
		brick5_x dw 160
        brick5_y dw 30
		
		
		brick6_x dw 195
        brick6_y dw 30
		
		brick7_x dw 230
        brick7_y dw 30
		
		
		brick8_x dw 265
        brick8_y dw 30
		
; now we will declare the block for the next  row let increse the y axis
		
		brick9_x dw 20
        brick9_y dw 60
		
		brick10_x dw 55
        brick10_y dw 60
		
		brick11_x dw 90
        brick11_y dw 60
		
		brick12_x dw 125
        brick12_y dw 60
		
		brick13_x dw 160
        brick13_y dw 60
		
		
		brick14_x dw 195
        brick14_y dw 60
		
		brick15_x dw 230
        brick15_y dw 60
		
		
		brick16_x dw 265
        brick16_y dw 60
		
	;now we will draw brick for rows 3 havinf three brick	
		
		brick17_x dw 60
        brick17_y dw 90
		
		brick18_x dw 95
        brick18_y dw 90
		
		brick19_x dw 130
        brick19_y dw 90
		
		brick20_x dw 165
        brick20_y dw 90
		
		brick21_x dw 200
        brick21_y dw 90
		
		
		
        brick_width dw 30
		brick_height dw 10
		
		
	;checking the collision variables	
br1 dw 0
br2 dw 0
br3 dw 0
br4 dw 0
br5 dw 0
br6 dw 0
br7 dw 0
br8 dw 0


br9 dw 0
br10 dw 0
br11 dw 0
br12 dw 0
br13 dw 0
br14 dw 0
br15 dw 0
br16 dw 0

;ow we will find for thefollowing rows that is following

br17 dw 0
br18 dw 0
br19 dw 0
br20 dw 0
br21 dw 0


; lets see the variable for ball collision detection
v1 dw 0
v2 dw 0
v3 dw 0
v4 dw 0

; score of  the player we will find lets assume the following score
  point db 0
  count db 0


.code
main proc
mov ax,@data
mov ds,ax


mov ah,00h
mov al,13h
int 10h

;;lets set the backgrond color of the game
;MOV AH, 06h    ; Scroll up function
;XOR AL, AL     ; Clear entire screen
;XOR CX, CX     ; Upper left corner CH=row, CL=column
;MOV DX, 184FH  ; lower right corner DH=row, DL=column 
;MOV BH, 02h    ; YellowOnBlue
;INT 10H

;///////////////////hence it change the backgound color

;ASSUME cs:code,ds:data ,ss:stack

;push ds
;sub ax,ax
;push ax
;mov ax,data
;mov ds,ax
;pop ax
;pop ax

mov ax,0




;mov ah,0bh
;mov bh,00h
;mov bh,00h
;int 10h

          ;draw the paddle and move the paddle according to their updated position


checktime:


mov ah,2ch       ;set the system times
int 21h



cmp dl,TIME_CHANGE
je checktime

mov TIME_CHANGE,dl   

; update time
mov ah,00h                   ; we again set it to video mode so that it cannot change continue the chane of the that ball
mov al,13h
int 10h

call background_color

call block_collision
call draw_block

call ball_movement
call drawball
call draw_user

call paddle_movement 
call draw_paddle

cmp game_win,0
je exit
cmp game_live,0
je exit

;draw userinterface

jmp  checktime                 ; check time again



exit::
call show_game_over
mov ah,4ch
int 21h
ret
main endp


; over here we will draw the ball and ball will move here and there


show_game_over proc

mov ah,00h
mov al,13h
int 10h


game_win1:
      mov ax,0
      mov bx,0
      mov dx,0
      mov cx,0

; bh has page number   dh x coordinate dl has y coordinates
     mov ah,02h
     mov bx,0
     mov dh,90
     mov dl,20  ; x aixa
     int 10h

     mov ax,0
     mov bx,0
     mov dx,0
     mov cx,0

     
      lea dx,win
      mov ah,09h
      int 21h
 
 
      mov dl,' '
      mov ah,02h
      int 21h
 .if(live==0)
      lea dx,loss1
      mov ah,09h
      int 21h
      jmp ol
 .elseif(live1==0)
      lea dx,win1
      mov ah,09h
      int 21h
      jmp ol
.endif



ol:
ret
show_game_over endp 
;/////////////////////////////draw ball move////////////////////////////////////////////////
drawball proc

mov cx,x_ball    ; intitial position of the ball
mov dx,y_ball    ; initial y position of the ball


ball_move:
mov ah,0Ch
mov al,04h ;this will set the color of the 
;mov bh,00
int 10h

inc cx
mov ax,cx
sub ax,x_ball
cmp ax,ball_size
jng ball_move

mov cx,x_ball              ; cx register goesback to initial value
inc dx


mov ax,dx
sub ax,y_ball
cmp ax,ball_size
jng ball_move


ret
drawball endp
;/////////////////////////////////ball move///////////////////////////////////
ball_movement proc


mov ax,ball_vol_x
add x_ball,ax
                             ; move ball horizontslly


; let check ball  collision , if ball collision is less than zero or greater than 300 than 

cmp x_ball,0
jl lx                                ; if it is cloliding than restart its position

mov ax,screen_width
sub ax,ball_size
cmp x_ball,ax
jg lx



mov bx,ball_vol_y
add y_ball,bx                        ; move ball vertically



cmp y_ball,28
jl ly

mov bx,screen_height
sub ax,ball_size
cmp y_ball,bx
jg ly1


;now we will check if the ball is colliding with paddle or not
;maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny1 && miny1 < maxy2,we will implement this code so 

;x_ball+ball_size >paddle_down_x
mov ax,x_ball
add ax,ball_size
cmp ax,paddle_down_x
jng lc

;ball_x <max=(paddle_down_x+paddle_width)
mov ax,paddle_down_x
add ax,paddle_height
cmp x_ball,ax
jnl lc

;&&(y_ball+ball_size)> paddle_down_y 
mov ax,y_ball
add ax,ball_size
cmp ax,paddle_down_y
jng lc

;&& y_ball < paddle_down_y+paddle_height
mov ax,paddle_down_y
add ax,paddle_width
cmp y_ball,ax
jnl lc
    
jmp neg_velocity                ; exits the procedures

   lc:
   ret
      lx:
        neg ball_vol_x
         ret
		 
      ly:
	    neg ball_vol_y
		ret
	  ly1:
		dec live
		neg ball_vol_y
		ret
	neg_velocity:
		neg ball_vol_y        ; reverse the vertical position of the collision
        ret
		
  exit_collision:
   ret

ball_movement endp
;//////////////////////////////////////////draw brick////////////////////////////////
draw_block proc
.if(br1==0)
;set the initial column of the block
mov cx,brick1_x           ; initial coloumn of the brick 
mov dx,brick1_y            ; initial line of the brick


           draw_brick1:
               mov ah,0Ch
               mov al,01h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick1_x
               cmp ax,brick_width
               jng draw_brick1
			   
			   mov cx,brick1_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick1_y
               cmp ax,brick_height
               jng draw_brick1
			   .endif
			.if(br2==0)   
			   mov cx,brick2_x
			   mov dx,brick2_y
			   ; now this is code for the brick two code that we will implement
		   draw_brick2:
	
	
               mov ah,0Ch
               mov al,05h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick2_x
               cmp ax,brick_width
               jng draw_brick2
			   
			   mov cx,brick2_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick2_y
               cmp ax,brick_height
               jng draw_brick2
			 .endif
			.if(br3==0)   
			   mov cx,brick3_x
			   mov dx,brick3_y
			   
           ; now we will code for brick 3 to draw brick three this is the following code
           draw_brick3:
        
               mov ah,0Ch
               mov al,0Dh ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick3_x
               cmp ax,brick_width
               jng draw_brick3
			   
			   mov cx,brick3_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick3_y
               cmp ax,brick_height
               jng draw_brick3
			 .endif  
			   ; now we will write code for the brick 4
			.if(br4==0)   			   
			   mov cx,brick4_x
			   mov dx,brick4_y
			   
		   draw_brick4:
        
               mov ah,0Ch
               mov al,0Ah ;this will set the color of the 
              ;mov bh,00
               int 10h
 
               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick4_x
               cmp ax,brick_width
               jng draw_brick4
			   
			   mov cx,brick4_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick4_y
               cmp ax,brick_height
               jng draw_brick4
			 .endif  
			 .if(br5==0)  
			   mov cx,brick5_x
			   mov dx,brick5_y
			   
		  draw_brick5:
        
               mov ah,0Ch
               mov al,08h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick5_x
               cmp ax,brick_width
               jng draw_brick5
			   
			   mov cx,brick5_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick5_y
               cmp ax,brick_height
               jng draw_brick5
			 .endif
			.if(br6==0)   
			   mov cx,brick6_x
			   mov dx,brick6_y
			   
		  draw_brick6:
        
               mov ah,0Ch
               mov al,0Fh ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick6_x
               cmp ax,brick_width
               jng draw_brick6
			   
			   mov cx,brick6_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick6_y
               cmp ax,brick_height
               jng draw_brick6 
            .endif			   
			.if(br7==0)   
			   mov cx,brick7_x
			   mov dx,brick7_y
			   
		   draw_brick7:
        
               mov ah,0Ch
               mov al,04h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick7_x
               cmp ax,brick_width
               jng draw_brick7
			   
			   mov cx,brick7_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick7_y
               cmp ax,brick_height
               jng draw_brick7 
             .endif			   
			 .if(br8==0)  
			   mov cx,brick8_x
			   mov dx,brick8_y
		    
           draw_brick8:
        
               mov ah,0Ch
               mov al,0Ch ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick8_x
               cmp ax,brick_width
               jng draw_brick8
			   
			   mov cx,brick8_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick8_y
               cmp ax,brick_height
               jng draw_brick8
			   .endif
			 .if(br9==0)  
			   mov cx,brick9_x
			   mov dx,brick9_y
			   
; now will start code for the next row let starts doing this for the next row	   
			   
		   draw_brick9:
               mov ah,0Ch
               mov al,0Ch ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick9_x
               cmp ax,brick_width
               jng draw_brick9
			   
			   mov cx,brick1_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick9_y
               cmp ax,brick_height
               jng draw_brick9
			 .endif
			.if(br10==0)   
			   mov cx,brick10_x
			   mov dx,brick10_y
			   ; now this is code for the brick two code that we will implement
		   draw_brick10:
	
	
               mov ah,0Ch
               mov al,04h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick10_x
               cmp ax,brick_width
               jng draw_brick10
			   
			   mov cx,brick10_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick10_y
               cmp ax,brick_height
               jng draw_brick10
			   .endif
			.if(br11==0)   
			   mov cx,brick11_x
			   mov dx,brick11_y
			   
           ; now we will code for brick 3 to draw brick three this is the following code
           draw_brick11:
        
               mov ah,0Ch
               mov al,03h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick11_x
               cmp ax,brick_width
               jng draw_brick11
			   
			   mov cx,brick11_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick11_y
               cmp ax,brick_height
               jng draw_brick11
			.endif   
			   ; now we will write code for the brick 4
			.if(br12==0)   			   
			   mov cx,brick12_x
			   mov dx,brick12_y
			   
		   draw_brick12:
        
               mov ah,0Ch
               mov al,0Fh ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick12_x
               cmp ax,brick_width
               jng draw_brick12
			   
			   mov cx,brick12_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick12_y
               cmp ax,brick_height
               jng draw_brick12
			 .endif  
			.if(br13==0)   
			   mov cx,brick13_x
			   mov dx,brick13_y
			   
		  draw_brick13:
        
               mov ah,0Ch
               mov al,04h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick13_x
               cmp ax,brick_width
               jng draw_brick13
			   
			   mov cx,brick13_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick13_y
               cmp ax,brick_height
               jng draw_brick13
			.endif   
			.if(br14==0)   
			   mov cx,brick14_x
			   mov dx,brick14_y
			   
		  draw_brick14:
        
               mov ah,0Ch
               mov al,0Bh ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick14_x
               cmp ax,brick_width
               jng draw_brick14
			   
			   mov cx,brick14_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick14_y
               cmp ax,brick_height
               jng draw_brick14

             .endif			   
			 .if(br15==0)  
			   mov cx,brick15_x
			   mov dx,brick15_y
			   
		   draw_brick15:
        
               mov ah,0Ch
               mov al,0Dh ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick15_x
               cmp ax,brick_width
               jng draw_brick15
			   
			   mov cx,brick15_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick15_y
               cmp ax,brick_height
               jng draw_brick15
             .endif
			 
			 .if(br16==0)  
			   mov cx,brick16_x
			   mov dx,brick16_y
		    
           draw_brick16:
        
               mov ah,0Ch
               mov al,01h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick16_x
               cmp ax,brick_width
               jng draw_brick16
			   
			   mov cx,brick16_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick16_y
               cmp ax,brick_height
               jng draw_brick16 			
			  .endif 
			    
			   
			   
	; now we will start coding for the next rows		   
			 .if(br17==0)   
			   mov cx,brick17_x
			   mov dx,brick17_y
			   
		  draw_brick17:
        
               mov ah,0Ch
               mov al,0Bh ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick17_x
               cmp ax,brick_width
               jng draw_brick17
			   
			   mov cx,brick17_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick17_y
               cmp ax,brick_height
               jng draw_brick17  
			   .endif
			   
			    
			 .if(br18==0)  
			 mov cx,brick18_x
			 mov dx,brick18_y
		  draw_brick18:
        
               mov ah,0Ch
               mov al,01h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick18_x
               cmp ax,brick_width
               jng draw_brick18
			   
			   mov cx,brick18_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick18_y
               cmp ax,brick_height
               jng draw_brick18  
			   
                
			.endif
		 .if(br19==0)
               mov cx,brick19_x
			    mov dx,brick19_y		 
		  draw_brick19:
        
               mov ah,0Ch
               mov al,08h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick19_x
               cmp ax,brick_width
               jng draw_brick19
			   
			   mov cx,brick19_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick19_y
               cmp ax,brick_height
               jng draw_brick19  
			   
			    
			.endif

       .if(br20==0)
                mov cx,brick20_x
			    mov dx,brick20_y	   
		  draw_brick20:
        
               mov ah,0Ch
               mov al,09h ;this will set the color of the 
              ;mov bh,00
               int 10h

               inc cx         ; cx=cx+1
               mov ax,cx       ;cx-brick1_x>brick_width
               sub ax,brick20_x
               cmp ax,brick_width
               jng draw_brick20
			   
			   mov cx,brick20_x             ; cx register goesback to initial value
               inc dx


               mov ax,dx
               sub ax,brick20_y
               cmp ax,brick_height
               jng draw_brick20  
			   
			   
			    mov cx,brick21_x
			    mov dx,brick21_y
		.endif
		  ;;draw_brick21:
        
              ;; mov ah,0Ch
               ;;mov al,04h ;this will set the color of the 
              ;mov bh,00
               ;;int 10h
                
               ;;inc cx         ; cx=cx+1
               ;;mov ax,cx       ;cx-brick1_x>brick_width
               ;;sub ax,brick21_x
               ;;cmp ax,brick_width
              ;; jng draw_brick21
			   
			  ;; mov cx,brick21_x             ; cx register goesback to initial value
              ;; inc dx


              ;; mov ax,dx
              ;; sub ax,brick21_y
              ;; cmp ax,brick_height
              ;; jng draw_brick21  
			   
			   

ret 
draw_block endp

block_collision proc
.if(br1==0)     ; for brick one  (OC is the color score will be 3)
   
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball         ;cx=ball_y coordinates
       mov dx,cx             ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
       .if(v2>20 &&  v1<49 && v3>29 && v4<36 )
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             mov bh,00
             int 10h
             mov brick1_x,500
			 mov brick1_y,600
			 add point,3     ; score will be add as 3
			 mov br1,1
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif
.if(br2==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball         ;cx=ball_y coordinates
       mov dx,cx             ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>55 &&  v1<85  &&  v3>29&& v4<36)
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             mov bh,00h
             int 10h
             mov brick2_x,500
			 mov brick2_y,600
             add point,4     ; as color is 05h so it will add 4 to the score
			 mov br2,1
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif


.if(br3==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball       ;cx=ball_y coordinates
       mov dx,cx            ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>90 &&  v1<120 && v3>29 && v4<36 )
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h

			 ;this will set the color of the 
             mov bh,00
             int 10h
             mov brick3_x,500
			 mov brick3_y,600
			 add point,5     ; as color is 0Dh so it will add 5 to the score
			 mov br3,1
			 inc count
			; here we will place the sounding track
	    .endif
 .endif

.if(br4==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>125 &&  v1<155 && v3>29 && v4<36 )
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
             mov brick4_x,500
			 mov brick4_y,600
			 add point,2     ; as color is 0Ah so it will add 2 to the score
			 mov br4,1
			 inc count
			 
			 ; here we will place the sounding track
	    .endif
 .endif


.if(br5==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>160 &&  v1<190 && v3>29 && v4<36 )
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
             mov brick5_x,500
			 mov brick5_y,600
			 add point,1  
			 mov br5,1
			 inc count
			 
			 ; here we will place the sounding track
	    .endif
 .endif
 
 
 .if(br6==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>195 &&  v1<225 && v3>29 && v4<36 )
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
             mov brick6_x,500
			 mov brick6_y,600
			 mov br6,1
			 add point,6 
             inc count			 
			 ; here we will place the sounding track
	    .endif
 .endif
 
 
 .if(br7==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>230 &&  v1<260 && v3>29 && v4<36 )
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
             mov brick7_x,500
			 mov brick7_y,600
			 mov br7,1
			  add point,7
			  inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
 
 .if(br8==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>265 &&  v1<295 && v3>29 && v4<36 )
             neg ball_vol_y
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
             mov brick8_x,500
			 mov brick8_y,600
			 mov br8,2
			 add point,8
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif

;now we will implement same code for the next row
;//////////////////////////////////

.if(br9==0)     ; for brick one
   
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball         ;cx=ball_y coordinates
       mov dx,cx             ;dx=ball_y +ball_size
       add dx,ball_size
			
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
       .if(v2>20 &&  v1<49 && v3>59 && v4<66 )
             neg ball_vol_y
			 
             mov brick9_x,500
			 mov brick9_y,600
			 
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 mov br9,2
			 add point,8
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif
.if(br10==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball         ;cx=ball_y coordinates
       mov dx,cx             ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>54 &&  v1<86  &&  v3>59 && v4<66 )
             neg ball_vol_y
			 
             mov brick10_x,500
			 mov brick10_y,600
			 
             mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 mov br10,1
			 add point,7
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif


.if(br11==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball       ;cx=ball_y coordinates
       mov dx,cx            ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>89 &&  v1<121 && v3>59 && v4<66 )
             neg ball_vol_y
			
             mov brick11_x,500
			 mov brick11_y,600
			 
			  mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 mov br11,1
			 add point,3
			 inc count
			; here we will place the sounding track
	    .endif
 .endif

.if(br12==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>124 &&  v1<156 && v3>59 && v4<66 )
             neg ball_vol_y
			
             mov brick12_x,500
			 mov brick12_y,600
			 
			  mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br12,1
			 add point,6
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif


.if(br13==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>159 &&  v1<191 && v3>59 && v4<66 )
             neg ball_vol_y
			 
             mov brick13_x,500
			 mov brick13_y,600
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br13,2
			 add point,7
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
 
 .if(br14==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>194 &&  v1<226 && v3>59 && v4<66 )
             neg ball_vol_y
			 
             mov brick14_x,500
			 mov brick14_y,600
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br14,1
			  add point,2
			  inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
 
 .if(br15==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
	   
       .if(v2>229 &&  v1<261 && v3>59 && v4<66 )
             neg ball_vol_y
			 
             mov brick15_x,500
			 mov brick15_y,600
			 mov ah,0Ch
             mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br15,1
			 add point,5
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
 
 .if(br16==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>264 &&  v1<296 && v3>59 && v4<66 )
             neg ball_vol_y
			
             ;mov brick16_x,500
			 ;mov brick16_y,600
			  mov ah,0Ch
              mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br16,1
			 add point,3
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
 .if(br17==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>59 &&  v1<91 && v3>89 && v4< 96 )
             neg ball_vol_y
			
            ; mov brick17_x,500
			 ;mov brick17_y,600
			  mov ah,0Ch
              mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br17,1
			 add point,2
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif

 
 .if(br18==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>94 &&  v1<126 && v3>89 && v4< 96 )
             neg ball_vol_y
			
             ;mov brick18_x,500
			 ;mov brick18_y,600
			  mov ah,0Ch
              mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br18,1
			 add point,3
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
 .if(br19==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>129 &&  v1<161 && v3>89 && v4< 96 )
             neg ball_vol_y
			
             ;mov brick19_x,500
			 ;mov brick19_y,600
			  mov ah,0Ch
              mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br19,1
			  add point,5
			  inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
  .if(br20==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>164 &&  v1<196 && v3>89 && v4< 96 )
             neg ball_vol_y
			
             ;mov brick20_x,500
			 ;mov brick20_y,600
			  mov ah,0Ch
              mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br20,1
			 add point,4
			 inc count
			 ; here we will place the sounding track
	    .endif
 .endif
 
 .if(br21==0)     ; for brick one
       mov ax,x_ball         ; in ax store the ball value 
       mov bx,ax             ; now add ball in x coordinates plus ball size
       add bx,ball_size       
       mov cx,y_ball        ;cx=ball_y coordinates
       mov dx,cx              ;dx=ball_y +ball_size
       add dx,ball_size
	   
	   mov v1,ax
	   mov v2,bx
	   mov v3,cx
	   mov v4,dx
	   
       .if(v2>198 &&  v1<132 && v3>89 && v4< 96 )
             neg ball_vol_y
			
             mov brick21_x,500
			 mov brick21_y,600
			  mov ah,0Ch
              mov al,08h ;this will set the color of the 
             ;mov bh,00
             int 10h
			 
			 mov br21,1
			 add point,7
			 ; here we will place the sounding track
	    .endif
 .endif
 
 
 
 .if(count==20)
 mov game_win,0
  call clear_screen
      
 
.endif
.if(live==0)
 
mov game_live,0
call clear_screen
     
.endif
 
ret
block_collision endp
;///////////////////

;///////////////////////////////////clear screen proc is mention over here///////////////////////


clear_screen proc
mov ah,00h
mov al,13h
int 10h

;set the background color
mov ah,0Bh
mov bh,00h
mov bl,00h
int 10h


ret
clear_screen endp


brick_color proc

mov ah,0Ch
mov al,08h ;this will set the color of the 
;mov bh,00
int 10h
ret 



ret
brick_color endp
;///////////////////////////////background color
background_color proc
mov al,13h
int 10h

;set the background color
mov ah,06h
mov al,0
mov cx,0; x axis
mov dx,650
mov bh,00h      ;0Bh
int 10h

ret 
background_color endp
;//////////////////////////////////////////////////////////now we will move  paddles let see what we draw
paddle_movement proc

mov ah,01h  ; key press or not 
int 16h
jz lb  ; if key is not pressed

mov ah,00h        
int 16h

cmp ah,4Bh         ;left movement key
je left

;cmp ah,27
;je la

cmp ah,4Dh           ; right movement key
je right

jmp lb

left:
mov ax,paddle_vol
sub paddle_down_x,ax     ; while moving left subtract in x axis

mov ax,screen_bound
cmp paddle_down_x,ax
jl move_right
jmp lb


move_right:
mov ax,screen_bound
mov paddle_down_x,ax
jmp lb

right:
mov ax,paddle_vol
add paddle_down_x,ax          ; while moving right add in the x axis 


mov ax,paddle_end
cmp paddle_down_x,ax
jg move_left
jmp lb

move_left:
mov ax,paddle_end
mov paddle_down_x,ax
jmp lb



lb:

ret
paddle_movement endp
;////////////////////////////////display score function now we  will implement
display_score proc

mov bx,10
mov dx,0h
mov cx,0h


d1:
mov dx,0h
div bx
push dx
inc cx
cmp ax,0
jne d1

d2:
pop dx
add dx,30h
mov ah,02h
int 21h
loop d2
ret

display_score endp

;////////////////////////////////////////////////////user interface procedures
draw_user proc
mov ax,0
mov bx,0
mov dx,0
mov cx,0

; bh has page number   dh x coordinate dl has y coordinates
mov ah,02h
mov bx,0
mov dh,78
mov dl,96  ; x aixa
int 10h

mov ax,0
mov bx,0
mov dx,0
mov cx,0



;set the cursor position
mov ax,0
mov bx,0
mov dx,0
mov cx,0

mov ah,09h
lea dx,string1
int 21h

; bh has page number   dh x coordinate dl has y coordinates
mov ah,02h
mov bx,0
mov dh,78
mov dl,110  ; x aixa
int 10h

mov ax,0
mov bx,0
mov dx,0
mov cx,0




mov al,point
call display_score




mov ax,0
mov bx,0
mov dx,0
mov cx,0

; bh has page number   dh x coordinate dl has y coordinates
mov ah,02h
mov bx,0
mov dh,78
mov dl,88  ; x aixa
int 10h

mov ax,0
mov bx,0
mov dx,0
mov cx,0

;mov ah,09h
;lea dx,string1
;int 21h
.if(live==3)
mov dl,live1
mov ah,02h
int 21h
mov dl,live1
mov ah,02h
int 21h
mov dl,live1
mov ah,02h
int 21h

.elseif(live==2)
mov dl,live1
mov ah,02h
int 21h
mov dl,live1
mov ah,02h
int 21h
.elseif(live==1)
mov dl,live1
mov ah,02h
int 21h
.elseif(live==0)
;clear_screen
.endif

ret 
draw_user endp

;/////////////////////////////////////////////////////draw paddle proc ////////////////////////////////////////
draw_paddle proc

mov cx,paddle_down_x    ; intitial position of the ball
mov dx,paddle_down_y    ; initial y position of the ball
       l1:
	      mov ah,0Ch
          mov al,02h ;this will set the color of the 
          ;mov bh,00
          int 10h


          inc cx
          mov ax,cx
          sub ax,paddle_down_x
          cmp ax,paddle_height
          jng l1
		  
		  
		  mov cx,paddle_down_x       ; if greater than return x axis again
		  
		  ;now same condition are apply for y axis
		  
		  inc dx
		  mov ax,dx
		  sub ax,paddle_down_y
		  cmp ax,paddle_width
		  jng l1

ret
draw_paddle endp
;////////////////////////////////////////////////////////////////brick structure
end main












