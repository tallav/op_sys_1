#include "../../param.h"
#include "../../types.h"
#include "../../stat.h"
#include "../../user.h"
#include "../../fs.h"
#include "../../fcntl.h"
#include "../../syscall.h"
#include "../../traps.h"
#include "../../memlayout.h"

void execute(char * command, char** args);

int main(int argc, char *argv[]){
    char * command;
    char *args[4];

    printf(1,"removing helloWorld from bin\n");
    args[0] = "/rm";
    args[1] = "/bin/helloW";
    args[2] = 0;
    command = "/rm";
    execute(command,args);

    exit(0);
}

void execute(char * command, char** args){
    int pid;

    if((pid = fork()) == 0){
        exec(command, args);
        printf(1, "exec %s failed\n", command);
    }
    else if(pid > 0){
        //printf(1,"waiting for exec of %s to finish\n",command);
        wait(null);
        //printf(1,"%s exec exited\n",command);
    }
    else{
        printf(1,"fork failed\n");
    }

}
