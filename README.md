# Assembly Projects

This repository is a collection of projects written in x86-64 assembly language. These projects are designed to provide hands-on experience with the fundamentals of assembly programming, exploring how low-level code interacts directly with hardware and performs essential operations in memory management, arithmetic, and input/output handling.
These projects encourage mastery over these elements, building a foundation for systems programming, performance optimization, and understanding how high-level languages ​​are translated into machine code.

## Projects Overview

### 1. Guess the Number Game
A simple number-guessing game that demonstrates basic input/output operations, random number generation, and conditional logic in assembly.

#### Learning Objectives
- **External Function Calls**: Utilizing C library functions like `printf` and `scanf` to handle user interaction.
- **Random Number Handling**: Integrating `srand` and `rand` to generate random numbers and understanding how to adapt their output within a specified range.
- **Loop and Conditional Control**: Implementing loop structures and condition checks using assembly instructions.

### 2. P-String Manipulations
This project focuses on manipulating length-prefixed strings (p-strings), showcasing operations such as string concatenation, length calculation, and substring extraction. 

#### Learning Objectives
- **String Manipulation in Assembly**: Handling strings directly in memory, rather than relying on built-in functions.
- **Stack and Register Management**: Understanding how to pass and store string data between registers and memory.
- **Data Section Use**: Working with `.data` and `.rodata` sections for storing string literals and program constants, an essential skill in embedded and low-level programming.

## Working with Assembly Language in These Projects

### Understanding Program Sections
Each project utilizes different sections of an assembly program:
- **`.data`**: Defines variables and constants used throughout the program.
- **`.rodata`**: Stores read-only data, such as strings for output messages.
- **`.text`**: Contains the executable code, including function declarations and the main program loop.

### Registers and Stack Operations
These projects highlight efficient use of registers for computation and data storage. Key registers in x86-64, such as `rax`, `rbx`, `rcx`, and `rdx`, are used for various operations, while stack operations (`push` and `pop`) manage function calls and local variables.

### Interfacing with C Standard Library
Each project demonstrates how assembly programs can use functions from the C standard library, a technique essential for input/output operations:
- **`printf` and `scanf`**: Used for interacting with users through the console.
- **`srand` and `rand`**: Provide randomization capabilities, demonstrating how external libraries can enhance assembly capabilities.

### Debugging and Optimization
Working in assembly requires precision and careful debugging:
- **Debugging**: Assembly code can be error-prone due to its complexity. Using tools like `gdb` can help in tracking down issues by inspecting registers and memory at each execution step.
- **Optimization**: Writing assembly provides opportunities to experiment with instruction selection and memory access to optimize for speed and efficiency.

