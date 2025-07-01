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
	
	cmpq	$5,%rsi
	jl	.L
	
	/* tau^3 */
	mul_tau_powers(0,1,2)	
	
	cmpq	$6,%rsi
	jl	.L	
	
	/* tau^4 */	
	movq    16(%rdi),%rax
	movq    24(%rdi),%rcx		
	tau_squaren(3)
	
	cmpq	$15,%rsi
	jl	.L	
	
	/* tau^8 */	
	tau_squaren(4)
	
	cmpq	$30,%rsi
	jl	.L	
	
	/* gamma = tau^16 */	
	tau_squaren(5)
	
	cmpq	$45,%rsi
	jl	.L	
	
	/* gamma^2 */
	tau_squaren(6)
	
	cmpq	$60,%rsi
	jl	.L	
	
	/* gamma^3 */
	mul_tau_powers(5,6,7)	
	
	cmpq	$120,%rsi
	jl	.L	
	
	/* gamma^4 */
	movq    96(%rdi),%rax
	movq    104(%rdi),%rcx	
	tau_squaren(8)
	
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
