INCDRS = -I../include/

SRCFLS = ../source/d2LHash1271_const.S	\
	 ../source/d2LHash1271_d4_maax_g4.S	\
	 ../source/d2LHash1271_keypowers.S	\
	 ../source/d2LHash1271_input.c	\
	 ../source/d2LHash1271.c
         
OBJFLS = ../source/d2LHash1271_const.o 	\
	 ../source/d2LHash1271_d4_maax_g4.o	\
	 ../source/d2LHash1271_keypowers.o	\
	 ../source/d2LHash1271_input.o 	\
	 ../source/d2LHash1271.o

TESTSRC = ./d2LHash1271_d4_g4_verify.c
TESTOBJ = ./d2LHash1271_d4_g4_verify.o

SPEEDSRC = ./d2LHash1271_d4_g4_speed.c
SPEEDOBJ = ./d2LHash1271_d4_g4_speed.o

RECORDSRC = ./d2LHash1271_d4_g4_record_speed.c
RECORDOBJ = ./d2LHash1271_d4_g4_record_speed.o
	  
EXE1    = d2LHash1271_d4_g4_verify
EXE2    = d2LHash1271_d4_g4_speed
EXE3    = d2LHash1271_d4_g4_record_speed

CFLAGS = -march=native -mtune=native -m64 -O3 -funroll-loops -fomit-frame-pointer

CC     = gcc-10
LL     = gcc-10

all:	$(EXE1) $(EXE2) $(EXE3)

$(EXE1): $(TESTOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(TESTOBJ) -lm
	
$(EXE2): $(SPEEDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(SPEEDOBJ) -lm -lcpucycles
	
$(EXE3): $(RECORDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(RECORDOBJ) -lm -lcpucycles

.c.o:
	$(CC) $(INCDRS) $(CFLAGS) -o $@ -c $<

clean:
	-rm $(EXE1) $(EXE2) $(EXE3)
	-rm $(TESTOBJ) $(SPEEDOBJ) $(RECORDOBJ)
	-rm $(OBJFLS)
