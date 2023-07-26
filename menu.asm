.model small
.stack 100h
.data

newline db 10,13,"$"
name db"Name: ","$"
n db 50 dup("$")
score db "Score: ","$"
click db"Click anywhere to continue","$"
load db "Please wait till the game is loading","$"
enter db "               Enter your name: ","$"
count db 0
exit db 0
x1 dw 0
x2 dw 0
y1 dw 0
y2 dw 0
ls db "=",'$'

menu db "BRICK BREAKER GAME ","$"
;exit text db 'EXIT GAME - E KEY','$'
	


.code
main proc
mov ax,@data
mov ds,ax

mov ah,0
mov al,12h
int 10h


;-----
mov ah,09h
lea dx,menu
int 21h
;------


mov dx,offset enter
mov ah, 09h 
int 21h

mov ah,3fh
mov dx,offset n
int 21h

call loading
call hi

loading proc

mov dh,12
	mov dl,20
	mov ah,02h
	int 10h
	mov ah,09h
	mov dx,offset load
	int 21h

mov dh,15
	mov dl,31
	mov ah,02h
	int 10h
	mov ah,02h
	push dx
	mov dl,'|'
	int 21h
	int 21h
	pop dx
	
	
mov dh,15
	mov dl,43
	mov ah,02h
	int 10h
	mov ah,02h
	push dx
	mov dl,'|'
	int 21h
	int 21h
	pop dx



mov dh,15
	mov dl,33
	top:
	push cx
	push dx
	mov ah,86h
	mov cx,07h
	mov dx,120h
	int 15h
	pop dx
	pop cx
	mov ah,02h
	int 10h
	mov ah,09h
	push dx
	mov dx,offset ls
	int 21h
	pop dx
	inc dl
	cmp dl,43
	jne top
ret
loading endp

hi proc

	mov ah,0ch
	mov al,5
	mov cx,70
	mov dx,100
	row:
		mov cx,70
		line:
			int 10h
			inc cx
			cmp cx,561
			jne line
		inc dx
		cmp dx,421
		jne row

	mov ah,01h
	int 10h
	mov dh,10
	r1:;draw H first leg
		mov dl,20
		mov ah,02h
		int 10h
		
		mov ah,09h
		mov al,'B'
		mov bl,7
		mov cx,3
		int 10h
		inc dh
		cmp dh,22
		jne r1
	mov dh,15
	r2:;draw H mid
		mov dl,20
		mov ah,02h
		int 10h
		
		mov ah,09h
		mov al,'B'
		mov bl,7
		mov cx,13
		int 10h
		inc dh
		cmp dh,17
		jne r2
		
	mov dh,10
	r3:;draw H 2nd leg
		mov dl,33
		mov ah,02h
		int 10h
		
		mov ah,09h
		mov al,'B'
		mov bl,7
		mov cx,3
		int 10h
		inc dh
		cmp dh,22
		jne r3

	mov dh,10
	mov dl,48
	mov ah,02h
	int 10h
	
	mov ah,09h
	mov al,'B'
	mov bl,7
	mov cx,11
	int 10h
	
	mov dh,10
	r4:;draw I
		mov dl,52
		mov ah,02h
		int 10h
		
		mov ah,09h
		mov al,'B'
		mov bl,7
		mov cx,3
		int 10h
		inc dh
		cmp dh,22
		jne r4
	mov dh,21
	mov dl,48
	mov ah,02h
	int 10h
	
	mov ah,09h
	mov al,'B'
	mov bl,7
	mov cx,11
	int 10h
	;boder
	mov dh,5
	mov dl,7
	;top
	mov ah,02h
	int 10h
	
	mov ah,09h
	mov al,'='
	mov bl,7
	mov cx,65
	int 10h
	;down:
	mov dh,26
	mov dl,7
	mov ah,02h
	int 10h
	
	mov ah,09h
	mov al,'='
	mov bl,7
	mov cx,65
	int 10h

	mov dh,6
	left:
	mov dl,7
	mov ah,02h
	int 10h
	
	mov ah,09h
	mov al,'^'
	mov bl,7
	mov cx,1
	int 10h
	inc dh
	cmp dh,26
	jne left
	
	mov dh,6
	right:
	mov dl,71
	mov ah,02h
	int 10h
	
	mov ah,09h
	mov al,'^'
	mov bl,7
	mov cx,1
	int 10h
	inc dh
	cmp dh,26
	jne right
	
	mov dh,27
	mov dl,25
	mov ah,02h
	int 10h
	
	mov cx,4ch
	mov dx,4840
	mov ah,86h
	int 15h
	
ret
hi endp

display:

pop dx
add dl,48
mov ah,02h
int 21h
dec count

cmp count,cl
jne display 

mov dx,offset newline
mov ah,09
int 21h
   
ret

;end

main endp
end main
