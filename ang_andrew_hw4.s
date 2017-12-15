#Andrew Ang, Comp Org, Professor Dingler
#This program implements three gates, nand, or and nor using all nand gates

#Data Section
.data

#Code Section
.text


main:
#put the parameters into registers A in $a0 and B in $a1
#initialize A
    lui $a0, 0xABCD #upper bits
    ori $a0, 0xEFED #lower bits
#initialize B
    lui $a1, 0xDEAD #upper bits
    ori $a1, 0xBEEF #lower bits

#For myNAND function:
    jal myNAND # call subroutine

#for myOR Function:
    jal myOR # call subroutine

#Reinitialize because the input a and b were altered in myOR function
#Reinitialize A
    lui $a0, 0xABCD #upper bits
    ori $a0, 0xEFED #lower bits
#Reinitialize B
    lui $a1, 0xDEAD #upper bits
    ori $a1, 0xBEEF #lower bits

#for myNOR Function:
    jal myNOR # call subroutine

#exit the program
    li	$v0,10				# code for exit
    syscall					# exit program

#myNAND function
myNAND:
    and $v0, $a0, $a1 #find the and of the two values
    nor $v0, $v0, $v0 #nor the result from and, which gives you Nand
    jr $ra #go back to point after myNand is called

#myOR function (using only nand)
#1. nand value a w/ a
#2  nand value b w/b
#3. nand nanded a and nanded b
myOR:
    add $s0, $a0, $0 # creates a duplicate of input A
    add $s1, $a1, $0 # creates a duplicate of input B

#nand A with A
    add $a1, $s0, $0 #change input B to input A

    addi $sp, $sp, -4 # adjust the sp first
    sw $ra, 0($sp) # store the old RA on Stack
    jal myNAND # call subroutine
    lw $ra, 0($sp)# Restore the RA
    addi $sp, $sp, 4 # re-adjust the SP

#store the result
    add $s2, $v0, $0 #result of a nanded with a

#nand B with B
    add $a0, $s1, $0 #change input A to B
    add $a1, $s1, $0 #covert back B to original state

    addi $sp, $sp, -4 # adjust the sp first
    sw $ra, 0($sp) # store the old RA on Stack
    jal myNAND # call subroutine
    lw $ra, 0($sp)# Restore the RA
    addi $sp, $sp, 4 # re-adjust the SP

#store the result
    add $s3, $v0, $0 #result of b nanded with b

#nand A and B
    add $a0, $s2, $0 #covert input A to nanded a
    add $a1, $s3, $0 #convert input b to nanded b

    addi $sp, $sp, -4 # adjust the sp first
    sw $ra, 0($sp) # store the old RA on Stack
    jal myNAND # call subroutine
    lw $ra, 0($sp)# Restore the RA
    addi $sp, $sp, 4 # re-adjust the SP

    jr $ra # jump back to point after myOR in main


#myNor Function (using only nand)
#1. nand value a w/ a
#2  nand value b w/b
#3. nand nanded a and nanded b
#4. nand the result from step 3
myNOR:
    add $s0, $a0, $0 # creates a duplicate of input A
    add $s1, $a1, $0 # creates a duplicate of input B

#nand A with A
    add $a1, $s0, $0 #change input B to input A
    addi $sp, $sp, -4 # adjust the sp first
    sw $ra, 0($sp) # store the old RA on Stack
    jal myNAND # call subroutine
    lw $ra, 0($sp)# Restore the RA
    addi $sp, $sp, 4 # re-adjust the SP
#store the result
    add $s2, $v0, $0 #result of a nanded with a

#nand B with B
    add $a0, $s1, $0 #change input A to B
    add $a1, $s1, $0 #covert back B to original state

    addi $sp, $sp, -4 # adjust the sp first
    sw $ra, 0($sp) # store the old RA on Stack
    jal myNAND # call subroutine
    lw $ra, 0($sp)# Restore the RA
    addi $sp, $sp, 4 # re-adjust the SP

#store the result
    add $s3, $v0, $0 #result of b nanded with b

#nand A and B
    add $a0, $s2, $0 #covert input A to nanded a
    add $a1, $s3, $0 #convert input b to nanded b

    addi $sp, $sp, -4 # adjust the sp first
    sw $ra, 0($sp) # store the old RA on Stack
    jal myNAND # call subroutine
    lw $ra, 0($sp)# Restore the RA
    addi $sp, $sp, 4 # re-adjust the SP

#store result
    add $s4, $v0, $0 #store the result of nanded a nanded with nanded b
#set parameters
    add $a0, $s4, $0 #convert input a to nanded a nanded with nanded b
    add $a1, $s4, $0 #convert input a to nanded a nanded with nanded b

    addi $sp, $sp, -4 # adjust the sp first
    sw $ra, 0($sp) # store the old RA on Stack
    jal myNAND # call subroutine
    lw $ra, 0($sp)# Restore the RA
    addi $sp, $sp, 4 # re-adjust the SP

    jr $ra # jump back to point after myNOR in main









