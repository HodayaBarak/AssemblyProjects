.extern printf
.extern scanf
.extern srand

.section  .data
# allocate 4 bytes for the result (the random number) and for the user`s guess (integer)
seed:
    .space 4
user_guess:
    .space 4
result:
    .space 4


.section  .rodata
# the string format for the printf function and for the scanf function
seed_fmt:
    .string "Enter configuration seed: "
user_greet_fmt:
     .string "What is your guess? "
scanf_fmt:
    .string "%d"
 incorrect_msg:
    .string "Incorrect.\n"
congratz_msg:
    .string "Congratz! You won!\n"
game_over_msg:
    .string "Game over, you lost :(. The correct answer was %d\n"

.section .text

.global main # the beginnig of the code
.type   main, @function # the label 'main' representing the begining of the function main
main:
    #Enter
    pushq %rbp
    movq %rsp, %rbp # create the new frame pointer

    #print seed msg
    movq $seed_fmt, %rdi # load rdi with the string we want to print, this will be the argument that will
                         # send to the printf function
    xorq %rax, %rax      # set the return value to be 0
    call printf          # call printf with the argument in rdi

    #read the user`s seed input
    movq $scanf_fmt, %rdi # load rdi with the data type int
    movq $seed, %rsi      # load rsi with the address that the input will be stored in
    xorq %rax, %rax       # set the return value to be 0
    call scanf            # call scanf with the data type (int) and the address as arguments (%rdi, %rsi)

    #seed the random generator
    xorq %rdi, %rdi # initionalize rdi to 0
    movl seed, %edi # load edi (half from the register rdi) with the seed value for passing it to srand function
    xorq %rax, %rax # set the return value to be 0
    call srand      # call srand with the seed as argument (that stored in %edi)

    # Generate a random number between 0 to 9
    xorq %rax, %rax # set the return value to be 0
    call rand
    movl $10, %ecx  # set the divisor to 10
    xorl %edx, %edx # initialize edx to 0
    idiv %ecx       # execute the modulo operation
                    # the modulo result is now in edx

    movl %edx, result # load the location in memory that allocated with 4 bytes with the random number

    movl $5, %ebx      # initialize loop counter
    jmp .game_loop

  .game_loop:

    # ask the user to guess a number
    xorq %rdi, %rdi             # initialize rdi to 0
    movq $user_greet_fmt, %rdi  # load rdi with the string we want to print, this will be the argument that will
                                # send to the printf function
    xorq %rax, %rax             # set the return value to be 0
    call printf                 # call printf with the argument in rdi

    movq $scanf_fmt, %rdi   # load rdi with the data type int
    movq $user_guess, %rsi  # load rsi with the address that the input will be stored in
    xorq %rax, %rax         # set the return value to be 0
    call scanf              # call scanf with the data type (int) and the address as arguments (%rdi, %rsi)


    cmp %rsi, result # compare the user`s guess with the random number
    je .congratz     # if the user`s guess equal to the result (the random number) - jump to congratz label

    #the user`s guess incorrect - print inccorect
    movq $incorrect_msg, %rdi
    xorq %rax, %rax         # set the return value to be 0
    call printf             # call printf with the argument in rdi

    subl $1, %ebx           # decrement the loop counter

    cmp $0, %ebx            # compare between the counter to
    je .game_over           # if the counter equal to zero - jump to game_over label

    jnz .game_loop           # jump to the start of the loop

   #the user guess incorrectly 5 guess - game over
  .game_over:
      movq result, %rsi         # load rsi with the result (the random number)
      movq $game_over_msg, %rdi # load rdi with the loosing msg
      xorq %rax, %rax           # set the return value to be 0
      call printf               # call printf with the argument in (%rdi, %rsi)

      jmp .done

  .congratz:
    # print congratz msg
      movq $congratz_msg, %rdi # load rdi with the winning msg
      xorq %rax, %rax          # set the return value to be 0
      call printf              # call printf with the argument in %rdi

      jmp .done

  .done:
     # exit the program
      xorq %rax, %rax          # set the return value to be 0
      movq %rbp, %rsp          # restore the old stack pointer - releasee all used memory
      popq %rbp                # restore old frame pointer (the caller function frame)
      ret







