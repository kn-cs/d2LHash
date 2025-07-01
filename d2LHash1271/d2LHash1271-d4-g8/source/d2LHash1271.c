#include "d2LHash1271.h"

void d2LHash1271(uchar8 *h,const uchar8 *m,const uint64 *k,const uint64 l) {

	uint64 i,n,r,s,*q;
	uchar8 *p;
	
	if (l == 0) {
	
		q = (uint64 *)h;
		*q = 0; *(q+1) = 0;
		return;
	}
	
	s = l / BLOCK_LENGTH; r = l % BLOCK_LENGTH; 	
	if (r > 0) s = s + 1;	
	
	/* compute the hash of the message 
	 *  h: stores the hash
	 *  m: input message
	 *  k: base address of key powers array
	 *  s: number of blocks
	 *  l: bit-size of the message
	 */	 
	d2LHash1271_d4_maax_g8((uint64 *)h,(uint64 *)m,k,s,l);
}
