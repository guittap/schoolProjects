CC := gcc
CFLAGS := -g -O2 -Wall -pthread -Werror=vla


.PHONY: all clean 

all: logwriter_gather logwriter_dumb

logwriter_dumb: logwriter_dumb.c
	$(CC) -o $@ $(CFLAGS) $<

logwriter_gather: logwriter_gather.c
	$(CC) -o $@ $(CFLAGS) $<

clean:
	@rm -f *.o logwriter_gather logwriter_dumb

.SUFFIXES: .c .o .obj .dmp 

