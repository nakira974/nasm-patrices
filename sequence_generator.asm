; author : Maxime LOUKHAL
; since : 2023
; summary : Program that generates a sequence of numbers from 1 to a given input number and then reverses the sequence
; version : 1.0


section .data
    format db "%d", 0       ; Use %d format specifier for integers
    input_message db "Enter a number: ",  0
    sequence_length_message db "Sequence lenght: %d", 10, 0
    generated_sequence_message db "Generated sequence: ", 10, 0

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
    lea rcx, [input_message]   ; Pass the message as the first argument to printf
    xor rdx, rdx         ; No floating-point values to print
    call printf

    ; Read input from the user
    lea rcx, [format]    ; Pass the format string as the first argument to scanf
    lea rdx, [number]    ; Pass the buffer as the second argument to scanf
    xor rax, rax         ; Clear rax (used as placeholder for scanf return value)
    call scanf

    ; Print the sequence length
    lea rcx, [sequence_length_message]
    mov rdx, qword [number]
    call printf

    ; Allocate memory for the sequence
    mov rax, qword [number]   ; Get the input number
    imul rax, 4               ; Calculate the total number of bytes needed (assuming int is 4 bytes)
    sub rsp, 8                ; Align the stack on a 16-byte boundary
    push rax                  ; Save the calculated size on the stack
    call malloc               ; Allocate memory for the sequence
    add rsp, 16               ; Clean up the stack (remove the allocated size and alignment adjustment)


    ; Generate the sequence in reverse order
    mov ecx, dword [number] ; Use ecx as a counter
    mov rdx, 0              ; Initialize index (edx) to 1

    generate_loop:
        mov qword [sequence + 4 * rdx], rcx   ; Store the current value in the sequence
        dec ecx                                   ; Decrease the counter
        inc rdx                                   ; Increase the index
        cmp ecx, 0                                ; Check if the counter has reached one
        jg generate_loop                          ; Jump back to the loop if it hasn't
        mov rsp, rbp                              ; Restore the stack pointer
        pop rbp                                   ; Restore rbp
        mov rax, qword [sequence]                 ; Move the address of the allocated memory to rdi (as int* type)
        ret                                       ; Return from the function