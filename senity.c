// Shell.
#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(void)
{
	pid_t pid;
	int status;
	int first_status;
	int second_status;
	int third_status;

	pid = fork(); // the child pid is 99
	if(pid > 0) {
		first_status = detach(pid); // status = 0
		printf(1, "first_status: \n", first_status);
		second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
		printf(1, "second_status: \n", second_status);
		third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
		printf(1, "third_status: \n", third_status);
	}
	wait(&status);
	exit(0);
}