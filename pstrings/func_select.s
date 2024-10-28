.extern printf
.extern scanf

.section  .rodata
# the string format for the printf function and for the scanf function
fmt_31:
    .string "first pstring length: %d, second pstring length: %d\n"

fmt_33:
    .string "length: %d, string: %s\n"

fmt_34:
    .string "length: %d, string: %s\n"

invalid_fmt:
    .string "invalid option!\n"

scanf_fmt1:
     .string "%hhu"
scanf_fmt2:
    .string "%hhu"


.section  .text

.global run_func
.type run_func, @function
run_func: # %rdi - choice, %rsi - pstr1, %rdx - pstr2
  #Enter
   pushq %rbp       # save the old format pointer
   movq  %rsp, %rbp # create the new frame pointer

   xorq %r15, %r15     # initialize %r15 to 0
   xorq %r14, %r14     # initialize %r14 to 0

   movq  %rsi, %r15    # save pstr1`s string into %r15
   movq  %rdx, %r14    # save pstr2`s string into %r14
   
  # check user`s choice
   cmp $31, %rdi  # check if the choice = 31
   je .choice_31  # if so, jump to section choice_31

   cmp $33, %rdi  # check if the choice = 33
   je .choice_33  # if so, jump to section choice_33

   cmp $34, %rdi  # check if the choice = 34
   je .choice_34  # if so, jump to section choice_34

  jmp .invalid    # if choice != 31/33/34 - jump to invalid section

# choice 31 - pstrlen function
.choice_31:
 # get pstr1 length
   movq %r15, %rdi   # load pstr1 as  the first argument
   xorq %rax, %rax   # initialize %rax to 0
   call pstrlen      # call pstrlen function
   mov %rax, %rsi    # load the result (leangth of the first string) into %rsi

# get pstr2 length
   movq %r14, %rdi   # load pstr1 as  the first argument  
   xorq %rax, %rax   # initialize %rax to 0
   call pstrlen      # call pstrlen function
   mov %rax, %rdx    # load the result (leangth of the second string) into %rdx

   #print the results
   mov $fmt_31, %rdi # load the fmt_31 msg to %rdi
   xorq %rax, %rax   # initialize %rax to 0
   call printf
   jmp .end          # jump to end

# choice 33 - swapCase function
.choice_33:
  # swapCase for pstr1
   xorq %rax, %rax       # initialize %rax to 0
   movq %r15, %rdi       # set pstr1 as the first paramater for the swapCase function
   call swapCase
   movq  %rax, %r15      # load the return value (pstr1) into %r15

   xorq %rdi, %rdi       # initialize %rdi to 0
   xorq %rax, %rax       # initialize %rax to 0

   movq   %r15, %rdi     # set pstr1 as the first paramater for the pstrlen function
   call    pstrlen
   movq  %rax, %rsi      # load the return value (pstr1`s length) into %rsi
  # print pstr1`s swapCase result
   incq    %r15          # increment pstr1`s address by 1 to print only the string
   mov    $fmt_33, %rdi  # load the fmt_33 msgas the first parameter into %rdi
   movq   %r15, %rdx     # load pstr1 as the third paramater into %rdx
   xorq   %rax, %rax     # initialize %rax to 0
   call   printf


   # swapCase for pstr2
   movq %r14, %rdi      # set pstr2 as the first paramater for the swapCase function
   call swapCase
   movq %rax, %r14      # save the return value into %r14
   xorq %rdi, %rdi      # initialize %rdi to 0
   xorq %rax, %rax      # initialize %rax to 0
  # print pstr2`s swapCase result
   movq   %r14, %rdi    # set pstr2 as the first paramater for the pstrlen function
   call   pstrlen
   movq  %rax, %rsi     # load the return value (pstr2`s length) into %rsi
   incq   %r14          # increment pstr2`s address by 1 to print only the string
   mov   $fmt_33, %rdi  # load the fmt_33 msg into %rdi
   movq   %r14, %rdx    # load pstr2 as the third paramater into %rdx
   xorq   %rax, %rax    # initialize %rax to 0
   call   printf

   jmp .end            # jump to end section

.choice_34:

  # get the numbers from the user

   #get the first number
   subq   $16, %rsp        # allocate memory for 2 integers
   xorq   %rax, %rax       # initialize %rax to 0    
   movq $scanf_fmt1, %rdi  # load scanf_fmt1 to %rdi
   movq  -16(%rbp), %rsi   # load the allocate memory to %rsi
   call scanf
   movq %r8, %r12          # save i into %r12

   #get the second number
   xorq   %rax, %rax       # initialize %rax to 0    
   movq $scanf_fmt2, %rdi  # load scanf_fmt2 to %rdi
   movq  -16(%rbp), %rsi   # load the allocate memory to %rsi
   call scanf
   movq %r8, %r13          # save j into %r13
  
 
   #addq  $16, %rsp          # free the allocated memory on the stack

   movq %r13, %rdx        # load j into %rdx as the third argument
   movq %r12, %rcx        # load i into %rdx as the fourth argument
   
   movq %r15, %rdi        # load pstr1 as the first argument
   call pstrlen
   movq %rax, %rbx        # load pstr1`s length into %rbx
   
   movq  %r15, %rdi      # load pstr1 as the first argument
   movq  %r14, %rsi      # load pstr2 as the second argument
   call pstrijcpy 
 

   movq %rbx, %rsi       # load the length of pstr1 into %rsi
   mov $fmt_34, %rdi     # load the fmt_34 msg into %rdi
   incq %r15             # increment pstr1 address by 1 to load only the string into %rdx
   movq %r15, %rdx       # load pstr1`s string into %rdx
   xorq %rax, %rax       # initialize %rax to 0
   call printf   

   movq %r14, %rdi       # load pstr2 into %rdi
   call pstrlen
   movq %rax, %rsi       # load pstr2`s length into %rsi
   incq    %r14          # increment pstr2 address by 1 to load only the string into %rdi
   mov $fmt_34, %rdi     # load the fmt_34 msg into %rdi
   movq %r14, %rdx       # load pstr2`s string into %rdx
   xorq %rax, %rax       # initialize %rax to 0
   call printf

   jmp .end              # jump to end section

.end:
   mov %rbp, %rsp        # initionalize stack pointer
   pop %rbp              # pop the base pointer
   ret                   # return from the function

.invalid:
   mov   $invalid_fmt, %rdi   # load invalid msg into %rdi
   xorq   %rax, %rax          # initialize %rax to 0
   call   printf         

   mov %rbp, %rsp        # initionalize stack pointer
   pop %rbp              # pop the base pointer
   ret                   # return from the function
    