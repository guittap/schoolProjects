problem1: prob1_guittap.c
        gcc -o prob1_guittap prob1_guittap.c -nostdlib /usr/lib/x86_64-linux-gnu/libc.a -static
                #nostdlib and libc.a binds the file to standard c libraries and static will bind it statically                                                                                              
        #ls -l prob1_guittap                                                                                                                                                                                
                #this command is just to check the size of the executable                                                                                                                                   
        #readelf -h prob1_guittap                                                                                                                                                                           
                #this is to check the size of the header files                                                                                                                                              
        #file prob1_guittap                                                                                                                                                                                 
                #this command is to check if a strip has been done yet                                                                                                                                      
        strip -s prob1_guittap
        #ls -l prob1_guittap                                                                                                                                                                                
                #check size after strip                                                                                                                                                                     
        #readelf -S prob1_guittap                                                                                                                                                                           
                #this command checks for possible elf headers that could be deleted                                                                                                                         
                #then i proceed to delete both .comment and .eh_frame                                                                                                                                       
        objcopy --remove-section .comment prob1_guittap
        #ls -l prob1_guittap                                                                                                                                                                                
        objcopy --remove-section .eh_frame prob1_guittap
        ls -l prob1_guittap