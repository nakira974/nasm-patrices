cmake_minimum_required(VERSION 3.12)
project(interruption_handler)

set(NASM_HOME $ENV{NASM_HOME})  # Get the value of NASM_HOME environment variable

enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_OBJFORMAT win64)
set(CMAKE_ASM_NASM_COMPILE_OPTIONS "-fwin64")

add_executable(interruption_handler main.asm add.asm)



# Add a custom target to assemble the NASM source files separately
add_custom_target(assemble_nasm_files ALL
        COMMAND nasm.exe -f win64 -o interruption_handler.obj main.asm
        COMMAND nasm.exe -f win64 -o add.asm
        COMMENT "Assembling NASM files"
        VERBATIM)

add_dependencies(interruption_handler assemble_nasm_files)