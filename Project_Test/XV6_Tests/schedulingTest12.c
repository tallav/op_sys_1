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

int executeForever(int timeToSleep,char* debugString);
int executeTimes(int timeToSleep,int numberOfLoops,int isDetach,char* debugString);

int executePriority(int thePriority,long long times,char* debugString);

int main(int argc, char *argv[]){  
    policy(3);

    printf(1,"Initiating scheduling test, test should take approximately 15000 time quantums !!!\n");
    int childPid1;
    int childPid2;
    int childPid3;
    int childPid4;
    int childPid5;
    int childPid6;
    int childPid7;
    int childPid8;
    int childPid9;
    int childPid10;
    int childPid11;
    int childPid12;
    int childPid13;
    int childPid14;
    int childPid15;
    
    childPid1 = executeForever(0,"childPid1");
    childPid2 = executeForever(0,"childPid2");
    childPid3 = executeForever(0,"childPid3");
    childPid4 = executeForever(0,"childPid4");
    childPid5 = executeForever(1000,"childPid5");
    childPid6 = executeForever(10000,"childPid6");
    childPid7 = executeForever(0,"childPid7");
    childPid8 = executeForever(0,"childPid8");
    childPid9 = executeForever(0,"childPid9");
    childPid10 = executeForever(0,"childPid10");
    childPid11 = executeForever(0,"childPid11");
    childPid12 = executeForever(20000,"childPid12");
    childPid13 = executeForever(4567,"childPid13");
    childPid14 = executeForever(0,"childPid14");
    childPid15 = executeForever(0,"childPid15");

    executeTimes(20,400,0,"childPid16");
    executeTimes(10,600,0,"childPid17");
    executeTimes(60,100,0,"childPid18");
    executeTimes(1000,12,0,"childPid19");
    executeTimes(200,10,0,"childPid20");
    
    sleep(2000);

    policy(2);

    wait(null);
    wait(null);
    wait(null);
    wait(null);
    wait(null);

    kill(childPid1);
    kill(childPid2);
    kill(childPid3);
    kill(childPid4);
    kill(childPid5);
    kill(childPid6);
    kill(childPid7);
    kill(childPid8);
    kill(childPid9);
    kill(childPid10);
    kill(childPid11);
    kill(childPid12);
    kill(childPid13);
    kill(childPid14);
    kill(childPid15);

    sleep(2000);

    exit(0);
}


int executeForever(int timeToSleep,char* debugString){
    int pid;

    if((pid = fork()) == 0){
        priority(0);
        if(DEBUG){
            printf(1,debugString);
            printf(1," starting...\n");
        }

        while(1){
            if(timeToSleep){   
                sleep(timeToSleep);   
            }
        }

        if(DEBUG){
            printf(1,debugString);
            printf(1," ending...\n");
        }

        exit(0);
    }
    else if(pid > 0){
        detach(pid);
        return pid;
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
}

int executeTimes(int timeToSleep,int numberOfLoops,int isDetach,char* debugString){
    int pid;

    if((pid = fork()) == 0){
        priority(4);

        if(DEBUG){
            printf(1,debugString);
            printf(1," starting...\n");
        }

        sleep(1000);
        for(int i = 0;i < numberOfLoops;i++){
            sleep(timeToSleep);
        }

        if(DEBUG){
            printf(1,debugString);
            printf(1," ending...\n");
        }

        exit(0);
    }
    else if(pid > 0){
        if(isDetach){
            detach(pid);        
        }
        return pid;
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
}