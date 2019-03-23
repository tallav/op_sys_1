#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(void)
{
    int pid;
    pid = fork(); 
    if(pid == 0){ /*child code*/
        ls();
    }else{ /*parent code*/
        wait(0);
    }
    exit(0);
}
