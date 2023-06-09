/* assembly to compute the key powers */

#include "d2LHash1271_macro.h"
		
	.p2align 5
	.globl d2LHash1271keypowers
		
d2LHash1271keypowers:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$56,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)

	movq    0(%rsi),%rax
	movq    8(%rsi),%rcx
	
	/* tau */
	movq    %rax,0(%rdi)
	movq    %rcx,8(%rdi)
	
	/* tau^2 */	
	tau_squaren(16)

	/* gamma = tau^4 */	
	tau_squaren(48)
	
	/* gamma^2 */
	tau_squaren(64)
	
	/* gamma^4 */
	tau_squaren(96)
	
	/* gamma^8 */
	tau_squaren(160)
	
	/* tau^3 */
	mul_tau_powers(0,16,32)
	
	/* gamma^3 */
	mul_tau_powers(48,64,80)
	
	/* gamma^5 */
	mul_tau_powers(48,96,112)
	
	/* gamma^6 */
	mul_tau_powers(48,112,128)	
	
	/* gamma^7 */
	mul_tau_powers(48,128,144)		

	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
