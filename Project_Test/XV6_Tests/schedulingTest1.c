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
void executeTimes(int timeToSleep,int numberOfLoops,char* debugString);

int main(int argc, char *argv[]){  
    
    printf(1,"Initiating scheduling test, test should take approximately 30000 time quantums !!!\n");
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

    childPid1 = executeForever(40,"childPid1");
    childPid2 = executeForever(1,"childPid2");
    childPid3 = executeForever(2,"childPid3");
    childPid4 = executeForever(0,"childPid4");
    childPid5 = executeForever(1000,"childPid5");
    childPid6 = executeForever(10000,"childPid6");
    childPid7 = executeForever(40,"childPid7");
    childPid8 = executeForever(100,"childPid8");
    childPid9 = executeForever(4,"childPid9");
    childPid10 = executeForever(400,"childPid10");
    childPid11 = executeForever(7,"childPid11");
    childPid12 = executeForever(20000,"childPid12");
    childPid13 = executeForever(4567,"childPid13");
    childPid14 = executeForever(200,"childPid14");
    childPid15 = executeForever(10,"childPid15");

    executeTimes(400,50,"childPid16");
    executeTimes(4,50,"childPid17");
    executeTimes(100,100,"childPid18");
    executeTimes(500,10,"childPid19");
    executeTimes(1000,15,"childPid20");
    executeTimes(2000,2,"childPid21");
    executeTimes(40,22,"childPid22");
    executeTimes(400,40,"childPid23");
    executeTimes(4000,5,"childPid24");
    executeTimes(10,5,"childPid25");
    executeTimes(5,1,"childPid26");
    executeTimes(300,30,"childPid27");
    executeTimes(2000,5,"childPid28");
    executeTimes(200,20,"childPid29");
    executeTimes(100,70,"childPid30");
    executeTimes(200,90,"childPid31");
    executeTimes(1000,18,"childPid32");
    executeTimes(20,400,"childPid33");
    executeTimes(40,200,"childPid34");
    executeTimes(90,150,"childPid35");
    executeTimes(9,80,"childPid36");
    executeTimes(1,140,"childPid37");
    executeTimes(300,60,"childPid38");
    executeTimes(90,50,"childPid39");
    executeTimes(200,30,"childPid40");
    executeTimes(40,5,"childPid41");
    executeTimes(2000,2,"childPid42");

    sleep(25000);

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

void executeTimes(int timeToSleep,int numberOfLoops,char* debugString){
    int pid;

    if((pid = fork()) == 0){
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
        detach(pid);
    }
    else{
        printf(1,"fork failed\n");
    }
}
