; author : Maxime LOUKHAL
; since : 2023
; summary : Program that generates a sequence of numbers from 1 to a given input number and then reverses the sequence
; version : 1.0


section .data
    format db "%d", 0       ; Use %d format specifier for integers
    message db "Enter a number: ", 0

section .bss
    number resb 4                 ; Buffer size for the number (assume 32-bit integer)
    sequence resq 1               ; Reserved space for the returned sequence

section .text
    extern printf
    extern scanf
    extern atoi
    extern malloc
    global generate_sequence

generate_sequence:
     and rsp, -16         ; Align stack to 16-byte boundary
     sub rsp, 8           ; Align stack

    ; Print the message
    lea rcx, [message]         ; Pass the message as the first argument to printf
    mov rdx, 0                 ; No floating-point values to print
    call printf

    ; Read input from the user
    add rsp, 8           ; Restore stack by freeing the space for the return address
    pop rax              ; Restore the original value of rax
    and rsp, -16         ; Align stack to 16-byte boundary
    sub rsp, 8           ; Reserve space for the return address

    lea rcx, [format]        ; Pass the format string as the first argument to scanf
    lea rdx, [number]     ; Pass the buffer as the second argument to scanf
    xor rax, rax              ; Clear rax (used as placeholder for scanf return value)
    call scanf


    lea rcx, [format]
    mov rdx, qword [number]
    call printf
    ; TODO: Store the resulting integer and perform further operations
     add rsp, 8           ; Restore stack by freeing the space for the return address
     pop rax              ; Restore the original value of rax
     and rsp, -16         ; Align stack to 16-byte boundary
     sub rsp, 8           ; Reserve space for the return address

     ; Allocate memory for the sequence
    mov rax, 32          ; Bytes per element (int is 4 bytes)
    mul qword [number]   ; Calculate the total number of bytes needed
    mov rdi, rax         ; Store the size in rdi
    call malloc          ; Allocate memory for the sequence
    mov qword [sequence], rax   ; Store the pointer to the allocated memory

    ; Generate the sequence in reverse order
    ;mov rax, qword [number]
    ;mov rcx, qword [sequence]
    ;mov rbx, rax         ; Use rbx as a counter
    ;xor edx, edx         ; Initialize index (edx) to 0
    ;generate_loop:
    ;      mov dword [rcx + rdx * 4], ebx   ; Store the current value in the sequence
    ;      dec rbx              ; Decrease the counter
    ;      inc edx              ; Increase the index
    ;      cmp rbx, 0           ; Check if the counter has reached zero
    ;      jg generate_loop     ; Jump back to the loop if it hasn't

   add rsp, 8
   pop rax
   and rsp, -16
   sub rsp, 8
   xor eax, eax             ; Set exit code to 0
   ret