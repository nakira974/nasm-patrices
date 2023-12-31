; author: Maxime LOUKHAL
; since : 07/01/2023
; summary : Multiple ways to add things in x64 windows NASM
; version : 1.0

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

    ; Check if x_ptr or y_ptr is null
    test rdi, rdi   ; Check if x_ptr is null
    je .null_pointer_error
    test rsi, rsi   ; Check if y_ptr is null
    je .null_pointer_error

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
.null_pointer_error:  ; Handle null pointer error
    ; Print an error message or handle the error as desired
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
    ;   x: ECX
    ;   y: EDX

    ; Perform the addition
    add ecx, edx               ; perform the addition

    ; Store the result in EAX
    mov eax, ecx               ; store the result in EAX

    ; Clean up and return to the calling program
    mov rsp, rbp
    pop rbp
    ret


