/* assembly to compute the key powers */

#include "d2LHash1271_macro.h"
		
	.p2align 5
	.globl d2LHash1271_keypowers
		
d2LHash1271_keypowers:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$64,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)
	
	/* tau^2 */	
	movq    0(%rdi),%rax
	movq    8(%rdi),%rcx
	tau_squaren(1)
	
	cmpq	$3,%rsi
	jl	.L
	
	/* tau^3 */
	mul_tau_powers(0,1,2)	
	
	cmpq	$4,%rsi
	jl	.L	

	/* tau^4 */	
	movq    16(%rdi),%rax
	movq    24(%rdi),%rcx	
	tau_squaren(3)
	
	cmpq	$5,%rsi
	jl	.L	
	
	/* tau^5 */
	mul_tau_powers(0,3,4)
	
	cmpq	$6,%rsi
	jl	.L	
	
	/* tau^6 */
	mul_tau_powers(0,4,5)
	
	cmpq	$13,%rsi
	jl	.L	
	
	/* tau^7 */
	mul_tau_powers(0,5,6)	
	
	cmpq	$14,%rsi
	jl	.L	
	
	/* tau^8 */
	movq    48(%rdi),%rax
	movq    56(%rdi),%rcx		
	tau_squaren(7)
	
	cmpq	$30,%rsi
	jl	.L	
	
	/* gamma = tau^16 */	
	tau_squaren(8)	
	
	cmpq	$45,%rsi
	jl	.L		
	
	/* gamma^2 */
	tau_squaren(9)
	
	cmpq	$60,%rsi
	jl	.L	
	
	/* gamma^3 */
	mul_tau_powers(8,9,10)	
	
	cmpq	$75,%rsi
	jl	.L	
	
	/* gamma^4 */
	movq    144(%rdi),%rax
	movq    152(%rdi),%rcx	
	tau_squaren(11)
	
	cmpq	$90,%rsi
	jl	.L	
		
	/* gamma^5 */
	mul_tau_powers(8,11,12)
	
	cmpq	$105,%rsi
	jl	.L	
	
	/* gamma^6 */
	mul_tau_powers(8,12,13)
	
	cmpq	$120,%rsi
	jl	.L	
	
	/* gamma^7 */
	mul_tau_powers(8,13,14)
	
	cmpq	$240,%rsi
	jl	.L	
	
	/* gamma^8 */
	movq    176(%rdi),%rax
	movq    184(%rdi),%rcx	
	tau_squaren(15)
		
.L:
	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
