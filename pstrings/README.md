# pstrings Project

## Overview
The **pstrings** project is designed to perform various string manipulation tasks. It provides a menu-based interface for users to choose from options such as calculating the length of a string, swapping the case of characters, and copying a substring. Each operation prompts the user for input and displays the result.

## User Instructions
1. **Run the Program**: Execute the program in your environment.
2. **Choose an Option**: A menu will be displayed with the following choices:
   - **Option 1**: Calculate Length
   - **Option 2**: Swap Case
   - **Option 3**: Copy Substring
   - **Option 4**: Exit
3. **Provide Input**: Based on the selected option, enter the required string or indices when prompted.
4. **View the Output**: The program will display the result of the selected operation.
5. **Repeat or Exit**: You can choose another option or exit the program.

### Expected Output
- **Option 1**: If you choose this option and input the string "Hello, World!", the output will be the length of the string.
- **Option 2**: If you choose this option and input the string "Hello, World!", the output will display the string with swapped cases.
- **Option 3**: If you choose this option and input the string "Hello, World!" along with indices 0 and 4, the output will display the copied substring.
- **Option 4**: Exits the program.

## File Descriptions

### 1. main.c
**Description**: The main entry point of the program.  
**Functionality**:
   - Displays the menu options to the user.
   - Reads the user's selection and calls the appropriate string manipulation function based on that selection.
   - Handles user input and provides feedback if the input is invalid.

### 2. func_select.s
This assembly file provides various string manipulation operations based on user input. Users can:
   - **Calculate String Lengths**: Calculate the lengths of two strings.
   - **Swap Case**: Swap the cases of characters in two strings.
   - **Copy Substring**: Copy a substring from one string to another based on user-defined indices.

**Expected User Actions**:
   - The user is prompted to enter an option (31, 33, or 34).
   - Based on the option:
      - For **Option 31**: The user provides two strings, and the program prints their lengths.
      - For **Option 33**: The program swaps the cases of characters in the two strings and prints the results.
      - For **Option 34**: The user provides indices to specify a substring to copy from one string to another.

#### Section Descriptions
1. **.rodata Section**:
   - `invalid_input_fmt`: "invalid option!\n" – Displays an error message for invalid options.
   - `len_fmt`: "first pstring length: %d, second pstring length: %d\n" – Displays the lengths of two strings.
   - `func2_fmt`: "length: %d, string: %s\n" – Displays the length and content of a string.
   - `scanf_fmt`: " %d %d" – Used to read two integer inputs from the user.

2. **.text Section**:
   - Contains the executable code, starting from the `run_func` label.
   - Handles choice selection, error messages, and calls functions for length calculation, case swapping, and substring copying.

### 3. pstring.s
This file defines three core functions for string manipulation:
   1. **pstrlen**: Calculates the length of a null-terminated string.
      - Loops through each character until the null terminator, incrementing a counter.
   2. **swapCase**: Swaps the case of alphabetic characters in a string.
      - Adjusts ASCII values to toggle case.
   3. **pstrijcpy**: Copies a portion of one string to another based on user-provided indices.
      - Copies characters between start and end indices to a destination string.

These functions demonstrate efficient string manipulation techniques in x86-64 assembly.

## Summary
This project provides a user-interactive way to perform essential string manipulations like length calculation, case swapping, and substring copying. It incorporates error handling to ensure invalid inputs are managed gracefully.

## How to Run
1. Compile the program:
   ```bash
   gcc main.c func_select.s pstring.s -o pstrings

2. Run the program:
   ```bash
   ./pstrings
