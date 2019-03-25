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
#define NUM_OF_CHILDS 7

struct perf {
    int ctime;
    int ttime;
    int stime;
    int retime;
    int rutime;
};



int executeForever(int timeToSleep,int isDetach,char* debugString);
int executeTimes(int timeToSleep,int numberOfLoops,int isDetach,char* debugString);
void retrieveNextChildPerf();
int getChildNum(int pid);
void print_perf(struct perf performance);
void print_all_perfs();

int executePriority(int thePriority,long long times,char* debugString);

int numOfNotForeverChilds = 5;

int childPids[NUM_OF_CHILDS];

struct perf childPerfs[NUM_OF_CHILDS];

struct perf perf_temp;

int main(int argc, char *argv[]){  
    policy(1);

    printf(1,"Initiating scheduling test, test should take approximately 10000 time quantums !!!\n");
    
    childPids[0] = executeForever(0,0,"childPid0");
    childPids[1] = executeForever(0,0,"childPid1");

    childPids[2] = executeTimes(10,100,0,"childPid2");
    childPids[3] = executeTimes(10,300,0,"childPid3");
    childPids[4] = executeTimes(10,500,0,"childPid4");
    childPids[5] = executeTimes(10,700,0,"childPid5");
    childPids[6] = executeTimes(10,900,0,"childPid6");
    
     for(int i = 0;i < numOfNotForeverChilds;i++){
         retrieveNextChildPerf();
     }

    kill(childPids[0]);
    kill(childPids[1]);
    
   for(int i = 0;i < (NUM_OF_CHILDS - numOfNotForeverChilds);i++){
         retrieveNextChildPerf();
     }

    if(childPerfs[1].ctime < childPerfs[0].ctime){
        printf(1,"error in ctime test 1\n");
    }
    else{
        printf(1,"ctime test 1 ok\n");
    }

    if(childPerfs[2].ctime < childPerfs[1].ctime){
        printf(1,"error in ctime test 2\n");
    }
    else{
        printf(1,"ctime test 2 ok\n");
    }

    if(childPerfs[3].ctime < childPerfs[2].ctime){
        printf(1,"error in ctime test 3\n");
    }
    else{
        printf(1,"ctime test 3 ok\n");
    }

    if(childPerfs[4].ctime < childPerfs[3].ctime){
        printf(1,"error in ctime test 4\n");
    }
    else{
        printf(1,"ctime test 4 ok\n");
    }

    if(childPerfs[6].ctime < childPerfs[5].ctime){
        printf(1,"error in ctime test 5\n");
    }
    else{
        printf(1,"ctime test 5 ok\n");
    }

    // ------------------------------------------------------------------------------------------------------------------------
















    
    // ------------------------------------------------------------------------------------------------------------------------

    if(childPerfs[1].stime != childPerfs[0].stime){
        printf(1,"error in stime test 1\n");
    }
    else{
        printf(1,"stime test 1 ok\n");
    }

    if(childPerfs[2].stime < childPerfs[1].stime){
        printf(1,"error in stime test 2\n");
    }
    else{
        printf(1,"stime test 2 ok\n");
    }

    if(childPerfs[3].stime < childPerfs[2].stime){
        printf(1,"error in stime test 3\n");
    }
    else{
        printf(1,"stime test 3 ok\n");
    }

    if(childPerfs[4].stime < childPerfs[3].stime){
        printf(1,"error in stime test 4\n");
    }
    else{
        printf(1,"stime test 4 ok\n");
    }

    if(childPerfs[6].stime < childPerfs[5].stime){
        printf(1,"error in stime test 5\n");
    }
    else{
        printf(1,"stime test 5 ok\n");
    }
 
    // ------------------------------------------------------------------------------------------------------------------------
















    
    // ------------------------------------------------------------------------------------------------------------------------

    if(childPerfs[0].rutime < childPerfs[2].rutime){
        printf(1,"error in rutime test 1\n");
    }
    else{
        printf(1,"rutime test 1 ok\n");
    }

    if(childPerfs[0].rutime < childPerfs[3].rutime){
        printf(1,"error in rutime test 2\n");
    }
    else{
        printf(1,"rutime test 2 ok\n");
    }

    if(childPerfs[0].rutime < childPerfs[4].rutime){
        printf(1,"error in rutime test 3\n");
    }
    else{
        printf(1,"rutime test 3 ok\n");
    }

    if(childPerfs[0].rutime < childPerfs[5].rutime){
        printf(1,"error in rutime test 4\n");
    }
    else{
        printf(1,"rutime test 4 ok\n");
    }

    if(childPerfs[0].rutime  < childPerfs[6].rutime){
        printf(1,"error in rutime test 5\n");
    }
    else{
        printf(1,"rutime test 5 ok\n");
    }

    // ------------------------------------------------------------------------------------------------------------------------
















    
    // ------------------------------------------------------------------------------------------------------------------------

    if((childPerfs[0].rutime + childPerfs[0].retime + childPerfs[0].stime) > (childPerfs[0].ttime - childPerfs[0].ctime + 20)){
        printf(1,"error in ttime test 1\n");
    }
    else{
        printf(1,"ttime test 1 ok\n");
    }

    if((childPerfs[1].rutime + childPerfs[1].retime + childPerfs[1].stime) > (childPerfs[1].ttime - childPerfs[1].ctime + 20)){
        printf(1,"error in ttime test 2\n");
    }
    else{
        printf(1,"ttime test 2 ok\n");
    }

    if((childPerfs[2].rutime + childPerfs[2].retime + childPerfs[2].stime) > (childPerfs[2].ttime - childPerfs[2].ctime + 20)){
        printf(1,"error in ttime test 3\n");
    }
    else{
        printf(1,"ttime test 3 ok\n");
    }

    if((childPerfs[3].rutime + childPerfs[3].retime + childPerfs[3].stime) > (childPerfs[3].ttime - childPerfs[3].ctime + 20)){
        printf(1,"error in ttime test 4\n");
    }
    else{
        printf(1,"ttime test 4 ok\n");
    }

    if((childPerfs[4].rutime + childPerfs[4].retime + childPerfs[4].stime) > (childPerfs[4].ttime - childPerfs[4].ctime + 20)){
        printf(1,"error in ttime test 5\n");
    }
    else{
        printf(1,"ttime test 5 ok\n");
    }
    
    if((childPerfs[5].rutime + childPerfs[5].retime + childPerfs[5].stime) > (childPerfs[5].ttime - childPerfs[5].ctime + 20)){
        printf(1,"error in ttime test 6\n");
    }
    else{
        printf(1,"ttime test 6 ok\n");
    }

    if((childPerfs[6].rutime + childPerfs[6].retime + childPerfs[6].stime) > (childPerfs[6].ttime - childPerfs[6].ctime + 20)){
        printf(1,"error in ttime test 7\n");
    }
    else{
        printf(1,"ttime test 7 ok\n");

    }

    exit(0);
}


int executeForever(int timeToSleep,int isDetach,char* debugString){
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

void retrieveNextChildPerf(){
    int pid;
    int childNum;

    pid = wait_stat(null,&perf_temp);
    childNum = getChildNum(pid);

    if(childNum != -1){
        childPerfs[childNum].ctime = perf_temp.ctime;
        childPerfs[childNum].ttime = perf_temp.ttime;
        childPerfs[childNum].stime = perf_temp.stime;
        childPerfs[childNum].retime = perf_temp.retime;
        childPerfs[childNum].rutime = perf_temp.rutime;
    }
    else{
        printf(1,"couldn't find child num in retrieveNextChildPerf\n");
    }
}

int getChildNum(int pid){

    for(int i = 0;i < NUM_OF_CHILDS;i++){
        if(childPids[i] == pid){
            return i;
        }
    }

    return -1;
}

void print_perf(struct perf performance){
    printf(1,"----------------------------------------------------\n");
    printf(1,"ctime = %d\n",performance.ctime);
    printf(1,"ttime = %d\n",performance.ttime);
    printf(1,"stime = %d\n",performance.stime);
    printf(1,"retime = %d\n",performance.retime);
    printf(1,"rutime = %d\n",performance.rutime);
    printf(1,"----------------------------------------------------\n");
}

void print_all_perfs(){
    for(int i = 0;i < NUM_OF_CHILDS;i++){
        print_perf(childPerfs[i]);
    }
}


