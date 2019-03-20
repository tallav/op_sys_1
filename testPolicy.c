// Shell.
#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(void)
{
    int pid;
    int status;

    pid = fork(); 
    if(pid == 0){ /*child code*/
        policy(0);
        policy(2);
    }else{ /*parent code*/
        policy(3);
    }
    wait(&status);
        
    exit(0);
}
