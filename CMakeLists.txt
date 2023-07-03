cmake_minimum_required(VERSION 3.12)
project(nasm-practices C)

# Add NASM source files
set(ASM_SOURCES
        ${CMAKE_SOURCE_DIR}/add.asm
        ${CMAKE_SOURCE_DIR}/sequence_generator.asm
        # Add more .asm files here...
        )

# Iterate through each .asm file and add a custom command for building
foreach(ASM_SOURCE ${ASM_SOURCES})
    # Get the base name of the .asm file
    get_filename_component(ASM_BASENAME ${ASM_SOURCE} NAME_WE)

    # Build command for assembling the .asm file for Win64
    set(NASM_COMMAND nasm -f win64 -o ${CMAKE_BINARY_DIR}/${ASM_BASENAME}.obj ${ASM_SOURCE})

    # Execute the NASM command
    execute_process(
            COMMAND ${NASM_COMMAND}
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            RESULT_VARIABLE NASM_RESULT
    )

    # Check the result of the NASM build
    if(NOT ${NASM_RESULT} EQUAL 0)
        message(FATAL_ERROR "Failed to assemble ${ASM_SOURCE}")
    endif()

    # Print a success message
    message(STATUS "Assembled ${ASM_SOURCE} successfully")
endforeach()

file(GLOB ASM_EXTERNAL_OBJECTS
        ${CMAKE_BINARY_DIR}/*.obj
        )

# Add a dummy C source file with a main function
add_executable(${PROJECT_NAME} main.c ${ASM_EXTERNAL_OBJECTS})

if(MSVC)
    # Set the linker option to ignore the default library conflict
    set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "/NODEFAULTLIB:MSVCRTD /LARGEADDRESSAWARE:NO")

    # Link the necessary libraries
    target_link_libraries(${PROJECT_NAME} PRIVATE msvcrt legacy_stdio_definitions)
endif()

SET_SOURCE_FILES_PROPERTIES(
        ${ASM_EXTERNAL_OBJECTS}
        PROPERTIES
        EXTERNAL_OBJECT true
        GENERATED true
)

