.model tiny

.stack 100h

.data 
    ea DB 'Enter a: $' 
    eb DB 13,10,'Enter b: $' 
    ec DB 13,10,' a<b $' 
    ed DB 13,10,'a>b $' 
    ee DB 13,10,'a=b $'
    a DW 0 
    b DW 0 
    res DW 0 
    multiplier dw 1 
    result dw ? 
    counter DB 0
    tmp DW 0

.code 
start:

    
    mov ah, 09h 
    mov dx, offset ea 
    int 21h 

   
    call input 
    mov [a], ax 

   
    mov ah, 09h 
    mov dx, offset eb 
    int 21h 

    
    call input 
    mov [b], ax 

    
mov ax, a
mov bx, b
cmp ax, bx
jl jmp label1
jg jmp label2
je jmp label3 

    label1:
   mov ah, 09h 
   mov dx, offset ec
   int 21h  
   jmp short ending
   label2:
   mov ah, 09h 
   mov dx, offset ed 
   int 21h 
   jmp short ending  
   label3:
   mov ah, 09h 
   mov dx, offset ee 
   int 21h 
   jmp short ending
   ending:
   
    mov ah, 4Ch
    int 21h 
 

input PROC
C:
    mov ah,1
    int 21h
    cmp al,13
    je A2
    sub al,30h
    cbw
    push ax
    inc counter
    jmp C
A2:
    cmp counter,0
    jle exit
    pop ax
    dec counter
    
    mov dx,multiplier
    imul dx
    add tmp,ax
    
    mov ax,multiplier
    mov dx,10
    imul dx
    mov multiplier,ax
    jmp A2

exit:
    mov ax,tmp
    mov multiplier,1
    mov tmp,0    
    ret
input ENDP


end start
