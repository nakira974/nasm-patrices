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
    push rbp             ; Preserve rbp on the stack
    mov rbp, rsp         ; Set rbp as a base pointer for local variables

    ; Print the message
    lea rcx, [message]   ; Pass the message as the first argument to printf
    xor rdx, rdx         ; No floating-point values to print
    call printf

    ; Read input from the user
    lea rcx, [format]    ; Pass the format string as the first argument to scanf
    lea rdx, [number]    ; Pass the buffer as the second argument to scanf
    xor rax, rax         ; Clear rax (used as placeholder for scanf return value)
    call scanf

    ; Allocate memory for the sequence
    mov eax, dword [number]   ; Get the input number
    imul eax, 4               ; Calculate the total number of bytes needed (assuming int is 4 bytes)
    push rax                  ; Save the calculated size on the stack
    call malloc               ; Allocate memory for the sequence
    add rsp, 8                ; Clean up the stack (remove the allocated size)

    ; Store the resulting integer and perform further operations
    mov rdi, rax            ; Move the address of the allocated memory to rdi (for further operations)

    ; Generate the sequence in reverse order
    mov ecx, dword [number] ; Use ecx as a counter
    mov edx, 1              ; Initialize index (edx) to 1
    generate_loop:
        mov dword [rdi + rcx * 4 - 4], edx    ; Store the current value in the sequence
        dec ecx                               ; Decrease the counter
        inc edx                               ; Increase the index
        cmp ecx, 0                            ; Check if the counter has reached zero
        jg generate_loop                      ; Jump back to the loop if it hasn't

    mov rsp, rbp               ; Restore the stack pointer
    pop rbp                    ; Restore rbp
    mov rax, qword [sequence]  ; Move the address of the generated sequence to rax
    ret                        ; Return from the function