#include <stdio.h>
#include<fcntl.h>
#include <sys/time.h>
#include<time.h>
#define MAX 1000

int main()
{
    int pid;
    int i,fd ;
    char c[12];
    FILE *fp;
    struct timeval start,end;
    double time1,time2,time3;
    fp=fopen("output.txt","w");

    if(!fp)
    {
        printf("Not able to open the file output.txt\n");
        return -1;
    }
    for(i = 0; i < MAX ; i++)
    {
        gettimeofday(&start,NULL);
        system(pid = getpid());
    }

    gettimeofday(&end,NULL);
    time1 = ((end.tv_sec - start.tv_sec) + (end.tv_usec - start.tv_usec) / 1000000.0)/MAX;
    printf("getpid(): %.10f %.10f\n",time1*1000000,time1*1000000000);
    fprintf(fp,"getpid():%.10f %.10f\n",time1*1000000,time1*1000000000);

    for(i = 0; i < MAX ; i++)
    {
        gettimeofday(&start,NULL);
        system(open("/dev/null", O_RDONLY ));
    }
    gettimeofday(&end,NULL);
    time2 = ((end.tv_sec - start.tv_sec) + (end.tv_usec - start.tv_usec) / 1000000.0)/MAX;
    printf("open(): %.10f %.10f\n",time2*1000000,time2*1000000000);
    fprintf(fp,"open():%.10f %.10f\n",time2*1000000,time2*1000000000);
    fd = open("/dev/dev",O_RDONLY );
    for(i = 0; i < MAX ; i++)
    {
        gettimeofday(&start,NULL);
        system( read(fd,c,10));
    }
    gettimeofday(&end,NULL);
    time3 = ((end.tv_sec - start.tv_sec) + (end.tv_usec - start.tv_usec) / 1000000.0)/MAX;

    printf("read(): %.10f %.10f\n",time3*1000000,time3*1000000000);
    fprintf(fp,"read(): %.10f %.10f\n",time3*1000000,time3*1000000000);

    return 0;
}