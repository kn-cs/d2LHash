/* assembly to compute d2LHash1271 using d = 2, g = 8  */

#include "d2LHash1271_macro.h"
	
	.p2align 5
	.globl d2LHash1271_d2_maax_g8
	
 d2LHash1271_d2_maax_g8:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$128,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)
	
	movq 	%rdi,56(%rsp)
	movq 	%rsi,64(%rsp)
	movq 	%rdx,72(%rsp)
	movq 	%rcx,80(%rsp)
	
	movq    %rdx,%rdi
	
	xorq 	%rdx,%rdx
	movq	%rcx,%rax
	movq	$3,%rbx
	divq	%rbx
	
	movq	%rax,88(%rsp)
	movq	%rdx,96(%rsp)	
	movq 	%r8,104(%rsp)	
	movq	%rax,112(%rsp)

	cmpq	$0,%rax	
	je	.L0
	
	movq    %rsi,%rcx	
	
.LBRW:
	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_reduce_4l()
	brw_reduce_2l()
	brw_add_block3(2,%r8,%r9,%rax)
	brw_store_output()
	
	addq	$45,%rsi
	addq	$16,%rcx
	
	movq	112(%rsp),%rax		
	subq    $1,%rax
	movq	%rax,112(%rsp)		
	
	cmpq    $0,%rax	
	jg      .LBRW

	movq	72(%rsp),%rdi	
	movq	64(%rsp),%rsi
	movq	88(%rsp),%rcx
	
	addq	$48,%rdi
	
	cmpq    $1,%rcx
	je      .L1
	
	movq    $0,%r8
	movq    $0,%r9
	movq    $0,%r10
	movq    $0,%r11
	
	cmpq    $2,%rcx
	je      .LB2
	
	cmpq    $3,%rcx
	je      .LB3
	
	cmpq    $4,%rcx
	je      .LB4
	
	cmpq    $5,%rcx
	je      .LB5
	
	cmpq    $6,%rcx
	je      .LB6
	
	cmpq    $7,%rcx
	je      .LB7
	
.LB8:
	movq	$0,%r12
	
	mul_gamman(0,96)
	add_product()
	
	mul_gamman(16,80)
	add_product()
	
	mul_gamman(32,64)
	add_product()
	
	mul_gamman(48,48)
	add_product()
	
	mul_gamman(64,32)
	add_product()	
	
	mul_gamman(80,16)
	add_product()
	
	mul_gamman(96,0)
	add_product()

	reduce_5limb()
	reduce_4limb()
	reduce_2limb()	
	
	add_msg_block(112)
	
	addq	$128,%rsi	

	subq    $8,%rcx
		
	cmpq    $0,%rcx	
	je      .L2

.LT1:	
	cmpq    $1,%rcx	
	jg      .LT2
	
	mul_gammanr(0)
	jmp	.LB1

.LT2:
	cmpq    $2,%rcx	
	jg      .LT3

	mul_gammanr(16)
	jmp     .LB2

.LT3:
	cmpq    $3,%rcx
	jg      .LT4

	mul_gammanr(32)
	jmp     .LB3

.LT4:
	cmpq    $4,%rcx
	jg      .LT5

	mul_gammanr(48)
	jmp     .LB4

.LT5:
	cmpq    $5,%rcx
	jg      .LT6

	mul_gammanr(64)
	jmp     .LB5

.LT6:
	cmpq    $6,%rcx
	jg      .LT7
	
	mul_gammanr(80)
	jmp     .LB6

.LT7:
	cmpq    $7,%rcx
	jg      .LT8

	mul_gammanr(96)
	jmp     .LB7

.LT8:
	mul_gammanr(112)
	jmp     .LB8
	
.LB1:
	movq	$0,%r12
	reduce_5limb()
	reduce_4limb()
	reduce_2limb()	

	add_msg_block(0)
		
	jmp     .L2	
	
.LB2:
	movq	$0,%r12
	mul_gamman(0,0)
	add_product()
	
	reduce_5limb()		    
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block(16)
		
	jmp     .L2
	
.LB3:
	movq	$0,%r12
	mul_gamman(0,16)
	add_product()
		
	mul_gamman(16,0)
	add_product()
		
	reduce_5limb()			
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block(32)
	
	jmp     .L2
	
.LB4:
	movq	$0,%r12
	mul_gamman(0,32)
	add_product()
	
	mul_gamman(16,16)
	add_product()
	
	mul_gamman(32,0)
	add_product()
	
	reduce_5limb()		
	reduce_4limb()
	reduce_2limb()	
		
	add_msg_block(48)
	
	jmp     .L2
	
.LB5:
	movq	$0,%r12
	mul_gamman(0,48)
	add_product()

	mul_gamman(16,32)
	add_product()
	
	mul_gamman(32,16)
	add_product()
	
	mul_gamman(48,0)
	add_product()
	
	reduce_5limb()	
	reduce_4limb()
	reduce_2limb()	
	
	add_msg_block(64)
	
	jmp     .L2
	
.LB6:
	movq	$0,%r12
	mul_gamman(0,64)
	add_product()
	
	mul_gamman(16,48)
	add_product()
	
	mul_gamman(32,32)
	add_product()
	
	mul_gamman(48,16)
	add_product()
	
	mul_gamman(64,0)
	add_product()
	
	reduce_5limb()
	reduce_4limb()
	reduce_2limb()	
	
	add_msg_block(80)
	
	jmp     .L2
	
.LB7:
	movq	$0,%r12
	mul_gamman(0,80)
	add_product()

	mul_gamman(16,64)
	add_product()
	
	mul_gamman(32,48)
	add_product()
	
	mul_gamman(48,32)
	add_product()
	
	mul_gamman(64,16)
	add_product()
	
	mul_gamman(80,0)
	add_product()

	reduce_5limb()	
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block(96)
	
	jmp     .L2
	
.L0:
	movq	$0,%r8
	movq	$0,%r9
	
	jmp	.L2	
	
.L1:
	movq	0(%rsi),%r8
	movq	8(%rsi),%r9
		
.L2:	
	movq	96(%rsp),%rax
	
	cmpq	$0,%rax
	je	.L3	

	cmpq	$1,%rax
	je	.L4
	
	cmpq	$2,%rax
	je	.L5
	
.L3:
	movq	72(%rsp),%rdi
	
	mul_taunr(16)

	movq	$0,%r12
	mul_len_tau(104)
	add_product()	
	
	reduce_5limb()	
	reduce_4limb()
	
	jmp	.LF
	
.L4:
	movq	72(%rsp),%rdi
	
	mul_taunr(32)

	movq	80(%rsp),%rax
	subq	96(%rsp),%rax	
	imul	$15,%rax,%rax	
	
	movq	64(%rsp),%rsi	
	addq	%rax,%rsi

	movq	$0,%r12	
	mul_taun(0,16)
	add_product()

	mul_len_tau(104)
	add_product()	

	reduce_5limb()
	reduce_4limb()
	
	jmp	.LF

.L5:	
	movq	72(%rsp),%rdi
	
	mul_taunr(48)	

	movq	80(%rsp),%rax
	subq	96(%rsp),%rax
	imul	$15,%rax,%rax	
	
	movq	64(%rsp),%rsi	
	addq	%rax,%rsi

	movq	$0,%r12	
	mul_taun(0,32)
	add_product()
	
	mul_taun(15,16)
	add_product()
	
	mul_len_tau(104)
	add_product()	
		
	reduce_5limb()
	reduce_4limb()
	
.LF:	
	reduce_2limb()
	
	make_unique()
	
	andq	mask62(%rip),%r9
	movq 	56(%rsp),%rdi
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)

	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
	
