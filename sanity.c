#include "types.h"
#include "user.h"
#include "fcntl.h"

struct perf {
    int ctime;                     // Creation time
    int ttime;                     // Termination time
    int stime;                     // The total time spent in the SLEEPING state
    int retime;                    // The total time spent in the RUNNABLE state
    int rutime;                    // The total time spent in the RUNNING state
};

void testExitWait(){
    printf(1, "----------test exit wait started\n");
    int status;
    int pid;
    for (int i = 0; i < 5; i++) {
        pid = fork();
        if (pid > 0) {
            wait(&status);
            kill(pid);
            printf(1, "process with pid %d exited with status %d\n", pid, status);
        } else {
            sleep(5);
            exit(i);
        }
    }
    printf(1, "----------test exit wait ended\n");
}

void testDetach(){
    printf(1, "----------test detach started\n");
    int pid;
    int first_status;
    int second_status;
    int third_status;
    
    pid = fork(); 
    if(pid > 0) {
        first_status = detach(pid); // status = 0
        printf(1, "first_status: %d\n", first_status);
        second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
        printf(1, "second_status: %d\n", second_status);
        third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
        printf(1, "third_status: %d\n", third_status);
    }
    kill(pid);
    sleep(10);
    printf(1, "----------test detach ended\n");
}

void printPerf(struct perf *performance) {
    printf(1, "pref:\n");
    printf(1, "\tctime: %d\n", performance->ctime);
    printf(1, "\tttime: %d\n", performance->ttime);
    printf(1, "\tstime: %d\n", performance->stime);
    printf(1, "\tretime: %d\n", performance->retime);
    printf(1, "\trutime: %d\n", performance->rutime);
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
}

void testWaitStat(){
    printf(1, "----------test wait_stat started\n");
    int status;
    struct perf perf;
    int pid;
    for (int i = 0; i < 3; i++) {
        pid = fork();
        if (pid > 0) {
            wait_stat(&status, &perf);
            printf(1, "process with pid %d exited with status %d\n", pid, status);
            kill(pid);
            printPerf(&perf);
        } else {
            sleep(5);
            exit(i);
        }
    }
    printf(1, "----------test wait_stat ended\n");
}

void testPolicy(int policyNum) {
    printf(1, "----------test policy %d started\n", policyNum);
    policy(policyNum);
    int pid1;
    struct perf perf2;
    pid1 = fork();
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf2);
        printPerf(&perf2);
    } else {
        for (int a = 0; a < 100; ++a) {
            int pid;
            struct perf perf1;
            pid = fork();
            if (pid > 0) {
                int status;
                sleep(5);
                wait_stat(&status, &perf1);
            } else {
                int pr = a % 11;
                if(pr == 0 && policyNum == 2)
                    pr = 1;
                priority(pr);
                int sum = 0;
                for (int i = 0; i < 5000000; ++i) {
                    for (int j = 0; j < 5000000; ++j) {
                        sum += i*j;
                    }
                }
                sleep(5);
                exit(0);
            }
        }
        exit(0);
    }
}

int procCalculate(int x) {
    int sum = 0;
    for (int i = 0; i < x; ++i) {
        for (int j = 0; j < x; ++j) {
            sum += i*j;
        }
        exit(0);
    }
    return sum;
}

void testPerf(int policyNum){
    printf(1, "----------test preformance %d started\n", policyNum);
    policy(policyNum);
    int nProcs = 10;
    
    int pid1 = fork();
    if (pid1 > 0) {
        int status1;
        wait(&status1);
    }else{
        // low priority process
        int pid3 = fork();
        if (pid3 > 0) {
            int status3;
            struct perf perf3;
            sleep(10);
            wait_stat(&status3, &perf3);
            printf(1, "low priority process\n");
            printPerf(&perf3);
            exit(0);
        }else{
            for (int i = 0; i < nProcs; i++){
                int pid_5 = fork();
                if (pid_5 > 0) {
                    int status_5;
                    sleep(10);
                    wait(&status_5);
                } else {
                    priority(10);
                    int sum = procCalculate(1000000000);
                    exit(sum);
                }
            }
        }
        // medium priority processes
        int pid5 = fork();
        if (pid5 > 0) {
            int status5;
            sleep(10);
            wait(&status5);
            exit(0);
        }else{
            for (int i = 0; i < nProcs; i++){
                int pid_5 = fork();
                if (pid_5 > 0) {
                    int status_5;
                    sleep(10);
                    wait(&status_5);
                } else {
                    priority(5);
                    int sum = procCalculate(1000000000);
                    exit(sum);
                }
            }
        }
        // high priority process
        int pid2 = fork();
        if (pid2 > 0) {
            int status2;
            struct perf perf2;
            sleep(10);
            wait_stat(&status2, &perf2);
            printf(1, "high priority process\n");
            printPerf(&perf2);
            exit(0);
        }else{
            for (int i = 0; i < nProcs; i++){
                int pid_5 = fork();
                if (pid_5 > 0) {
                    int status_5;
                    sleep(10);
                    wait(&status_5);
                } else {
                    if(policyNum == 3)
                        priority(0);
                    else
                        priority(1);
                    int sum = procCalculate(1000000000);
                    exit(sum);
                }
            }
        }
        exit(0);
    }
}

int main(int argc, char **argv){
	/*if(argc < 2){
		printf(1, "argv missing\n");
		exit(0);
	}*/
	char* arg = argv[1];
	if(strcmp(arg, "exit") == 0)
		testExitWait();
	else if(strcmp(arg, "detach") == 0)
		testDetach();
	else if(strcmp(arg, "wait_stat") == 0)
		testWaitStat();
	else if(strcmp(arg, "policy1") == 0)
		testPolicy(1);
	else if(strcmp(arg, "policy2") == 0)
		testPolicy(2);
	else if(strcmp(arg, "policy3") == 0)
		testPolicy(3);
    else if(strcmp(arg, "perf1") == 0)
		testPerf(1);
	else if(strcmp(arg, "perf2") == 0)
		testPerf(2);
	else if(strcmp(arg, "perf3") == 0)
		testPerf(3);
	else{
        testExitWait();
        testDetach();
        testWaitStat();
        testPolicy(1);
        testPolicy(2);
        testPolicy(3);
    }
    exit(0);
}
