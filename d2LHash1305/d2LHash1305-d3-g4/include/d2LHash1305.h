#ifndef __D2LHASH1305__
#define __D2LHASH1305__

#include "d2LHash1305_basictypes.h"

#define KEY_LENGTH 128
#define BLOCK_LENGTH 128
#define KEY_SIZE 16
#define BLOCK_SIZE 16
#define MAX_MSG_SIZE 4194304+16
#define MAX_MSG_LENGTH 33554432
#define MAX_KP_SIZE 24

void d2LHash1305(uchar8 *,const uchar8 *,const uint64 *,const uint64);

extern void d2LHash1305_d3_maax_g4(uint64 *,const uint64 *,const uint64 *,const uint64,const uint64);
extern void d2LHash1305_keypowers(uint64 *,const uint64);

#endif
