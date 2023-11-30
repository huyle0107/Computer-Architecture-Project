.data
	origin:			.space 49				# 49 elements, each 32 bits (4 bytes)
	player1: 		.space 49 				# 49 elements, each 32 bits (4 bytes)
	player2: 		.space 49 				# 49 elements, each 32 bits (4 bytes)
	boardPlayer1:	.space 49
	boardPlayer2:	.space 49
	input_buffer:   .space 5   				# Buffer to store user input
	play_buffer:	.space 3
	
	newline: 	.asciiz "\n"
	space:		.asciiz " "
	spaceTab:	.asciiz "                        "
	frame:		.asciiz "|"
	
	intro:		.asciiz "\n--------------------- WELCOME TO THE BATTLESHIP BOARDGAME ---------------------\n"
	intro0:		.asciiz "\nHere is some rules you must follow to play this game: \n"
	intro1:		.asciiz "      1. The values of the cells of the map will be either 1 or 0.\n"
	intro1.1:	.asciiz "      --> 1 means that the box is occupied by a ship, otherwise it is 0.\n"
	intro2:		.asciiz "      2. In detail, each player will have 3 of 2x1 ships, 2 of 3x1 ships, and 1 of 4x1 ship.\n"
	intro3:		.asciiz "      3. Note that the ships can not overlap with each other.\n"
	intro4:		.asciiz "      4. The player must enter 4 values when declaring each position of the boats, including the x and y positions where the boat starts and where the boat ends in order.\n"
	intro9:		.asciiz "      5. The player must enter 2 values when playing boardgame, which means the x and y positions in order.\n"
	intro10:	.asciiz "      6. The player 1 go first, then player 2.\n"
	intro11:	.asciiz "      7. Player only input number from 0 to 6.\n"
	intro5:		.asciiz "\n\n--------------!!!Hope you two have fun playing this boardgame!!!--------------\n\n"
	intro6:		.asciiz "\n---------------------------THE BATTLESHIP BOARDGAME---------------------------\n"
	intro7:		.asciiz "\n\n-------------------------THE BATTLESHIP BOARDGAME P1--------------------------\n"
	intro8:		.asciiz "\n\n-------------------------THE BATTLESHIP BOARDGAME P2--------------------------\n"
	
	error: 		.asciiz "\n\nPlease enter again, you have entered the wrong value according to the rules of the game!!!\n"
	
	P1_b_1:		.asciiz "\nFirst player input the position of first ship 2x1: "
	P1_b_2:		.asciiz "\nFirst player input the position of second ship 2x1: "
	P1_b_3:		.asciiz "\nFirst player input the position of third ship 2x1: "
	P1_g_1:		.asciiz "\nFirst player input the position of first ship 3x1: "
	P1_g_2:		.asciiz "\nFirst player input the position of second ship 3x1: "
	P1_y:		.asciiz "\nFirst player input the position of ship 4x1: "
	
	P2_b_1:		.asciiz "\nSecond player input the position of first ship 2x1: "
	P2_b_2:		.asciiz "\nSecond player input the position of second ship 2x1: "
	P2_b_3:		.asciiz "\nSecond player input the position of third ship 2x1: "
	P2_g_1:		.asciiz "\nSecond player input the position of first ship 3x1: "
	P2_g_2:		.asciiz "\nSecond player input the position of second ship 3x1: "
	P2_y:		.asciiz "\nSecond player input the position of ship 4x1: "

	InputStr1:  	.asciiz "\n\n[Player 1 TURN] --> input move: "
	InputStr2:  	.asciiz "\n\n[Player 2 TURN] --> input move: "
	Symbol1:	.asciiz "\n\n-------------------------THE PRESENT BOARDGAME FOR P1-------------------------\n"
	Symbol2:	.asciiz "\n\n-------------------------THE PRESENT BOARDGAME FOR P2-------------------------\n"

	errorPlay:	.asciiz "\n\nPlease enter again, you have entered the wrong fromat [out range of boardgame]!!!\n\n"
	result1:    	.asciiz "\n\n------------------------------>[Player 1] wins!!<------------------------------\n\n"
	result2:    	.asciiz "\n\n------------------------------>[Player 2] wins!!<------------------------------\n\n"
	
	msg1:		.asciiz "\n\n------------------------------------> MISS <------------------------------------\n\n"
	msg2:		.asciiz "\n\n------------------------------------> HIT <-------------------------------------\n\n"

	ContinueQues:	.asciiz "\n\nDo you want to continue? Type 1 for YES / Type 2 for NO\n"
	ContinueOpt:	.asciiz "Your option is: "
	ContinueError:  .asciiz "\n\nPlease enter again, you have entered the wrong value according to the rules of question!!!\n"

.text
startgame:
	li $t8, 0
	j introduction

###############################################################################################################################################################################################################  
##################################################################### Introduction as well as the rule of game ##################################################################################################
###############################################################################################################################################################################################################  
introduction:
	#Print all the introduction part
	li $t9, 20
	loop_newline:
		beq $t9, 0, introduction_real
		li $v0, 4           	
		la $a0, newline   	
		syscall
		addi $t9, $t9, -1
		j loop_newline
		
introduction_real:		
	li $v0, 4           	
	la $a0, intro   	
	syscall
	li $v0, 4           	
	la $a0, intro0    	
	syscall
	li $v0, 4           	
	la $a0, intro1    	
	syscall
	li $v0, 4           	
	la $a0, intro1.1    	
	syscall
	li $v0, 4           	
	la $a0, intro2    	
	syscall
	li $v0, 4           	
	la $a0, intro3    	
	syscall
	li $v0, 4           	
	la $a0, intro4    	
	syscall
	li $v0, 4           	
	la $a0, intro9    	
	syscall
	li $v0, 4           	
	la $a0, intro10    	
	syscall
	li $v0, 4           	
	la $a0, intro11    	
	syscall
	li $v0, 4           	
	la $a0, intro6    	
	syscall
main:
	# Declare the array 49 element fororigin boardgame  
	la $t0, origin   				
   	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
   	
print_board_intro:
 	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
        
	beq $t3, 7, print_line_intro 	
 	
 	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall
		
	lb $t4, 0($t0)       	# Load the value from the array
	li $v0, 1           	# System call for print_int
	move $a0, $t4        	# Set the value to print
	syscall
	
	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall

	addi $t0, $t0, 1     	# Move to the next element
	addi $t2, $t2, -1    	# Decrement the loop counter
	addi $t3, $t3, 1 
	
	bne $t2, $zero, print_board_intro  	# Repeat the loop if the counter is not zero	
	
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
		
	li $v0, 4           	
	la $a0, intro5   	
	syscall
	
	beq $t8, 0, P1_start
	beq $t8, 1, P2_start
   	  	
print_line_intro:
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
	
	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	li $t3, 0
	j print_board_intro
        
###############################################################################################################################################################################################################      
##################################################################### Player 1 declare boardgame ################################################################################################## 
###############################################################################################################################################################################################################      
P1_start:     
	li $t7, 0
	li $t8, 1
	la $t1, player1
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro7       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
        
	j print_board_P1
	
##################################################################### Player 1 declare boardgame first 2x1 ################################################################################################## 	
draw1:   
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P1_b_1      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 1
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error1 
	bgt $s2, 6, error1 
	bgt $s3, 6, error1 
	bgt $s4, 6, error1 

	blt $s1, 0, error1 
	blt $s2, 0, error1 
	blt $s3, 0, error1 
	blt $s4, 0, error1 
	
	# condition for input row 
	beq $s1, $s3, same_row1
	bne $s1, $s3, diff_row1
    	
same_row1:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 1, error1 
	bne $s1, $s3, error1
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0

	move_to_pos1:
		# move to right postion in array
		beq $s5, $s1, error1a_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1

diff_row1:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 1, error1 
	bne $s2, $s4, error1 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0
	
	move_to_pos1_1:
		# move to right postion in array
		beq $s5, $s1, error1a_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_1
		
error1:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall
	
	j P1_start

error1a_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0_row
	beq $t4, 1, error1

	step0_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1_row
		beq $t4, 1, error1

	step1_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1
        
error1a_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0_col
	beq $t4, 1, error1

	step0_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1_col
		beq $t4, 1, error1
	
	step1_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1

deaclare_board_P1:
    #Start draw a boardgame for P1
    la $t1, player1      				
    li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro7       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P1  
                        
##################################################################### Player 1 declare boardgame second 2x1 ##################################################################################################                                 
second_P1_2x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P1_b_2      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 2
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error1_sec  
	bgt $s2, 6, error1_sec  
	bgt $s3, 6, error1_sec 
	bgt $s4, 6, error1_sec  

	blt $s1, 0, error1_sec  
	blt $s2, 0, error1_sec  
	blt $s3, 0, error1_sec  
	blt $s4, 0, error1_sec 
	
	# condition for input row 
	beq $s1, $s3, same_row1_sec
	bne $s1, $s3, diff_row1_sec

same_row1_sec:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 1, error1_sec 
	bne $s1, $s3, error1_sec
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0

	move_to_pos1_sec:
		# move to right postion in array
		beq $s5, $s1, error1_sec_a_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_sec

diff_row1_sec:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 1, error1_sec 
	bne $s2, $s4, error1_sec 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0
	
	move_to_pos1_1_sec:
		# move to right postion in array
		beq $s5, $s1, error1_sec_a_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_1_sec

error1_sec:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall
	
	j second_P1_2x1
                
error1_sec_a_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0a_row
	beq $t4, 1, error1_sec

	step0a_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1a_row
		beq $t4, 1, error1_sec

	step1a_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1_sec
        
error1_sec_a_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0a_col
	beq $t4, 1, error1_sec

	step0a_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1a_col
		beq $t4, 1, error1_sec
	
	step1a_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1_sec 

deaclare_board_P1_sec:
	#Start draw a boardgame for P1
	la $t1, player1      				
	li $t2, 49
	li $t3, 0

	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro7       	# Load the newline character
	syscall

	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P1               
    	
##################################################################### Player 1 declare boardgame third 2x1 ##################################################################################################                                 
third_P1_2x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P1_b_3      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 3
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error1_third 
	bgt $s2, 6, error1_third  
	bgt $s3, 6, error1_third
	bgt $s4, 6, error1_third 

	blt $s1, 0, error1_third  
	blt $s2, 0, error1_third   
	blt $s3, 0, error1_third   
	blt $s4, 0, error1_third 
	
	# condition for input row 
	beq $s1, $s3, same_row1_third
	bne $s1, $s3, diff_row1_third
    	
same_row1_third:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 1, error1_third 
	bne $s1, $s3, error1_third
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0

	move_to_pos1_third:
		# move to right postion in array
		beq $s5, $s1, error1_third_b_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_third

diff_row1_third:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 1, error1_third
	bne $s2, $s4, error1_third 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0
	
	move_to_pos1_1_third:
		# move to right postion in array
		beq $s5, $s1, error1_third_b_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_1_third

error1_third:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall
	
	j third_P1_2x1      

error1_third_b_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0b_row
	beq $t4, 1, error1_third

	step0b_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1b_row
		beq $t4, 1, error1_third

	step1b_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1_third
        
error1_third_b_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0b_col
	beq $t4, 1, error1_third

	step0b_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1b_col
		beq $t4, 1, error1_third
	
	step1b_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1_third      

deaclare_board_P1_third:
	#Start draw a boardgame for P1
	la $t1, player1      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro7       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P1             

##################################################################### Player 1 declare boardgame first 3x1 ##################################################################################################                                 
first_P1_3x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P1_g_1      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 4
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error13_first
	bgt $s2, 6,	error13_first
	bgt $s3, 6, error13_first
	bgt $s4, 6, error13_first

	blt $s1, 0, error13_first  
	blt $s2, 0, error13_first   
	blt $s3, 0, error13_first  
	blt $s4, 0, error13_first 
	
	# condition for input row 
	beq $s1, $s3, same_row13_first
	bne $s1, $s3, diff_row13_first
    	
same_row13_first:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 2, error13_first
	bne $s1, $s3, error13_first
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0

	move_to_pos13_first:
		# move to right postion in array
		beq $s5, $s1, error13_first_c_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos13_first

diff_row13_first:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 2, error13_first
	bne $s2, $s4, error13_first 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0
	
	move_to_pos1_13_first:
		# move to right postion in array
		beq $s5, $s1, error13_first_c_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_13_first

error13_first:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall
	
	j first_P1_3x1       
        
error13_first_c_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0c_row
	beq $t4, 1, error13_first

	step0c_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1c_row
		beq $t4, 1, error13_first

	step1c_row:
		addi $t1, $t1, 1
    	lb $t4, 0($t1)

		beq $t4, 0, step2c_row
		beq $t4, 1, error13_first

	step2c_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P13_first
        
error13_first_c_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0c_col
	beq $t4, 1, error13_first

	step0c_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1c_col
		beq $t4, 1, error13_first
	
	step1c_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)

		beq $t4, 0, step2c_col
		beq $t4, 1, error13_first

	step2c_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P13_first

deaclare_board_P13_first:
    	#Start draw a boardgame for P1
    	la $t1, player1      				
    	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
        li $v0, 4           	# System call for print_str
        la $a0, intro7       	# Load the newline character
        syscall
   	
   	# Print spaceTab for better formatting
        li $v0, 4           	# System call for print_str
        la $a0, spaceTab       	# Load the newline character
        syscall
    	
    	j print_board_P1                                                                                          
    	                                                                       
##################################################################### Player 1 declare boardgame second 3x1 ##################################################################################################                                 
second_P1_3x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P1_g_2      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 5
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error13_second 
	bgt $s2, 6,	error13_second 
	bgt $s3, 6, error13_second 
	bgt $s4, 6, error13_second 

	blt $s1, 0, error13_second  
	blt $s2, 0, error13_second    
	blt $s3, 0, error13_second  
	blt $s4, 0, error13_second  
	
	# condition for input row 
	beq $s1, $s3, same_row13_second
	bne $s1, $s3, diff_row13_second
    	
same_row13_second:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 2, error13_second 
	bne $s1, $s3, error13_second
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0

	move_to_pos13_second:
		# move to right postion in array
		beq $s5, $s1, error13_second_d_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos13_second

diff_row13_second:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 2, error13_second
	bne $s2, $s4, error13_second 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0
	
	move_to_pos1_13_second:
		# move to right postion in array
		beq $s5, $s1, error13_second_d_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_13_second
	
error13_second:
	# Print frame for seperate each element
       	li $v0, 4           	
        la $a0, error   	
        syscall

        j second_P1_3x1     
        
error13_second_d_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0d_row
	beq $t4, 1, error13_second

	step0d_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1d_row
		beq $t4, 1, error13_second

	step1d_row:
		addi $t1, $t1, 1
    	lb $t4, 0($t1)

		beq $t4, 0, step2d_row
		beq $t4, 1, error13_second

	step2d_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P13_second
        
error13_second_d_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0d_col
	beq $t4, 1, error13_second

	step0d_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1d_col
		beq $t4, 1, error13_second
	
	step1d_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)

		beq $t4, 0, step2d_col
		beq $t4, 1, error13_second

	step2d_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P13_second

deaclare_board_P13_second:
	#Start draw a boardgame for P1
	la $t1, player1      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro7       	# Load the newline character
	syscall

   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P1                                                                                    

##################################################################### Player 1 declare boardgame 4x1 ##################################################################################################                                 
P1_4x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P1_y      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 6
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error_y 
	bgt $s2, 6,	error_y 
	bgt $s3, 6, error_y 
	bgt $s4, 6, error_y 

	blt $s1, 0, error_y  
	blt $s2, 0, error_y    
	blt $s3, 0, error_y 
	blt $s4, 0, error_y 
	
	# condition for input row 
	beq $s1, $s3, same_row_y
	bne $s1, $s3, diff_row_y
    	
same_row_y:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 3, error_y 
	bne $s1, $s3, error_y
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0

	move_to_pos_y:
		# move to right postion in array
		beq $s5, $s1, error_y_e_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos_y

diff_row_y:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 3, error_y
	bne $s2, $s4, error_y 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player1
	li $s5, 0
	
	move_to_pos1_y:
		# move to right postion in array
		beq $s5, $s1, error_y_e_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos1_y

error_y:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall

	j P1_4x1       

error_y_e_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0e_row
	beq $t4, 1, error_y

	step0e_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1e_row
		beq $t4, 1, error_y

	step1e_row:
		addi $t1, $t1, 1
    	lb $t4, 0($t1)

		beq $t4, 0, step2e_row
		beq $t4, 1, error_y

	step2e_row:
		addi $t1, $t1, 1
    	lb $t4, 0($t1)

		beq $t4, 0, step3e_row
		beq $t4, 1, error_y

	step3e_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1_y
        
error_y_e_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0e_col
	beq $t4, 1, error_y

	step0e_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1e_col
		beq $t4, 1, error_y

	step1e_col:
		addi $t1, $t1, 7
    	lb $t4, 0($t1)

		beq $t4, 0, step2e_col
		beq $t4, 1, error_y

	step2e_col:
		addi $t1, $t1, 7
    	lb $t4, 0($t1)

		beq $t4, 0, step3e_col
		beq $t4, 1, error_y

	step3e_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P1_y

deaclare_board_P1_y:
	#Start draw a boardgame for P1
	la $t1, player1      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro7       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P1                    
    	                                
###############################################################################################################################################################################################################                                                                          
##################################################################### Player 2 declare boardgame ################################################################################################## 
###############################################################################################################################################################################################################      
P2_start:     
	li $t7, 0
	li $t8, 0
	la $t1, player2
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro8       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
        
	j print_board_P2
	
##################################################################### Player 2 declare boardgame first 2x1 ################################################################################################## 
draw2:        
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P2_b_1      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 1
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error2
	bgt $s2, 6,	error2
	bgt $s3, 6, error2
	bgt $s4, 6, error2 

	blt $s1, 0, error2   
	blt $s2, 0, error2     
	blt $s3, 0, error2 
	blt $s4, 0, error2  
	
	# condition for input row 
	beq $s1, $s3, same_row2
	bne $s1, $s3, diff_row2
    	
same_row2:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 1, error2
	bne $s1, $s3, error2
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0

	move_to_pos2:
		# move to right postion in array
		beq $s5, $s1, error2_f_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2

diff_row2:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 1, error2
	bne $s2, $s4, error2 
	
    # Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0
	
	move_to_pos2_1:
		# move to right postion in array
		beq $s5, $s1, error2_f_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_1

error2:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall

	j P2_start    
        
error2_f_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0f_row
	beq $t4, 1, error2

	step0f_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1f_row
		beq $t4, 1, error2

	step1f_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2
        
error2_f_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0f_col
	beq $t4, 1, error2

	step0f_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1f_col
		beq $t4, 1, error2
	
	step1f_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2

deaclare_board_P2:
	#Start draw a boardgame for P1
	la $t1, player2      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro8       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P2  
                        
##################################################################### Player 2 declare boardgame second 2x1 ##################################################################################################                                 
second_P2_2x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P2_b_2      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 2
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error2_sec 
	bgt $s2, 6,	error2_sec 
	bgt $s3, 6, error2_sec 
	bgt $s4, 6, error2_sec 

	blt $s1, 0, error2_sec   
	blt $s2, 0, error2_sec      
	blt $s3, 0, error2_sec 
	blt $s4, 0, error2_sec   
	
	# condition for input row 
	beq $s1, $s3, same_row2_sec
	bne $s1, $s3, diff_row2_sec

same_row2_sec:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 1, error2_sec 
	bne $s1, $s3, error2_sec
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0

	move_to_pos2_sec:
		# move to right postion in array
		beq $s5, $s1, error2_sec_g_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_sec

diff_row2_sec:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 1, error2_sec 
	bne $s2, $s4, error2_sec 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0
	
	move_to_pos2_1_sec:
		# move to right postion in array
		beq $s5, $s1, error2_sec_g_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_1_sec

error2_sec:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall

	j second_P2_2x1        
	
error2_sec_g_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0g_row
	beq $t4, 1, error2_sec

	step0g_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1g_row
		beq $t4, 1, error2_sec

	step1g_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2_sec
        
error2_sec_g_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0g_col
	beq $t4, 1, error2_sec

	step0g_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1g_col
		beq $t4, 1, error2_sec
	
	step1g_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2_sec   

deaclare_board_P2_sec:
	#Start draw a boardgame for P1
	la $t1, player2      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro8       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P2               
    	
##################################################################### Player 2 declare boardgame third 2x1 ##################################################################################################                                 
third_P2_2x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P2_b_3      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 3
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error2_third 
	bgt $s2, 6,	error2_third 
	bgt $s3, 6, error2_third 
	bgt $s4, 6, error2_third 

	blt $s1, 0, error2_third   
	blt $s2, 0, error2_third      
	blt $s3, 0, error2_third  
	blt $s4, 0, error2_third      
	
	# condition for input row 
	beq $s1, $s3, same_row2_third
	bne $s1, $s3, diff_row2_third
    	
same_row2_third:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 1, error2_third 
	bne $s1, $s3, error2_third
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0

	move_to_pos2_third:
		# move to right postion in array
		beq $s5, $s1, error2_third_h_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_third

diff_row2_third:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 1, error2_third
	bne $s2, $s4, error2_third 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0
	
	move_to_pos2_1_third:
		# move to right postion in array
		beq $s5, $s1, error2_third_h_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_1_third
		
error2_third:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall

	j third_P2_2x1        
    
error2_third_h_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0h_row
	beq $t4, 1, error2_third

	step0h_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1h_row
		beq $t4, 1, error2_third

	step1h_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2_third
        
error2_third_h_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0h_col
	beq $t4, 1, error2_third

	step0h_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1h_col
		beq $t4, 1, error2_third
	
	step1h_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2_third  

deaclare_board_P2_third:
	#Start draw a boardgame for P1
	la $t1, player2      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro8       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P2             

##################################################################### Player 2 declare boardgame first 3x1 ##################################################################################################                                 
first_P2_3x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P2_g_1      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 4
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error23_first
	bgt $s2, 6,	error23_first
	bgt $s3, 6, error23_first
	bgt $s4, 6, error23_first  

	blt $s1, 0, error23_first   
	blt $s2, 0, error23_first      
	blt $s3, 0, error23_first 
	blt $s4, 0, error23_first    
	
	# condition for input row 
	beq $s1, $s3, same_row23_first
	bne $s1, $s3, diff_row23_first
	
same_row23_first:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 2, error23_first
	bne $s1, $s3, error23_first
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0

	move_to_pos23_first:
		# move to right postion in array
		beq $s5, $s1, error23_first_i_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos23_first

diff_row23_first:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 2, error23_first
	bne $s2, $s4, error23_first 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0
	
	move_to_pos2_13_first:
		# move to right postion in array
		beq $s5, $s1, error23_first_i_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_13_first

error23_first:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, error   	
	syscall

	j first_P2_3x1       

error23_first_i_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0i_row
	beq $t4, 1, error23_first

	step0i_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1i_row
		beq $t4, 1, error23_first

	step1i_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step2i_row
		beq $t4, 1, error23_first

	step2i_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P23_first
        
error23_first_i_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0i_col
	beq $t4, 1, error23_first

	step0i_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1i_col
		beq $t4, 1, error23_first

	step1i_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step2i_col
		beq $t4, 1, error23_first
	
	step2i_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P23_first
        	
deaclare_board_P23_first:
	#Start draw a boardgame for P1
	la $t1, player2      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro8       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P2                                                                                          
    	                                                                       
##################################################################### Player 2 declare boardgame second 3x1 ##################################################################################################                                 
second_P2_3x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P2_g_2      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 5
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error23_second 
	bgt $s2, 6,	error23_second 
	bgt $s3, 6, error23_second 
	bgt $s4, 6, error23_second 

	blt $s1, 0, error23_second   
	blt $s2, 0, error23_second     
	blt $s3, 0, error23_second 
	blt $s4, 0, error23_second    
	
	# condition for input row 
	beq $s1, $s3, same_row23_second
	bne $s1, $s3, diff_row23_second
    	
same_row23_second:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 2, error23_second 
	bne $s1, $s3, error23_second
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0

	move_to_pos23_second:
		# move to right postion in array
		beq $s5, $s1, error23_second_j_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos23_second

diff_row23_second:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 2, error23_second
	bne $s2, $s4, error23_second 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0
	
	move_to_pos2_13_second:
		# move to right postion in array
		beq $s5, $s1, error23_second_j_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_13_second
	
error23_second:
	# Print frame for seperate each element
       	li $v0, 4           	
        la $a0, error   	
        syscall

        j second_P2_3x1       

error23_second_j_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0j_row
	beq $t4, 1, error23_second

	step0j_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1j_row
		beq $t4, 1, error23_second

	step1j_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step2j_row
		beq $t4, 1, error23_second

	step2j_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P23_second
        
error23_second_j_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0j_col
	beq $t4, 1, error23_second

	step0j_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1j_col
		beq $t4, 1, error23_second

	step1j_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step2j_col
		beq $t4, 1, error23_second
	
	step2j_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P23_second

deaclare_board_P23_second:
	#Start draw a boardgame for P1
	la $t1, player2     				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro8       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P2                                                                                    

##################################################################### Player 1 declare boardgame 4x1 #########################################################################################################################                                 
P2_4x1:
	# print the first input P1
	li $v0, 4           	# System call for print_str
	la $a0, P2_y      	# Load the newline character
	syscall
	
	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, input_buffer    # Load the address of the input buffer
	li $a1, 5              	# Maximum number of characters to read
	syscall
	
	la $s0, input_buffer # Load the first byte (character) from the buffer
	li $t7, 6
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	lb $s3, 2($s0)
	lb $s4, 3($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48
	subi $s3, $s3, 48
	subi $s4, $s4, 48

	bgt $s1, 6, error_y2 
	bgt $s2, 6,	error_y2
	bgt $s3, 6, error_y2
	bgt $s4, 6, error_y2

	blt $s1, 0, error_y2  
	blt $s2, 0, error_y2   
	blt $s3, 0, error_y2
	blt $s4, 0, error_y2   
	
	# condition for input row 
	beq $s1, $s3, same_row_y2
	bne $s1, $s3, diff_row_y2
    	
same_row_y2:
	#Precheck condition
	sub $s7, $s4, $s2
	bne $s7, 3, error_y2
	bne $s1, $s3, error_y2
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0

	move_to_pos_y2:
		# move to right postion in array
		beq $s5, $s1, error_y2_k_row
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos_y2

diff_row_y2:
	#Precheck condition     
	sub $s7, $s3, $s1
	bne $s7, 3, error_y2
	bne $s2, $s4, error_y2 
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2
	la $t1, player2
	li $s5, 0
	
	move_to_pos2_y:
		# move to right postion in array
		beq $s5, $s1, error_y2_k_col
		addi $t1, $t1, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_pos2_y

error_y2:
	# Print frame for seperate each element
       	li $v0, 4           	
        la $a0, error   	
        syscall

        j P2_4x1       

error_y2_k_row:
	lb $t4, 0($t1)

	beq $t4, 0, step0k_row
	beq $t4, 1, error_y2

	step0k_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step1k_row
		beq $t4, 1, error_y2

	step1k_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step2k_row
		beq $t4, 1, error_y2

	step2k_row:
		addi $t1, $t1, 1
		lb $t4, 0($t1)
		
		beq $t4, 0, step3k_row
		beq $t4, 1, error_y2

	step3k_row:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 1
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2_y
        
error_y2_k_col:
	lb $t4, 0($t1)

	beq $t4, 0, step0k_col
	beq $t4, 1, error_y2

	step0k_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step1k_col
		beq $t4, 1, error_y2

	step1k_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step2k_col
		beq $t4, 1, error_y2
	
	step2k_col:
		addi $t1, $t1, 7
		lb $t4, 0($t1)
		
		beq $t4, 0, step3k_col
		beq $t4, 1, error_y2

	step3k_col:
		li $t4, 1
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array

		subi $t1, $t1, 7
		sb $t4, 0($t1)		# Store the value to the array
		
		j deaclare_board_P2_y
        	
deaclare_board_P2_y:
	#Start draw a boardgame for P1
	la $t1, player2      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, intro8       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_P2                                                                                         
                                                                                                                                                                                       
###############################################################################################################################################################################################################                                                                                                                                  
##################################################################### Print boardgame P1 ######################################################################################################################### 	
###############################################################################################################################################################################################################  
print_board_P1:
 	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
        
	beq $t3, 7, print_line_P1 	
 	
 	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall
		
	lb $t4, 0($t1)       	# Load the value from the array
	li $v0, 1           	# System call for print_int
	move $a0, $t4        	# Set the value to print
	syscall
	
	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall

	addi $t1, $t1, 1     	# Move to the next element
	addi $t2, $t2, -1    	# Decrement the loop counter
	addi $t3, $t3, 1 
	
	bne $t2, $zero, print_board_P1  	# Repeat the loop if the counter is not zero	
	
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
	
	beq $t7, 0, draw1
	beq $t7, 1, second_P1_2x1
	beq $t7, 2, third_P1_2x1
	beq $t7, 3, first_P1_3x1
	beq $t7, 4, second_P1_3x1	
	beq $t7, 5, P1_4x1
	beq $t7, 6, introduction
   	  	
print_line_P1:
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
	
	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	li $t3, 0
	j print_board_P1 

###############################################################################################################################################################################################################  
##################################################################### Print boardgame P2 ######################################################################################################################### 
###############################################################################################################################################################################################################  	
print_board_P2:
 	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
        
	beq $t3, 7, print_line_P2 	
 	
 	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall
		
	lb $t4, 0($t1)       	# Load the value from the array
	li $v0, 1           	# System call for print_int
	move $a0, $t4        	# Set the value to print
	syscall
	
	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall

	addi $t1, $t1, 1     	# Move to the next element
	addi $t2, $t2, -1    	# Decrement the loop counter
	addi $t3, $t3, 1 
	
	bne $t2, $zero, print_board_P2  	# Repeat the loop if the counter is not zero	
	
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
	
	beq $t7, 0, draw2
	beq $t7, 1, second_P2_2x1
	beq $t7, 2, third_P2_2x1
	beq $t7, 3, first_P2_3x1
	beq $t7, 4, second_P2_3x1	
	beq $t7, 5, P2_4x1
	beq $t7, 6, gameplay_setup	
   	  	
print_line_P2:
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
	
	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	li $t3, 0
	j print_board_P2        

###############################################################################################################################################################################################################  
##################################################################### Start gameplay this boardgame ################################################################################################## 
############################################################################################################################################################################################################### 
gameplay_setup:		
	#Print all the introduction part
	li $t8, 0
	li $t9, 40
	loop_newline1:
		beq $t9, 0, deaclare_board_current_P1
		li $v0, 4           	
		la $a0, newline   	
		syscall
		addi $t9, $t9, -1
		j loop_newline1

##################################################################### Player 1 turn ######################################################################################################################### 
P1_turn:
	li $v0, 4
	la $a0, InputStr1
	syscall

	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, play_buffer    # Load the address of the input buffer
	li $a1, 3              	# Maximum number of characters to read
	syscall
	
	la $s0, play_buffer # Load the first byte (character) from the buffer
	li $t8, 1
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48

check_position_P1:
	bgt $s1, 6, error_P1 
	bgt $s2, 6, error_P1

	blt $s1, 0, error_P1 
	blt $s2, 0, error_P1
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2

	la $t0, boardPlayer2
	li $s5, 0

	move_to_position_P1:
		# move to right postion in array
		beq $s5, $s1, input_value_P1
		addi $t0, $t0, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_position_P1

error_P1:
	li $v0, 4
	la $a0, errorPlay
	syscall

	j P1_turn

input_value_P1:
	li $t4, 1
	sb $t4, 0($t0)		# Store the value to the array

	j checkWinP2

##################################################################### Player 2 turn ######################################################################################################################### 
P2_turn:
	li $v0, 4
	la $a0, InputStr2
	syscall

	# Read the string from the user
	li $v0, 8               # System call for read_string
	la $a0, play_buffer    # Load the address of the input buffer
	li $a1, 3              	# Maximum number of characters to read
	syscall
	
	la $s0, play_buffer # Load the first byte (character) from the buffer
	
	# load each data to 4 register
	lb $s1, 0($s0)
	lb $s2, 1($s0)
	
	# Convert char to int based on ASCIIZ
	subi $s1, $s1, 48
	subi $s2, $s2, 48

check_position_P2:
	bgt $s1, 6, error_P2 
	bgt $s2, 6, error_P2

	blt $s1, 0, error_P2 
	blt $s2, 0, error_P2
	
	# Move to the postion in array $t1
	mul $s1, $s1, 7
	add $s1, $s1, $s2

	la $t0, boardPlayer1
	li $s5, 0

	move_to_position_P2:
		# move to right postion in array
		beq $s5, $s1, input_value_P2
		addi $t0, $t0, 1	# Move to the next element
		addi $s5, $s5, 1
		j move_to_position_P2

error_P2:
	li $v0, 4
	la $a0, errorPlay
	syscall

	j P2_turn

input_value_P2:
	li $t4, 1
	sb $t4, 0($t0)		# Store the value to the array

	j checkWinP1

###############################################################################################################################################################################################################                                                                                                                                  
##################################################################### Print boardgame current for P1 ################################################################################################## 	
############################################################################################################################################################################################################### 
deaclare_board_current_P1:
	#Start draw a boardgame for P1
	la $t1, boardPlayer2      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, Symbol1       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_current_P1   

print_board_current_P1:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
        
	beq $t3, 7, print_line_current_P1	
 	
 	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall
		
	lb $t4, 0($t1)       	# Load the value from the array
	li $v0, 1           	# System call for print_int
	move $a0, $t4        	# Set the value to print
	syscall
	
	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall

	addi $t1, $t1, 1     	# Move to the next element
	addi $t2, $t2, -1    	# Decrement the loop counter
	addi $t3, $t3, 1 
	
	bne $t2, $zero, print_board_current_P1  	# Repeat the loop if the counter is not zero	
	
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall

	#condition here
	beq $t8, 0, P1_turn
	beq $t8, 1, deaclare_board_current_P2
   	  	
print_line_current_P1:
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
	
	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	li $t3, 0
	j print_board_current_P1        

###############################################################################################################################################################################################################                                                                                                                                  
##################################################################### Print boardgame current for P2 ################################################################################################## 	
############################################################################################################################################################################################################### 
deaclare_board_current_P2:
	#Start draw a boardgame for P1
	la $t1, boardPlayer1      				
	li $t2, 49
   	li $t3, 0
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, Symbol2       	# Load the newline character
	syscall
   	
   	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	j print_board_current_P2   

print_board_current_P2:
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
        
	beq $t3, 7, print_line_current_P2	
 	
 	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall
		
	lb $t4, 0($t1)       	# Load the value from the array
	li $v0, 1           	# System call for print_int
	move $a0, $t4        	# Set the value to print
	syscall
	
	# Print newline for better formatting
	li $v0, 4           	
	la $a0, space     	
	syscall

	addi $t1, $t1, 1     	# Move to the next element
	addi $t2, $t2, -1    	# Decrement the loop counter
	addi $t3, $t3, 1 
	
	bne $t2, $zero, print_board_current_P2  	# Repeat the loop if the counter is not zero	
	
	# Print frame for seperate each element
	li $v0, 4           	
	la $a0, frame    	
	syscall
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall

	#condition here
	j P2_turn
   	  	
print_line_current_P2:
	# Print newline for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, newline      	# Load the newline character
	syscall
	
	# Print spaceTab for better formatting
	li $v0, 4           	# System call for print_str
	la $a0, spaceTab       	# Load the newline character
	syscall
	
	li $t3, 0
	j print_board_current_P2  

###############################################################################################################################################################################################################                                                                                                                                  
##################################################################### Check P1 win or not ######################################################################################################################### 	
############################################################################################################################################################################################################### 
checkWinP1:
	la $t0, boardPlayer1
	la $t1, player1
	li $t2, 49
   	li $t3, 0

	add $t0, $t0, $s5
	add $t1, $t1, $s5

	lb $t4, 0($t0)
	lb $t5, 0($t1)

	beq $t4, $t5, change_data2
	bne $t4, $t5, change_data3

	change_data2:
		li $t5, 0
		sb $t5, 0($t1)

		li $v0, 4
		la $a0, msg2
		syscall

		la $t1, player1

		j loop_check_P2

	change_data3:
		li $t4, 0
		sb $t4, 0($t0)

		li $v0, 4
		la $a0, msg1
		syscall

		la $t1, player1

		j loop_check_P2

	loop_check_P2:
		beq $t2, 0, out_loop_check_P2
		lb $t4, 0($t1)       	# Load the value from the array
		beq $t4, 1, count_P2
		addi $t1, $t1, 1     	# Move to the next element
		addi $t2, $t2, -1 
		j loop_check_P2

	count_P2:
		addi $t3, $t3, 1
		addi $t1, $t1, 1     	# Move to the next element
		addi $t2, $t2, -1 
		j loop_check_P2

	out_loop_check_P2:
		beq $t3, 0, P2win
		li $t8, 0
		j deaclare_board_current_P1
		
############################################################################################################################################################################################################                                                                                                                                   
############################################################# Check P2 win or not ######################################################################################################################  	
############################################################################################################################################################################################################  	
checkWinP2:
	la $t0, boardPlayer2
	la $t1, player2
	li $t2, 49
   	li $t3, 0

	add $t0, $t0, $s5
	add $t1, $t1, $s5

	lb $t4, 0($t0)
	lb $t5, 0($t1)

	beq $t4, $t5, change_data
	bne $t4, $t5, change_data1

	change_data:
		li $t5, 0
		sb $t5, 0($t1)

		li $v0, 4
		la $a0, msg2
		syscall

		la $t1, player2

		j loop_check_P1

	change_data1:
		li $t4, 0
		sb $t4, 0($t0)

		li $v0, 4
		la $a0, msg1
		syscall

		la $t1, player2

		j loop_check_P1

	loop_check_P1:
		beq $t2, 0, out_loop_check_P1
		lb $t4, 0($t1)       	# Load the value from the array
		beq $t4, 1, count_P1
		addi $t1, $t1, 1     	# Move to the next element
		addi $t2, $t2, -1 
		j loop_check_P1

	count_P1:
		addi $t3, $t3, 1
		addi $t1, $t1, 1     	# Move to the next element
		addi $t2, $t2, -1 
		j loop_check_P1

	out_loop_check_P1:
		beq $t3, 0, P1win
		j deaclare_board_current_P2

###############################################################################################################################################################################################################                                                                                                                                  
##################################################################### Print result P1 win #########################################################################################################################	
###############################################################################################################################################################################################################
P1win:
	li $v0, 4           	
	la $a0, result1   	
	syscall

	j ClearData

###############################################################################################################################################################################################################                                                                                                                                  
##################################################################### Print result P2 win ######################################################################################################################### 	
###############################################################################################################################################################################################################
P2win:
	li $v0, 4           	
	la $a0, result2   	
	syscall

	j ClearData


###############################################################################################################################################################################################################                                                                                                                                  
##################################################################### Clear all data ######################################################################################################################### 	
###############################################################################################################################################################################################################
ClearData:
	la $t0, player1
	la $t1, player2
	la $t2, boardPlayer1
	la $t3, boardPlayer2
	li $t5, 49
   	li $t4, 0

	loop_clear:
		beq $t5, 0, AskPlayer

		sb $t4, 0($t0)       	# Load the value from the array
		sb $t4, 0($t1)       	# Load the value from the array
		sb $t4, 0($t2)       	# Load the value from the array
		sb $t4, 0($t3)       	# Load the value from the array

		addi $t0, $t0, 1     	# Move to the next element
		addi $t1, $t1, 1     	# Move to the next element
		addi $t2, $t2, 1     	# Move to the next element
		addi $t3, $t3, 1     	# Move to the next element

		addi $t5, $t5, -1 

		j loop_clear


######################################################################################################################################################################################################################################                                                                                                                                  
##################################################################### Ask for continue or not ################################################################################################## 	
###############################################################################################################################################################################################################
AskPlayer:
	li $v0, 4           	
	la $a0, ContinueQues  	
	syscall

	li $v0, 4           	
	la $a0, ContinueOpt  	
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	beq $a0, 1, startgame
	beq $a0, 2, EXIT

	li $v0, 4           	
	la $a0, ContinueError 	
	syscall

	j AskPlayer
###########################################################################################################################################################################################################################################################################################################
##################################################################### EXIT #########################################################################################################################              
####################################################################################################################################################################################################################################################################################     
EXIT:
	li $v0, 10
	syscall
