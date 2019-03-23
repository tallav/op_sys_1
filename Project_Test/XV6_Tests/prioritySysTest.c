#include "../../param.h"
#include "../../types.h"
#include "../../stat.h"
#include "../../user.h"
#include "../../fs.h"
#include "../../fcntl.h"
#include "../../syscall.h"
#include "../../traps.h"
#include "../../memlayout.h"

int main(int argc, char *argv[]){
    
    printf(1,"Calling priority system call with correct args\n");
    priority(4);

    printf(1,"Calling priority system call with correct args\n");
    priority(1);

    printf(1,"Calling priority system call with correct args\n");
    priority(9);

    printf(1,"Calling priority system call with correct args\n");
    priority(10);

    printf(1,"Calling priority system call with correct args\n");
    priority(0);

    printf(1,"Calling priority system call with correct args\n");
    priority(5);

    printf(1,"Calling priority system call with wrong args\n");
    priority(-20);

    printf(1,"Calling priority system call with wrong args\n");
    priority(-1);

    printf(1,"Calling priority system call with wrong args\n");
    priority(11);

    exit(0);
}
