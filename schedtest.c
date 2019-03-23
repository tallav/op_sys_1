#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv)
{
    int pid;
    pid = fork(); 
    if(pid == 0){ /*child code*/
        printf("child process");
    }else{ /*parent code*/
        wait(0);
    }
    exit(0);
}
