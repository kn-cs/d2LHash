/* assembly to compute d2LHash1271 using d = 3, g = 4  */

#include "d2LHash1271_macro.h"
	
	.p2align 5
	.globl d2LHash1271_d3_maax_g4
	
 d2LHash1271_d3_maax_g4:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$160,%rsp

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
	
	imul	$15,%rcx,%rax
	addq	%rax,%rsi
	movq	%r8,0(%rsi)
	movq	$0,8(%rsi)	
	
	xorq 	%rdx,%rdx
	movq	%rcx,%rax
	movq	$7,%rbx
	divq	%rbx
	
	movq	%rax,88(%rsp)
	movq	%rdx,96(%rsp)	
	movq 	%r8,104(%rsp)
	movq	%rax,144(%rsp)	

	movq	64(%rsp),%rsi	
	movq    %rsi,%rcx
	
	cmpq	$0,%rax	
	je	.L0
	
.LBRW:
	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_reduce_4l()
	brw_reduce_2l()
	brw_add_block3(2,%r8,%r9,%rax)
	brw_add_block2(3,3,%r14,%r15)
	brw_mul(%r8,%r9)
	brw_store_temp(112)
	
	brw_add_block1(4,0,%r12,%r13)
	brw_add_block2(5,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_temp(112)
	brw_reduce_5l()
	brw_reduce_4l()
	brw_reduce_2l()
	brw_add_block3(6,%r8,%r9,%rax)
	brw_store_output()
	
	addq	$105,%rsi
	addq	$16,%rcx
	
	movq	144(%rsp),%rax	
	subq    $1,%rax
	movq	%rax,144(%rsp)	
	
	cmpq    $0,%rax	
	jg      .LBRW
	
	movq	72(%rsp),%rdi	
	movq	64(%rsp),%rsi
	movq	88(%rsp),%rcx
	
	addq	$64,%rdi
	
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
	
	add_msg_block1(48)
	
	addq	$64,%rsi
	subq    $4,%rcx
	
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
	mul_gammanr(48)
	jmp     .LB4

.LB1:
	movq	$0,%r12
	reduce_5limb()
	reduce_4limb()
	reduce_2limb()	

	add_msg_block1(0)
		
	jmp     .L2	
	
.LB2:
	movq	$0,%r12
	mul_gamman(0,0)
	add_product()

	reduce_5limb()
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block1(16)
		
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
	
	add_msg_block1(32)
	
	jmp     .L2
	
.L0:
	movq	$0,%r8
	movq	$0,%r9
	
	jmp	.L2	
	
.L1:
	movq	0(%rsi),%r8
	movq	8(%rsi),%r9
			
.L2:	
	movq	64(%rsp),%rsi
	movq	72(%rsp),%rdi	
	movq	80(%rsp),%rax
	movq	96(%rsp),%rcx

	subq	%rcx,%rax
	imul	$15,%rax,%rax	
	addq	%rax,%rsi		
	addq	$2,%rcx
		
	cmpq	$2,%rcx
	jg	.L3

	mul_taunr(0)
	   
	movq	$0,%r12
	reduce_5limb()	    
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block2(0)
		
	jmp     .LF	

.L3:
	cmpq	$3,%rcx
	jg	.L4
	
	mul_taunr(16)
		
	movq	$0,%r12
	mul_taun(0,0)
	add_product()
		
	reduce_5limb()
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block2(15)
	
	jmp     .LF	

.L4:	
	mul_taunr(32)	
	movq	$0,%r12	

.LH4:
	mul_taun(0,16)
	add_product()
	
	mul_taun(15,0)
	add_product()
	
	reduce_5limb()	
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block2(30)
	
	addq	$45,%rsi
	subq    $4,%rcx
	
	cmpq    $0,%rcx	
	je      .LF

.LHT1:	
	cmpq    $1,%rcx	
	jg      .LHT2
	
	mul_taunr(0)
	jmp	.LH1

.LHT2:
	cmpq    $2,%rcx	
	jg      .LHT3

	mul_taunr(16)
	jmp     .LH2

.LHT3:
	cmpq    $3,%rcx
	jg      .LHT4

	mul_taunr(32)
	jmp     .LH3

.LHT4:
	mul_taunr(48)
	
	movq	$0,%r12
	mul_taun(0,32)
	add_product()
	
	addq	$15,%rsi	
	jmp     .LH4

.LH1:
	movq	$0,%r12
	reduce_5limb()
	reduce_4limb()
	reduce_2limb()	

	add_msg_block2(0)
		
	jmp     .LF
	
.LH2:
	movq	$0,%r12
	mul_taun(0,0)
	add_product()
	    
	reduce_5limb()
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block2(15)
		
	jmp     .LF
	
.LH3:
	movq	$0,%r12
	mul_taun(0,16)
	add_product()
		
	mul_taun(15,0)
	add_product()
		
	reduce_5limb()		
	reduce_4limb()
	reduce_2limb()
	
	add_msg_block2(30)
	
.LF:
	mul_taunr(0)

	reduce_4limb()
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
