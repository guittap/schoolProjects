//#include <stdio.h>                                                                                                                                                                                        
//no stdio.h which will be fixed with /usr/lib/x86_64-linux-gnu/libc.a                                                                                                                                      
#include<unistd.h>
#include<sys/syscall.h>
//int main(int argc, char** argv){                                                                                                                                                                          
void _start(){
  syscall(SYS_write, 0, "Hello World!\n", 14); //does syscall directly                                                                                                                                      
  //printf("Hello World!\n");                                                                                                                                                                               
  //return 0;                                                                                                                                                                                               
  syscall(SYS_exit, 0); //does sycall exit directly                                                                                                                                                         
}