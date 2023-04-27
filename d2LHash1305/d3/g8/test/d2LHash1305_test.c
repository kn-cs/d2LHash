#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "d2LHash1305.h"
#include "measure.h"

#define change_input(x,y,z)  {x[0] = y[0]^z[0];}
#define FILE stdout

int main(int argc, char **argv) {

	uint64 i,l,n,r,kp[45];

	uchar8 h[BLOCK_SIZE]={0};

	uchar8 k[KEY_SIZE] = {
		0x4b,0x4d,0xdc,0xd9,0x36,0xed,0x20,0xf0,
		0xde,0x16,0xbf,0x1d,0x00,0x93,0x34,0x66
	};
	
	uchar8 m[MSG_SIZE] = {
		#include "message.txt"
	};
	
	if (argc != 2) { 
		fprintf(FILE,"\nNo of arguments mismatch. Aborting!\n\n" );
		exit(1);
	}
	l = atoi(argv[1]);
	if (l < 0 || l > 65536) {
		fprintf(FILE,"\nInput to the program out of range. Aborting!\n\n" );
		exit(1);
	}	

	d2LHash1305keypowers(kp,(uint64 *)k); 	

	d2LHash1305(h,m,kp,l); fprintf(FILE,"\n");
	
	fprintf(FILE,"Hash of the message: "); 
	for (i=KEY_SIZE-1;i>0;--i) fprintf(FILE,"%x",h[i]); fprintf(FILE,"%x",h[0]); fprintf(FILE,"\n\n");

	#define TIME
	#ifdef TIME
     	fprintf(FILE,"Computing CPU-cycles...\n\n");	
	n = l%8 == 0 ? l/8 : l/8+1;
	if (l == 0) n = 1;
	srand(time(0));
	for(i=0; i<KEY_SIZE; ++i) k[i] = rand() % 0xFF;
     	for(i=0; i<n       ; ++i) m[i] = rand() % 0xFF;	

	MEASURE_TIME({d2LHash1305(h,m,kp,l);change_input(m,h,kp);});
	fprintf(FILE,"CPU-cycles per byte for computing d2LHash1305 using maax type computation on a message of length %llu bits: %6.4lf\n\n", l,((get_median())/(double)(n*N)));
	
	MEASURE_TIME({d2LHash1305keypowers(kp,(uint64 *)k);d2LHash1305(h,m,kp,l);change_input(m,h,kp);});
	fprintf(FILE,"CPU-cycles per byte for computing d2LHash1305 using maax type computation on a message of length %llu bits including time for computing key-powers: %6.4lf\n\n", l,((get_median())/(double)(n*N)));		
	#endif

	return 0;
}
