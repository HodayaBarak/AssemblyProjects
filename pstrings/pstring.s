
.extern printf


.section  .rodata
# the string format for the printf function and for the scanf function
invalid_input_fmt:
    .string "invalid input!\n"

str: 
    .string "%s\n"


.section  .text

# pstrlen function
.global pstrlen
.type   pstrlen, @function
pstrlen: # %rdi - pstring
   #Enter
   pushq %rbp       # save the old format pointer
   movq  %rsp, %rbp # create the new frame pointer

   movb (%rdi), %al  # get the value of %rdi into %al

    #exit the pstrlen function
   movq %rbp, %rsp   # restore the old stack pointer - releasee all used memory
   popq %rbp         # restore old frame pointer (the caller function frame)
   ret

# swapCase function
.global swapCase
.type   swapCase, @function
swapCase: # %rdi - pstring
   #Enter
   pushq %rbp        # save the old format pointer
   movq  %rsp, %rbp  # create the new frame pointer

   xorq %rax, %rax      # initialize %rax to 0 
   xorq %r12, %r12      # initialize %r12 to 0 
   movq %rdi, %r12      # load pstring into %r12 

.loop_swapCase: 
 # start of the loop
   movb   (%r12), %al    # load current char into %al
   cmpb $0x0, %al        # compare between 0 and the current char in %al
   je   .end             # if the current char equal to 0 - jump to end

   # check if %al is not a char

   cmpb   $0x7a, %al     # check if current char ascii value grater then 'z' (122)
   ja   .update_char     # if so, jump to the start of the loop

   cmpb $0x61, %al       # check if current char ascii value bigger or equal to 'a' (97)
   jae  .upper_case      # if so, jump to upper_case section

   cmpb $0x41, %al      # check if current char ascii value smaller then to 'A' (65)
   jb   .update_char    # if so, jump to the start of the loop

   cmpb $0x5a, %al      # check if current char ascii value smaller or equal to 'Z' (90)
   jle   .lower_case    # if so, jump to lower_case section


   jmp .update_char      # if the char isn`t letter - jump to update_char
   
.update_char:
   movb %al, (%r12)      # load the current char into %r12
   inc %r12              # increment %r12`s address by 1   
   jmp .loop_swapCase    # jump back to the start of the loop   

 #change the lower case char to upper case char
.lower_case:
    add  $0x20, %al   # replace the current lower case character to upper case character by subtract 32 from it
    jmp .update_char  # jump to update_char  

 #change the upper case char to lower case char
.upper_case:
    sub  $0x20, %al     # replace the current upper case character to lower case character by add 32 to it
    jmp .update_char    # jump to update_char

.end:
    xorq %rax, %rax     # initialize %rax to 0
    movq %rdi, %rax     # load %rdi (the update pstring) into %rax
    mov %rbp, %rsp      # initionalize stack pointer
    pop %rbp            # pop the base pointer
    ret                 # return from the function


# pstrijcpy function
.global pstrijcpy
.type   pstrijcpy, @function
pstrijcpy:  # rdi - pstr1, rsi - pstr2, rdx - index j, rcx - index i
    #Enter
     pushq %rbp            # save the old format pointer
     movq  %rsp, %rbp      # create the new frame pointer
     movq %rdi, %r12       # save pstr1 into %r12 (dst)
     movq %rsi, %r13       # save pstr2 into %r13 (src)

    # check pstring`s length 
     movq %r12, %rdi         # load pstr1 into %rdi
     call pstrlen            # get pstr1`s length
     cmpq $0, %rax           # compare between pstr1`s length and 0
     je .invalid_input       # if dst`s length = 0 - jump to invalid_input section

     movq %r13, %rdi         # load pstr2 into %rdi
     call pstrlen            # get pstr2`s length
     cmpq $0, %rax           # compare between pstr2`s length and 0
     je .invalid_input       # if src`s length = 0 - jump to invalid_input section

    #check the validity of i,j:
  #   cmpq %rcx, %rdx        # compare between i and j
   #  jb .invalid_input      # if i > j - jump to invalid_input section

    # check the validity of i
     cmpq  $0, %rcx          # compare between i and 0
     jb  .invalid_input      # if i < 0 - jump to invalid_input section

     movq %r12, %rdi         # load pstr1 into %rdi
     call pstrlen            # get pstr1`s length
     cmpq %rcx, %rax         # compare between pstr1`s length and i 
     jb .invalid_input       # if i smaller then dst`s length - jump to invalid_input section

     movq %r12, %rdi         # load pstr1 into %rdi
     call pstrlen            # get pstr1`s length
     cmpq $0, %rax           # compare between pstr1`s length and 0
     je .invalid_input       # if dst`s length = 0 - jump to invalid_input section

     movq %r13, %rdi         # load pstr2 into %rdi
     call pstrlen            # get pstr2`s length
     cmpq %rcx, %rax         # compare between pstr2`s length and i
     jb .invalid_input       # if i smaller then src`s length - jump to invalid_input section


    # check the validity of j
     cmpq %rcx, %rdx         # compare between i and j
     jb .invalid_input       # if i > j - jump to invalid_input section

     movq %r12, %rdi         # load pstr1 into %rdi
     call pstrlen            # get pstr1`s length
     subq $1, %rax           # decrement 1 from pstr1`s length because the index starts
                             # from 0 to (pstr1`s len - 1)
     cmpq %rdx, %rax         # compare between pstr1`s length and j 
     #check again!!!!!!!!!!!
     jb .invalid_input       # if j smaller then dst`s length - jump to invalid_input section

    
     movq %r13, %rdi         # load pstr2 into %rdi
     call pstrlen            # get pstr2`s length
     subq $1, %rax           # decrement 1 from pstr1`s length because the index starts
                             # from 0 to (pstr1`s len - 1) 
     cmpq %rdx, %rax         # compare between pstr2`s length and j 
     jb .invalid_input       # if j bigger then dst`s length - jump to invalid_input sectio
  
     incq %r12              # increment pstr1`s address by 1 (to skip pstr1`s length)
     incq %r13              # increment pstr2`s address by 1 (to skip pstr2`s length)
     add %rcx, %r12         # go to the i`th place in pstr1`s string (similarly to go to index in array)
     add %rcx, %r13         # go to the i`th place in pstr2`s string (similarly to go to index in array)


.loop_cpy:

     cmpq %rdx, %rcx        # compare between i and j
     jg  .end_of_loop       # if i > j - we copied all pstr2 to pstr 1 so jump to end_loop section

     #copy the char from pstr2[i] to pstr1[i]
     movb  (%r13), %al         # save the current char at the i`th char of pstr2(src) into a temp %al
     movb    %al , (%r12)      # save the i`th char of pstr2(src) into the i`th char at %r12 (pstr1)


     # update loop parameters
     addq $1, %rcx           # add 1 to i
     addq $1, %r12           # add 1 to %r12, so it will point the next char in pstr1
     addq $1, %r13           # add 1 to %r13, so it will point the next char in pstr2

     jmp .loop_cpy               # jump to the start of the loop


.end_of_loop:
     mov %rsi, %rax         # set the return value to be dst
     jmp .end_cpy           # jump to the end

.invalid_input:
    movq %rdi, %rax              # load pstr1 into %rax as the return value
    movq  %rdi, %rsi             # load pstr1 into %rsi as the second argument
    mov $invalid_input_fmt, %rdi # load the invalid input msg into %rdi
    xorq %rax, %rax              # initialize %rax to 0
    call printf                  # print the msg
    jmp .end_cpy                 # jump to the end

.end_cpy:
     mov %rbp, %rsp              #initionalize stack pointer
     pop %rbp                    #pop the base pointer
     ret                         #return from the function
