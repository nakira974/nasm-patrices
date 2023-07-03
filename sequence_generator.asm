; author : Maxime LOUKHAL
; since : 2023
; summary : Program that generates a sequence of numbers from 1 to a given input number and then reverses the sequence
; version : 1.0


section .data
    format db "%s", 0
    number db 10               ; Buffer size for the number
    message db "Enter a number: ", 0

section .text
    extern printf
    extern scanf
    extern atoi

global _start

_start:
    sub rsp, 8                ; Align stack

    ; Print the message
    mov rdi, format
    mov rsi, message
    xor rax, rax              ; Clear rax (used as placeholder for printf return value)
    call printf

    ; Read input from the user
    lea rdi, [number]
    mov rsi, format
    xor rax, rax              ; Clear rax (used as placeholder for scanf return value)
    call scanf

    ; Cast the input to an integer using atoi
    mov rdi, [number]
    call atoi

    ; TODO: Store the resulting integer and perform further operations

    add rsp, 8               ; Restore stack
    xor eax, eax             ; Set exit code to 0
    ret