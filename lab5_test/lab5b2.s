 ##################################### 
 # Written by Andreas Papadopoulos   #
 # http://akomaenablog.blogspot.com  #
 # akoma1blog@yahoo.com              #
 #####################################
.data
.align 1
String: .space 14 #*change
msg1: .asciiz "Pls give a character: "
msg2: .asciiz "\n"
msg3: .asciiz "String is: "
msg4: .asciiz "\nString Reversed is: "
.text
.global	myprog
.text


.ent	myprog
myprog:

addi $s0,$zero,13 #*change
addi $t0,$zero,0

in:
la $a0,msg2
li $v0,4
syscall

li $v0,4
la $a0,msg1
syscall
li $v0,12
syscall

add $t1,$v0,$zero
sb $t1,String($t0)
addi $t0,$t0,1
slt $t1,$s0,$t0
beq $t1,$zero,in

sb $zero,String($t0) #ending zero

la $a0,msg2
li $v0,4
syscall
la $a0,msg2
li $v0,4
syscall
la $a0,msg3
li $v0,4
syscall

la $a0,String
li $v0,4
syscall

addi $a1,$zero,14 #pass length-*change
jal stringreverse #reverse

la $a0,msg2
li $v0,4
syscall

la $a0,msg4
li $v0,4
syscall

la $a0,String
li $v0,4
syscall

li $v0,10
syscall


stringreverse:

add $t0,$a0,$zero #beginning address

add $t1,$zero,$zero  #i=0
addi $t2,$a1,-1   #j=length-1

loop:

add $t3,$t0,$t1
lb $t4,0($t3) #lb String[i]

add $t5,$t0,$t2
lb $t6,0($t5) #lb String[j]

sb $t4,0($t5) #String[j]=String[i]
sb $t6,0($t3) #String[i]=String[j]

addi $t1,$t1,1 #i++
addi $t2,$t2,-1 #j--
#if i>=j break - $t1<$t2
slt $t6,$t2,$t1
beqz $t6,loop

jr $ra

.end	myprog

#i-0;j=length-1;
# do {
# x = str[i]
# str[i]=str[j]
# str[j] = x
# i++;j--;
# } while(!(j<i))

 ##################################### 
 # Written by Andreas Papadopoulos   #
 # http://akomaenablog.blogspot.com  #
 # akoma1blog@yahoo.com              #
 #####################################