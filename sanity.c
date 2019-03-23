// Shell.
#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv)
{
	if(argc < 2){
		int pid;
		int status;
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
		wait(&status);
		exit(0);
	}
	
	int testNum = atoi(argv[1]);
	switch(testNum){
	case 1:
        int pid = fork();
        if (pid == 0) {
            sleep(300);
            exit(5);
        }
        else {
            int status;
            wait(&status);
            printf(1, "exit status after is %d\n", status);
        }
		exit(0);
	case 2:
		int pid;
		pid = fork(); 
		if(pid == 0){ /*child code*/
			printf(1, "child process\n");
		}else{ /*parent code*/
			wait(0);
		}
		exit(0);
	}
}
