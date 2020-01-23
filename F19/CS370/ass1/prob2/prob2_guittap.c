#include <stdio.h>
#include <sys/time.h> //used for timeval structure
#include <time.h>
#include <unistd.h> //used for system call
#include <fcntl.h> //used for O_RDONLY

int main(void){
    //constants
    const double reps = 100000; //amount of repetitions
    const double micro = 1000000; //micro seconds
    const double nano = 1000000000; //nano seconds
    
    //variables
    int fd = 0;
    unsigned char buffer[10];
    double pidSum = 0, openSum = 0, readSum = 0;
    double pidTime = 0, openTime = 0, readTime = 0;
    struct timeval start, end;
    FILE *outFile; //declaration of output file
    outFile = fopen("output_guittap.txt", "w");

    //header
    printf("Syscall      repetitions    time elapsed (micro sec)     latency (nano sec)\n");
    printf("---------------------------------------------------------------------------\n");

    //getpid()
    for(int i = 0; i < reps; i++) {
        gettimeofday(&start,NULL);
        getpid();
        gettimeofday(&end,NULL);
        pidSum += (end.tv_sec - start.tv_sec)*micro + end.tv_usec - start.tv_usec;
    }
    pidTime = pidSum / reps / micro * nano; //calculates latency
    printf("getpid():    %.0f         %.0f                 %.2f\n", reps, pidSum, pidTime);
    
    //open()
    for(int j = 0; j < reps; j++) {
        gettimeofday(&start,NULL);
        fd = open("/dev/null", O_RDONLY);
        gettimeofday(&end,NULL);
        close(fd); //makes sure the file closes before reopen
        openSum += (end.tv_sec - start.tv_sec)*micro + end.tv_usec - start.tv_usec;
    }
    openTime = openSum / reps / micro * nano; //calculates latency
    printf("open():      %.0f         %.0f                 %.2f\n", reps, openSum, openTime);
    
    //read()
    fd = open("/dev/zero",O_RDONLY);
    for(int k = 0; k < reps; k++) {
        gettimeofday(&start,NULL);
        read(fd, buffer, 1);
        gettimeofday(&end,NULL);
        readSum += (end.tv_sec - start.tv_sec)*micro + end.tv_usec - start.tv_usec;
    }
    close(fd);
    readTime = readSum / reps / micro * nano; //calculates latency
    printf("read():      %.0f         %.0f                 %.2f\n", reps, readSum, readTime);

    //output.txt
    fprintf(outFile, "Syscall      repetitions    time elapsed (micro sec)     latency (nano sec)\n");
    fprintf(outFile, "---------------------------------------------------------------------------\n");
    fprintf(outFile, "getpid():    %.0f         %.0f                 %.2f\n", reps, pidSum, pidTime);
    fprintf(outFile, "open():      %.0f         %.0f                 %.2f\n", reps, openSum, openTime);
    fprintf(outFile, "read():      %.0f         %.0f                 %.2f\n", reps, readSum, readTime);
    
    fclose(outFile);
    return 0;
}