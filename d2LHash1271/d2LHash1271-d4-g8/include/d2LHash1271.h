#ifndef __D2LHASH1271__
#define __D2LHASH1271__

#include "d2LHash1271_basictypes.h"

#define KEY_LENGTH 126
#define BLOCK_LENGTH 120
#define KEY_SIZE 16
#define BLOCK_SIZE 15
#define MAX_MSG_SIZE 4194315+16
#define MAX_MSG_LENGTH 33554432
#define MAX_KP_SIZE 32	

void d2LHash1271(uchar8 *,const uchar8 *,const uint64 *,const uint64);

extern void d2LHash1271_d4_maax_g8(uint64 *,const uint64 *,const uint64 *,const uint64,const uint64);
extern void d2LHash1271_keypowers(uint64 *,const uint64);

#endif
