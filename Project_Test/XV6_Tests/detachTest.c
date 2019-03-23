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
    int pidChild1;
    int pidChild2;
    int pidChild3;
    int pidChild4;
    int pidChild5;
    int pidChild6;
    int detachResult;
    int secToWait = 500;
    
    if((pidChild1 = fork()) == 0){
        sleep(secToWait);
        exit(secToWait);
    }

    if((pidChild2 = fork()) == 0){
        sleep(secToWait);
        exit(secToWait);
    }

    if((pidChild3 = fork()) == 0){
        sleep(secToWait);
        exit(secToWait);
    }

    if((pidChild4 = fork()) == 0){
        sleep(secToWait);
        exit(secToWait);
    }

    if((pidChild5 = fork()) == 0){
        sleep(secToWait);
        exit(secToWait);
    }

    if((pidChild6 = fork()) == 0){
        sleep(secToWait);
        exit(secToWait);
    }
    
    detachResult = detach(77);
    printf(1,"detach result for not my child is: %d\n",detachResult);

    detachResult = detach(pidChild1);
    printf(1,"detach result for child 1 is: %d\n",detachResult);

    detachResult = detach(pidChild2);
    printf(1,"detach result for child 2 is: %d\n",detachResult);

    detachResult = detach(pidChild3);
    printf(1,"detach result for child 3 is: %d\n",detachResult);

    detachResult = detach(pidChild4);
    printf(1,"detach result for child 4 is: %d\n",detachResult);

    detachResult = detach(pidChild5);
    printf(1,"detach result for child 5 is: %d\n",detachResult);

    detachResult = detach(pidChild6);
    printf(1,"detach result for child 6 is: %d\n",detachResult);

    detachResult = detach(105);
    printf(1,"detach result for not my child is: %d\n",detachResult);

    detachResult = detach(pidChild1);
    printf(1,"second detach result for child 1 is: %d\n",detachResult);

    detachResult = detach(pidChild2);
    printf(1,"second detach result for child 2 is: %d\n",detachResult);

    detachResult = detach(pidChild3);
    printf(1,"second detach result for child 3 is: %d\n",detachResult);

    detachResult = detach(pidChild4);
    printf(1,"second detach result for child 4 is: %d\n",detachResult);

    detachResult = detach(pidChild5);
    printf(1,"second detach result for child 5 is: %d\n",detachResult);

    detachResult = detach(pidChild6);
    printf(1,"second detach result for child 6 is: %d\n",detachResult);

    detachResult = detach(44);
    printf(1,"detach result for not my child is: %d\n",detachResult);
    
    sleep(secToWait * 2);

    if(wait(null) != -1){
        printf(1,"Succeded in waiting for a child, possible detach error\n");
    }
    else{
        printf(1,"no child left to wait for\n");
    }

    exit(0);

}


