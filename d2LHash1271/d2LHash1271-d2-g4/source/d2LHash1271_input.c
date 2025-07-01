#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "d2LHash1271.h"
#include "d2LHash1271_input.h"

void format_key(uchar8 *key, int k, char *filename) {

    	FILE *fp;
	int i,c,bit,byte;
	int no_of_bits,key_index;
	
	fp = fopen(filename,"r");

    	if (fp == NULL) {
    	
    		printf("\nError opening input key file!\n\n");
        	exit(1);
        }

	no_of_bits = 3;
	byte = 0;
	key_index = KEY_SIZE-1;
	
    	for (i = 0; i < k; ++i) {
    	
    		bit = fgetc(fp) - '0';
		byte = 2*byte + bit;
		if (no_of_bits < 8)
			no_of_bits = no_of_bits + 1;		
		else if (no_of_bits == 8) {
		
			key[key_index] = byte;
			no_of_bits = 1;
			byte = 0;
			key_index = key_index - 1;
		}
    	}
    	fclose(fp);
}

void format_msg(uchar8 *msg, int l,char *filename) {

    	FILE *fp,*fpout;
	int i,c,bit,byte,n,r;
	int no_of_bits,block_index;	
	
	fp = fopen(filename,"r");
    	if (fp == NULL) {
    	
    		printf("\nError opening input message file!\n\n");
        	exit(1);
        }
        
	fpout = fopen("./test_files/d2LHash1271_msgfile_temp.txt","w");
    	if (fpout == NULL) {
    	
    		printf("\nError opening temporary message file!\n\n");
        	exit(1);
        }
        
        n = l/120; r = l%120; n = n*120;
   	for (i = 0; i++ < n;) fputc(fgetc(fp),fpout);
        if (r>0) {
        
        	n = 120 - r;
   		for (i = 0; i++ < n;) fputc(48,fpout);
   		for (i = 0; i++ < r;) fputc(fgetc(fp),fpout);
        }
      	fclose(fp); fclose(fpout);
        
	fp = fopen("./test_files/d2LHash1271_msgfile_temp.txt","r");

    	if (fp == NULL) {
    	
    		printf("\nError opening temporary message file!\n\n");
        	exit(1);
        }
                
	no_of_bits = 1;
	byte = 0;
	block_index = BLOCK_SIZE-1;
    	while ((c = fgetc(fp)) != EOF) {

    		bit = c - 48;
		byte = 2*byte + bit;
		if (no_of_bits < 8)
			no_of_bits = no_of_bits + 1;
		else if (no_of_bits == 8) {
		
			msg[block_index] = byte;
			no_of_bits = 1;
			byte = 0;
			block_index = block_index - 1;			
    			if (block_index == -1) {

				block_index = BLOCK_SIZE-1;    		
    				msg = msg + BLOCK_SIZE;
    			}
		}
    	}
    	fclose(fp);
    	remove("./test_files/d2LHash1271_msgfile_temp.txt");    	
}

void generate_key(int k, char *filename) {

	FILE *fp;
	char c;
	int i;

	fp = fopen(filename,"w");
    	if (fp == NULL) {
    	
    		printf("\nError opening key file!\n\n");
        	exit(1);
        }

	srand(time(NULL)*k+1000);
	for (int i = 0; i < k; ++i) {
	
		c = '0' + ((rand()) % 2);
		fputc(c,fp);
	}
	fclose(fp);
}

void generate_msg(int l, char *filename) {

	FILE *fp;
	char c;
	int i;

	fp = fopen(filename,"w");
    	if (fp == NULL) {
    	
    		printf("\nError opening message file!\n\n");
        	exit(1);
        }

	srand(time(NULL)*l+1000);
	for (int i = 0; i < l; ++i) {
	
		c = '0' + ((rand()) % 2);
		fputc(c,fp);
	}
	fclose(fp);
}
