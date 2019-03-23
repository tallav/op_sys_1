// Shell.
#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv)
{
	int pid;
	int status;
	
	if(argc < 2){
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
		exit(0);
	}
	
	int testNum = atoi(argv[1]);
	switch(testNum){
	case 1:
        pid = fork();
        if (pid == 0) {
            sleep(300);
            exit(5);
        }
        else {
            wait(&status);
            printf(1, "exit status after is %d\n", status);
        }
		exit(0);
		
	case 2:
		pid = fork();
        if (pid == 0) {
            exit(5);
        }
        else {
            wait(&status);
            printf(1, "exit status after is %d\n", status);
        }
		exit(0);
		
	case 3:
		pid = fork(); 
		if(pid == 0){ /*child code*/
			printf(1, "child process\n");
		}else{ /*parent code*/
			wait(0);
		}
		exit(0);
	}
}
