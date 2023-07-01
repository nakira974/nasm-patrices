; author: Maxime LOUKHAL
; since : 07/01/2023
; summary : Multiple ways to add things in x64 windows NASM

section .text
    global val_add         ; make the 'val_add' function globally accessible
    global ref_add         ; make the 'ref_add' function globally accessible

ref_add:
    ; Save the base pointer and set up a new stack frame
    push rbp
    mov rbp, rsp

    ; Function: add(x_ptr, y_ptr) - adds two numbers
    ; Arguments:
    ;   x_ptr: RDI
    ;   y_ptr: RSI

    ; Load the values at the memory addresses
    mov eax, dword [rdi]       ; load x value into EAX
    mov ebx, dword [rsi]       ; load y value into EBX

    ; Perform the addition
    add eax, ebx               ; perform the addition

    ; Allocate memory for the result
    sub rsp, 4                 ; allocate 4 bytes of memory on the stack

    ; Store the result in the allocated memory
    mov dword [rsp], eax       ; store the result in the allocated memory

    ; Set the return value to the address of the result
    lea rax, [rsp]             ; load the address of the result into RAX

    ; Clean up and return to the calling program
    mov rsp, rbp
    pop rbp
    ret


val_add:
    ; Save the base pointer and set up a new stack frame
    push rbp
    mov rbp, rsp

    ; Function: add(x, y) - adds two numbers
    ; Arguments:
    ;   x: EDI
    ;   y: ESI
    add edi, esi        ; perform the addition
    mov eax, edi        ; store the result in EAX

    ; Clean up and return to the calling program
    mov rsp, rbp
    pop rbp
    ret