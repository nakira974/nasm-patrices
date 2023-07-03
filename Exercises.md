
## NASM Programming Exercises

### Exercise 1: Sequence Generator
Program Description:
Your task is to write a NASM program that generates a sequence of numbers from 1 to a given input number and then reverses the sequence. The program should take an input number, generate the sequence, reverse it, and display the reversed sequence on the screen.

Instructions:
1. Start by defining the data section of your program using the `section .data` directive. Reserve space for variables that you will use later.
2. Define a label for the start of the code section using the `section .text` directive.
3. Implement the main program logic using NASM instructions.
4. Prompt the user for an input number using the `syscall` instruction for input. Store the input in a register or memory location for further processing.
5. Generate the sequence from 1 to the input number using a loop. Use instructions like `mov`, `inc`, and `cmp` to iterate through the numbers and store them in memory.
6. Reverse the sequence using another loop. You can utilize an extra register or swap values to achieve the reversal.
7. Display the reversed sequence on the screen using the `syscall` instruction for output.
8. Terminate the program gracefully using the appropriate system call.

Remember to use comments to explain your code and make it easier for beginners to understand. Also, provide clear instructions on how to input the number and how the reversed sequence will be displayed.

Good luck with your NASM programming exercise!