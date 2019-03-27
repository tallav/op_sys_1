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
    for (int i = 0; i < 5; i++) {
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
	policy(policyNum);
	int nProcs = 10;
    int pid;
	int status;
    for (int i = 0; i < nProcs; i++) {
        pid = fork();
        if (pid < 0) {
			printf(1, "fork failed\n");
            break;
        } else if (pid == 0) {
			int pr = i % 10;
			if(pr == 0 && policyNum != 3)
				pr = 1;
			priority(pr);
            sleep(10);
            exit(0);
        }
		kill(pid);
    }
    for (int j = 0; j < nProcs; j++) {
        wait(&status);
    }
}
	
void testPerf(int policyNum){
    printf(1, "----------test policy %d started\n", policyNum);
    policy(policyNum);
	int nProcs = 10;
    int pid1;
    struct perf perf1;
    
    pid1 = fork();
    if (pid1 > 0) {
        int status1;
        wait_stat(&status1, &perf1);
        printPerf(&perf1);
		kill(pid1);
    } else {
        for (int i = 0; i < nProcs; i++) {
            int pid2;
            struct perf perf2;
            pid2 = fork();
            if (pid2 > 0) {
                int status2;
                sleep(5);
                wait_stat(&status2, &perf2);
				kill(pid2);
            } else {
                int pr = i % 10;
				if(pr == 0 && policyNum != 3)
					pr = 1;
				priority(pr);
                int sum = 0;
                for (int k = 0; k < 1000000; k++) {
                    for (int j = 0; j < 1000000; j++) {
                        sum++;
                    }
                }
                sleep(5);
                exit(0);
            }
        }
        exit(0);
    }
}

boolean testStarvation(int npolicy, int npriority) {
    boolean result = true;
    policy(npolicy);
    int NPROC = 10;
    int pid_arr[NPROC];
    int pid;
    memset(&pid_arr, 0, NPROC * sizeof(int));
    for (int i = 0; i < NPROC; ++i) {
        pid = fork();
        if (pid == 0) {
            sleep(5);
            priority(npriority);
            for (;;) {};
        } else {
            pid_arr[i] = pid;
        }
    }
    sleep(100);
      
    //struct proc *p;
    
    //for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
     //   printf(1,"pid %d state",p->pid);
   // }
    
    procdump();
    
    for (int j = 0; j < NPROC; ++j) {
        if (pid_arr[j] != 0) {
           kill(pid_arr[j]);
            wait(null);
        }
    }
    policy(1);
    return result;
}



int main(int argc, char **argv){
	/*if(argc < 2){
		printf(1, "argv missing\n");
		exit(0);
	}*/
	/*char* arg = argv[1];
	if(strcmp(arg, "exit") == 0)
		testExitWait();
	else if(strcmp(arg, "detach") == 0)
		testDetach();
	else if(strcmp(arg, "wait_stat") == 0)
		testWaitStat();
	else if(strcmp(arg, "policy1") == 0)
		testPerf(1);
	else if(strcmp(arg, "policy2") == 0)
		testPerf(2);
	else if(strcmp(arg, "policy3") == 0)
		testPerf(3);
	else{
        testExitWait();
		testDetach();
		testWaitStat();
		testPerf(1);
		testPerf(2);
        testPerf(3);*/
        /*
        testPolicy(1);
        testPolicy(2);
        testPolicy(3);
        */
        testStarvation(2, 1);
           
    
        exit(0);
}
