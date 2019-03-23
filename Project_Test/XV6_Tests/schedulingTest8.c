#include "../../param.h"
#include "../../types.h"
#include "../../stat.h"
#include "../../user.h"
#include "../../fs.h"
#include "../../fcntl.h"
#include "../../syscall.h"
#include "../../traps.h"
#include "../../memlayout.h"

#define DEBUG 0

char* j;

int executePriority(int thePriority,long long times,char* debugString);

int main(int argc, char *argv[]){  
    int numberOfEexecutes = 10;

    policy(3);

    for(int i = 0;i < numberOfEexecutes;i++){
        executePriority(1,999999,"Priority One\n");
    }

    for(int i = 0;i < numberOfEexecutes;i++){
        executePriority(9,999999,"Priority Two\n");
    }

    for(int i = 0;i < numberOfEexecutes * 2;i++){
        wait(null);
    }

    printf(1,"\n");

    exit(0);
}

int executePriority(int thePriority,long long times,char* debugString){
    int pid;

    if((pid = fork()) == 0){
        if(DEBUG){
            printf(1,debugString);
            printf(1," starting...\n");
        }

        priority(thePriority);
        for(int i = 0;i < times;i++){
            j = malloc(sizeof(char) * 100);
            free(j);
        }

        if(DEBUG){
            printf(1,debugString);
            printf(1," ending...\n");
        }

        printf(1,"%d",thePriority);

        exit(0);
    }
    else if(pid > 0){
        return pid;
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
}

