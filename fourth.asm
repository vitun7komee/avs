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
    multiplier dw 1 
 

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
 

input proc
    mov ah, 01h 
    int 21h 
    sub al, 30h
    mov bl, al

getnum:
    mov ah, 01h 
    int 21h 
    cmp al, 0Dh 
    je endget 
    sub al, 30h 
    
   
    mov ax, 10
    
    mul bx 
    add bl, al 
    mov ah, 02h 
    mov dl, al 
    int 21h 
    jmp getnum 

endget:
    mov ax, bx 
    mov dx, 0 
    mov multiplier, 1 
    ret 
input endp  

end start