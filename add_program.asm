section .text
    extern printf      ; import the printf function from the C library
    extern ref_add     ; import the 'ref_add' function from add.asm
    global main        ; entry point for the program

section .data
    format_string db "Result: %d", 0   ; format string for printf
    number1 dd 10                      ; value of number1
    number2 dd 5                       ; value of number2

main:
    ; Save the base pointer and set up a new stack frame
    push rbp
    mov rbp, rsp

    ; Prepare the addresses of the numbers to be passed to the add function
    mov edi, number1        ; address of number1
    mov esi, number2        ; address of number2

    ; Call the add function from add.asm
    call ref_add

    ; The return value (address of the result) is stored in RAX

    ; Load the result into a register from the returned address
    mov eax, dword [rax]

    ; Print the result
    mov rdi, format_string    ; format string
    mov esi, eax              ; result value
    xor eax, eax              ; clear eax register (for printf)
    call printf               ; call the printf function

    ; Clean up and exit the main program
    mov rsp, rbp
    pop rbp
    mov eax, 0x60             ; system call number for program exit
    xor edi, edi              ; exit status (0)
    syscall                   ; invoke the system call