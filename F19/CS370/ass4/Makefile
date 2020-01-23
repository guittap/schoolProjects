CC := gcc
CFLAGS := -g -O2 -Wall -Werror=vla


.PHONY: all clean 

all: mfind

mfind: mfind.c
	$(CC) -o $@ $(CFLAGS) $<

clean:
	@rm -f *.o 

.SUFFIXES: .c .o  .dmp 

