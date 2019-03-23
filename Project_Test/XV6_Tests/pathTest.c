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
    int fd;
    int writed;

    printf(1,"opening path\n");
    fd = open("/path",O_WRONLY);

    if(fd < 0){
        printf(1,"Error in opening path file\n");
        exit(0);
    }

    const char * path = "/:/bin/:/hello/world/path/:/under/world/path";
    
    printf(1,"writing to path\n");
    writed = write(fd,path,strlen(path));
    
    if(writed != strlen(path)){
        printf(1,"error in writing to path, %d were written\n",writed);
    }

    printf(1,"closing path file\n");
    close(fd);
    
    char * command;
    char *args[4];

    printf(1,"creating /bin/ path\n");
    args[0] = "/mkdir";
    args[1] = "/bin/";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);
    
    printf(1,"creating /hello path\n");
    args[0] = "/mkdir";
    args[1] = "/hello";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"creating /hello/world path\n");
    args[0] = "/mkdir";
    args[1] = "/hello/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"creating /hello/world/path path\n");
    args[0] = "/mkdir";
    args[1] = "/hello/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"creating /under path\n");
    args[0] = "/mkdir";
    args[1] = "/under";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"creating /under/world path\n");
    args[0] = "/mkdir";
    args[1] = "/under/world";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"creating /under/world/path path\n");
    args[0] = "/mkdir";
    args[1] = "/under/world/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"creating /notIn path\n");
    args[0] = "/mkdir";
    args[1] = "/notIn";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"creating /notIn/path path\n");
    args[0] = "/mkdir";
    args[1] = "/notIn/path";
    args[2] = 0;
    command = "/mkdir";
    execute(command,args);

    printf(1,"exiting\n");

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
