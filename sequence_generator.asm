; author : Maxime LOUKHAL
; since : 2023
; summary : Program that generates a sequence of numbers from 1 to a given input number and then reverses the sequence
; version : 1.0


section .data
    format db "%s", 10, 0       ; Use %d format specifier for integers
    number db 32                ; Buffer size for the number
    message db "Enter a number: ",10, 0

section .text
    extern printf
    extern scanf
    extern atoi
    global generate_sequence

generate_sequence:
    sub rsp, 8                ; Align stack

    ; Print the message
    lea rcx, [message]         ; Pass the message as the first argument to printf
    mov rdx, 0                 ; No floating-point values to print
    call printf

    ; Read input from the user
    lea rcx, [number]
    lea rdx, [format]
    xor eax, eax              ; Clear rax (used as placeholder for scanf return value)
    call scanf

    ; Cast the input to an integer using atoi
    mov rcx, qword [number]
    call atoi

    ; TODO: Store the resulting integer and perform further operations

    add rsp, 8               ; Restore stack
    xor eax, eax             ; Set exit code to 0
    ret