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
    int childExit1;
    int childExit2;
    int childExit3;
    int childExit4;
    int childExit5;
    int childExit6;
    int secToWait = 100;

    if(fork() == 0){
        sleep(secToWait);
        exit(1);
    }
    wait(&childExit1);
    printf(1,"1 child exit status is: %d\n",childExit1);

    if(fork() == 0){
        sleep(secToWait);
        exit(2);
    }
    wait(&childExit2);
    printf(1,"2 child exit status is: %d\n",childExit2);

    if(fork() == 0){
        sleep(secToWait);
        exit(3);
    }
    wait(&childExit3);
    printf(1,"3 child exit status is: %d\n",childExit3);

    if(fork() == 0){
        sleep(secToWait);
        exit(4);
    }
    wait(&childExit4);
    printf(1,"4 child exit status is: %d\n",childExit4);

    if(fork() == 0){
        sleep(secToWait);
        exit(5);
    }
    wait(&childExit5);
    printf(1,"5 child exit status is: %d\n",childExit5);

    if(fork() == 0){
        sleep(secToWait);
        exit(6);
    }
    wait(&childExit6);
    printf(1,"6 child exit status is: %d\n",childExit6);

    if(fork() == 0){
        sleep(secToWait);
        exit(7);
    }
    wait(null);
    printf(1,"7 child exit status is unknown\n");

    exit(0);

}


