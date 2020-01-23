/*  
 *  Copyright (c) 2019, Jisoo Yang - All rights reserved.
 *
 *  This is written as part of CS 370 project
 *  
 *  Writen by Jisoo Yang <jisoo.yang@unlv.edu>  
 */

#include <unistd.h>
#include <errno.h>
#include <assert.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#include <pthread.h>

#define bailout(msg) \
        do { perror(msg); exit(EXIT_FAILURE); } while (0)

#define bailout_en(en, msg) \
        do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)

struct thread_info {
    pthread_t handle;	// thread handle
    int id;		// worker thread ID
    int fd_record;	// log record file descriptor
    int max_count;	// max count
};

// 32-byte record
#define RLEN (32)
typedef struct _record {
    char buf[RLEN];
} record_t;


ssize_t write_record(struct thread_info* ti, const record_t* r) {
    ssize_t n;
    n = write(ti->fd_record, r, sizeof(*r));
    if (n != sizeof(*r)) bailout("message (write) failed");
    return n;
}

void* producer_main(void* arg)
{
    struct thread_info* ti = (struct thread_info*)arg;
    record_t rec;
    int i, len;
    
    memset(&rec, 0, sizeof(rec));

    for (i = 0; i < ti->max_count; i++) {
	len = snprintf(rec.buf, RLEN, "id:%- 5d, seq:%- 16d ", ti->id, i);
	if (len != RLEN-1) bailout("snprintf clipped");
	rec.buf[RLEN-1] = '\n';
	write_record(ti, &rec);
    }
    
    return ti;
}


#define NTHREADS (4)
struct thread_info threads[NTHREADS];

int main(int argc, char** argv)
{
    int s, i, fd;
    struct thread_info* ti;

    fd = open("logfile.txt", O_WRONLY | O_CREAT | O_TRUNC, 
	    S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1) bailout("logfile open failed");

    for (i = 0; i < NTHREADS; i++) {
	ti = &threads[i];
	ti->id = i;
	ti->fd_record = fd;
	ti->max_count = 1024*32;
	s = pthread_create(&ti->handle, NULL, &producer_main, ti);
	if (s) bailout_en(s, "pthread_create: ");
    }

    for (i = 0; i < NTHREADS; i++) {
	struct thread_info* ptr;
	ti = &threads[i];
	s = pthread_join(ti->handle, (void**)&ptr);
	assert(ptr == ti);
    }
    
    printf("main ends\n");
    return 0;
}
