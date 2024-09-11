###########################################################################
#  Name: Isabella
#  Assignment: MIPS #2
#  Description:  Calculate the surface area of a 3D trapezoid.
#				 Become more familiar with MIPS arithmetic.
#				 Be able to print data neatly.

#  CS 218, MIPS Assignment #2
###########################################################
#  data segment

.data

aSides:		.word	   10,    14,    13,    37,    54
		.word	   31,    13,    20,    61,    36
		.word	   14,    53,    44,    19,    42
		.word	   27,    41,    53,    62,    10
		.word	   19,    28,    14,    10,    15
		.word	   15,    11,    22,    33,    70
		.word	   15,    23,    15,    63,    26
		.word	   24,    33,    10,    61,    15
		.word	   14,    34,    13,    71,    81
		.word	   38,    73,    29,    17,    93

bSides:		.word	  233,   214,   273,   231,   215
		.word	  264,   273,   274,   223,   256
		.word	  244,   252,   231,   242,   256
		.word	  215,   224,   236,   275,   246
		.word	  213,   223,   253,   267,   235
		.word	  204,   229,   264,   267,   234
		.word	  216,   213,   264,   253,   265
		.word	  226,   212,   257,   267,   234
		.word	  217,   214,   217,   225,   253
		.word	  223,   273,   215,   206,   213

cSides:		.word	  125,   124,   113,   117,   123
		.word	  134,   134,   156,   164,   142
		.word	  206,   212,   112,   131,   246
		.word	  150,   154,   178,   188,   192
		.word	  182,   195,   117,   112,   127
		.word	  117,   167,   179,   188,   194
		.word	  134,   152,   174,   186,   197
		.word	  104,   116,   112,   136,   153
		.word	  132,   151,   136,   187,   190
		.word	  120,   111,   123,   132,   145

dSides:		.word	  157,   187,   199,   111,   123
		.word	  124,   125,   126,   175,   194
		.word	  149,   126,   162,   131,   127
		.word	  177,   199,   197,   175,   114
		.word	  164,   141,   142,   173,   166
		.word	  104,   146,   123,   156,   163
		.word	  121,   118,   177,   143,   178
		.word	  112,   111,   110,   135,   110
		.word	  127,   144,   210,   172,   124
		.word	  125,   116,   162,   128,   192

heights:	.word	  117,   114,   115,   172,   124
		.word	  125,   116,   162,   138,   192
		.word	  111,   183,   133,   130,   127
		.word	  111,   115,   158,   113,   115
		.word	  117,   126,   116,   117,   227
		.word	  177,   199,   177,   175,   114
		.word	  194,   124,   112,   143,   176
		.word	  134,   126,   132,   156,   163
		.word	  124,   119,   122,   183,   110
		.word	  191,   192,   129,   129,   122

lengths:	.word	  135,   226,   162,   137,   127
		.word	  127,   159,   177,   175,   144
		.word	  179,   153,   136,   140,   235
		.word	  112,   154,   128,   113,   132
		.word	  161,   192,   151,   213,   126
		.word	  169,   114,   122,   115,   131
		.word	  194,   124,   114,   143,   176
		.word	  134,   126,   122,   156,   163
		.word	  149,   144,   114,   134,   167
		.word	  143,   129,   161,   165,   136

surfaceAreas:	.space	200

len:		.word	50

saMin:		.word	0 
saMid:		.word	0 
saMax:		.word	0 
saSum:		.word	0 
saAve:		.word	0 


# -----

hdr:	.ascii	"MIPS Assignment #2 \n"
	.ascii	"  3D Trapezoid Total Surface Areas Program:\n"
	.ascii	"  Also finds minimum, middle value, maximum, \n"
	.asciiz	"  sum, and average for the surface areas.\n\n"

a1_st:	.asciiz	"\nSurface Areas Minimum = "
a2_st:	.asciiz	"\nSurface Areas Middle  = "
a3_st:	.asciiz	"\nSurface Areas Maximum = "
a4_st:	.asciiz	"\nSurface Areas Sum     = "
a5_st:	.asciiz	"\nSurface Areas Average = "

newLn:	.asciiz	"\n"
blnks:	.asciiz	"  "


###########################################################
#  text/code segment

# --------------------
#  MIPS Assignment #2, compute total surface areas.
#  Also finds min, middle, max, sum, and average.

.text
.globl main
.ent main
main:

# -----
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

##########################################################

#   Initialize
la $s0, aSides			# set $s0 addr of aSides
la $s1, bSides			# set $s1 addr of bSides
la $s2, cSides			# set $s2 addr of cSides
la $s3, dSides			# set $s3 addr of dSides
la $s4, lengths			# set $s4 addr of lengths
la $s5, heights			# set $s0 addr of heights
lw $t0, len				# set $t0 to length
li $s7, 0				# counter

calcLoop:	
	lw $t6, ($s4)		# get lengths[n]
	lw $t7, ($s5)		# get heights[n]

	mul $t7, $t7, $t6	# length * heights

	lw $t6, ($s0)		# get aSides[n]
	mul $t6, $t6, $t7	# aSides[n] * (l[n]*h[n])

	lw $t8, ($s1)		# get bSides[n]
	mul $t8, $t8, $t7	# bSides[n] * (l[n]*h[n])

	addu $t6, $t6, $t8  # aSides[n] * (l[n]*h[n]) + bSides[n] * (l[n]*h[n])

	lw $t8, ($s2)		# get cSides[n]
	lw $t7, ($s4)		# get lengths[n]
	mul $t8, $t8, $t7	# length[n] * cSides[n]

	lw $t9, ($s3)		# get dSides[n]
	mul $t9, $t9, $t7	# length[n] * dSides[n]

	addu $t9, $t9, $t8  # length[n] * cSides[n] + length[n] * dSides[n]
	addu $t6, $t6, $t9	# full surface area calculation

	sw $t6, surfaceAreas($s7)	# store @ surfaceAreas[n]

	addu $s0, $s0, 4	# increment addr by word-size
	addu $s1, $s1, 4	# ...
	addu $s2, $s2, 4	# ...
	addu $s3, $s3, 4	# ...
	addu $s4, $s4, 4	# ...
	addu $s5, $s5, 4	# ...
	addu $s7, $s7, 4	# increment accessor counter
	subu $t0, $t0, 1	# decrement loop counter
bnez $t0, calcLoop

#	************* PRINT AREA LIST ***************
	lw $t0, len		# set $t0 to length
	li $t1, 0
	printLoop:
		beq $t0, $zero, endPrint		# check index

		lw $t9, surfaceAreas($t1)		# grab area[n]

		addu $t1, $t1, 4				# increment for next accessor
		subu $t0, $t0, 1				# decrement counter

		# Prints current number
		li $v0, 1
		move $a0, $t9
		syscall	

		# Prints spaces
		li $v0, 4
		la $a0, blnks
		syscall	

		j printLoop

	endPrint:
# --------------------------------------------------------

lw $t0, len				# set $t0 to length
la $s6, surfaceAreas	# set $s6 addr of surfaceAreas
lw $t1, ($s6)			# set min to first word in array
lw $t2, ($s6)			# set max to first word in array
li $t9, 2

dataLoop:	lw $t6, ($s6)	# get array[n]

#	** Running Sum **
	add $t4, $t4, $t6		# sum = current sum + [n]
#	***********************
#	** Median **            # length is even, therefore...
	beq $t0, 25, asetMed	# add index 1
	beq $t0, 26, asetMed    # and add index 2 together
	medDone:
#	***********************
#	**Minimum and Maximum**		
	blt $t6,  $t1, aifMin		# check if new min
	bgt $t6,  $t2, aifMax		# check if new max
	endMinMax:
#	***********************
	subu $t0, $t0, 1				# decrement counter
	addu $s6, $s6, 4				# increment address by word-size
bnez $t0, dataLoop					# loop only if index is not exceeded

# Storing values
sw $t4, saSum			# store sum
sw $t1, saMin			# store min
sw $t2, saMax			# store max

# calculate and store average
lw $t0, len				# set $t0 to length
divu $t4, $t4, $t0		# divide sum by length	
sw $t4, saAve			# store average

# calculate median
div $t3, $t3, $t9		# divide added median indexes by 2
sw $t3, saMid			# store median

b next
# *********JUMPS*****************
asetMed:
	addu $t3, $t3, $t6			# keep track of sum for median
	b medDone
aifMin:
	move $t1, $t6				# set new min	
	b endMinMax
aifMax:
	move $t2, $t6				# set new max
	b endMinMax
# ********************************
next:

##########################################################
#  Display results.

	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, saMin
	li	$v0, 1
	syscall				# print min

# -----
#  Print middle message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "med = "

	lw	$a0, saMid
	li	$v0, 1
	syscall				# print mid

# -----
#  Print max message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, saMax
	li	$v0, 1
	syscall				# print max

# -----
#  Print sum message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, saSum
	li	$v0, 1
	syscall				# print sum

# -----
#  Print average message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, saAve
	li	$v0, 1
	syscall				# print average

# -----
#  Done, terminate program.

endit:
	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main

